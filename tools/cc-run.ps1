param(
    [string]$PromptText
)

[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

$ErrorActionPreference = "Stop"

$ProjectRoot = "F:\Unity6_AI"
$RelayScript = Join-Path $ProjectRoot "tools\claude-code-relay.ps1"
$EmptyRunMessage = -join ([char[]]@(
    0x8BF7, 0x5728, 0x0020, 0x002F, 0x0063, 0x0063, 0x002D, 0x0072,
    0x0075, 0x006E, 0x0020, 0x540E, 0x8F93, 0x5165, 0x8981, 0x8F6C,
    0x53D1, 0x7ED9, 0x0020, 0x0043, 0x006C, 0x0061, 0x0075, 0x0064,
    0x0065, 0x0020, 0x0043, 0x006F, 0x0064, 0x0065, 0x0020, 0x7684,
    0x4EFB, 0x52A1, 0x3002
))

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

Set-Location -LiteralPath $ProjectRoot

if ([string]::IsNullOrWhiteSpace($PromptText)) {
    Write-Output $EmptyRunMessage
    exit 0
}

$RelayOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $RelayScript -PromptText $PromptText -AllowEdit 2>&1
$ExitCode = $LASTEXITCODE
$RelayText = ($RelayOutput | ForEach-Object { $_.ToString() }) -join [Environment]::NewLine
$SummaryLogLine = $RelayOutput | Where-Object { $_.ToString().StartsWith("Summary Log: ") } | Select-Object -Last 1

if ($SummaryLogLine) {
    $SummaryLog = $SummaryLogLine.ToString().Substring("Summary Log: ".Length)
    if (Test-Path -LiteralPath $SummaryLog) {
        $SummaryText = Get-Content -LiteralPath $SummaryLog -Raw -Encoding UTF8
        Write-Output (Redact-Secrets -Text $SummaryText.Trim())
        exit $ExitCode
    }
}

Write-Output (Redact-Secrets -Text $RelayText.Trim())
exit $ExitCode
