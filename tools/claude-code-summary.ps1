param(
    [Parameter(Mandatory = $true)]
    [string]$OutputPath,

    [Parameter(Mandatory = $true)]
    [string]$MetaPath,

    [Parameter(Mandatory = $true)]
    [string]$SummaryPath
)

[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

$ErrorActionPreference = "Stop"
$NoOutputMessage = -join ([char[]]@(
    0x0028, 0x0043, 0x006C, 0x0061, 0x0075, 0x0064, 0x0065, 0x0020,
    0x0043, 0x006F, 0x0064, 0x0065, 0x0020, 0x6CA1, 0x6709, 0x8F93,
    0x51FA, 0x5185, 0x5BB9, 0x3002, 0x0029
))
$StatusDone = -join ([char[]]@(0x72B6, 0x6001, 0xFF1A, 0x5DF2, 0x5B8C, 0x6210))
$StatusFailedPrefix = -join ([char[]]@(
    0x72B6, 0x6001, 0xFF1A, 0x6267, 0x884C, 0x5931, 0x8D25,
    0xFF0C, 0x9000, 0x51FA, 0x7801, 0x0020
))
$LabelRunId = -join ([char[]]@(0x8FD0, 0x884C, 0x0020, 0x0049, 0x0044, 0xFF1A))
$LabelDirectory = -join ([char[]]@(0x76EE, 0x5F55, 0xFF1A))
$LabelMode = -join ([char[]]@(0x6A21, 0x5F0F, 0xFF1A, 0x53EA, 0x8BFB))
$LabelModePrefix = -join ([char[]]@(0x6A21, 0x5F0F, 0xFF1A))
$LabelReadonly = -join ([char[]]@(0x53EA, 0x8BFB))
$LabelSummary = -join ([char[]]@(0x6458, 0x8981, 0xFF1A))
$LabelLogs = -join ([char[]]@(0x65E5, 0x5FD7, 0xFF1A))
$LabelOutput = -join ([char[]]@(0x8F93, 0x51FA, 0xFF1A))
$LabelMeta = -join ([char[]]@(0x5143, 0x6570, 0x636E, 0xFF1A))

function Redact-Secrets {
    param([string]$Text)

    if ($null -eq $Text) {
        return ""
    }

    $patterns = @(
        'sk-ant-[A-Za-z0-9_\-]{12,}',
        'sk-[A-Za-z0-9_\-]{12,}',
        'ANTHROPIC_AUTH_TOKEN\s*=\s*["'']?[^"''\s]+',
        'ANTHROPIC_API_KEY\s*=\s*["'']?[^"''\s]+',
        'CLAUDE_TOKEN\s*=\s*["'']?[^"''\s]+',
        'OPENAI_API_KEY\s*=\s*["'']?[^"''\s]+',
        'DEEPSEEK_API_KEY\s*=\s*["'']?[^"''\s]+',
        'FEISHU_APP_SECRET\s*=\s*["'']?[^"''\s]+',
        'appSecret"\s*:\s*"[^"]+"',
        'App Secret\s*[:=]\s*[^,\s]+'
    )

    $safe = $Text
    foreach ($pattern in $patterns) {
        $safe = [regex]::Replace($safe, $pattern, '[REDACTED_SECRET]', 'IgnoreCase')
    }
    return $safe
}

function Get-TailText {
    param(
        [string]$Text,
        [int]$MaxLength
    )

    if ([string]::IsNullOrWhiteSpace($Text)) {
        return $NoOutputMessage
    }

    $trimmed = $Text.Trim()
    if ($trimmed.Length -le $MaxLength) {
        return $trimmed
    }

    return "..." + $trimmed.Substring($trimmed.Length - $MaxLength)
}

if (-not (Test-Path -LiteralPath $OutputPath)) {
    throw "Output file not found: $OutputPath"
}
if (-not (Test-Path -LiteralPath $MetaPath)) {
    throw "Meta file not found: $MetaPath"
}

$OutputText = Get-Content -LiteralPath $OutputPath -Raw -Encoding UTF8
$Meta = Get-Content -LiteralPath $MetaPath -Raw -Encoding UTF8 | ConvertFrom-Json
$SafeTail = Redact-Secrets -Text (Get-TailText -Text $OutputText -MaxLength 1800)

if ($Meta.rawPassThrough) {
    $RawSummary = Redact-Secrets -Text (Get-TailText -Text $OutputText -MaxLength 4000)
    Set-Content -LiteralPath $SummaryPath -Value $RawSummary.Trim() -Encoding UTF8
    Write-Output $RawSummary.Trim()
    exit 0
}

$StatusLine = if ([int]$Meta.exitCode -eq 0) {
    $StatusDone
} else {
    "$StatusFailedPrefix$($Meta.exitCode)"
}
$ModeValue = if ($Meta.mode) { $Meta.mode } else { $LabelReadonly }

$Summary = @"
$StatusLine
$LabelRunId$($Meta.runId)
$LabelDirectory$($Meta.projectRoot)
$LabelModePrefix$ModeValue

$LabelSummary
$SafeTail

$LabelLogs
- $LabelOutput$($Meta.outputPath)
- $LabelMeta$($MetaPath)
"@

$Summary = Redact-Secrets -Text $Summary
Set-Content -LiteralPath $SummaryPath -Value $Summary -Encoding UTF8
Write-Output $Summary
