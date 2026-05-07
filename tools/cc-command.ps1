param(
    [string]$MessageText,
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
$RunScript = Join-Path $ProjectRoot "tools\cc-run.ps1"
$UseScript = Join-Path $ProjectRoot "tools\cc-use.ps1"
$SessionScript = Join-Path $ProjectRoot "tools\cc-session.ps1"
$StatusScript = Join-Path $ProjectRoot "tools\cc-status.ps1"
$LastScript = Join-Path $ProjectRoot "tools\cc-last.ps1"
$EmptyMessage = -join ([char[]]@(
    0x8BF7, 0x5728, 0x0020, 0x002F, 0x0063, 0x0063, 0x0020, 0x540E,
    0x8F93, 0x5165, 0x8981, 0x8F6C, 0x53D1, 0x7ED9, 0x0020, 0x0043,
    0x006C, 0x0061, 0x0075, 0x0064, 0x0065, 0x0020, 0x0043, 0x006F,
    0x0064, 0x0065, 0x0020, 0x7684, 0x4EFB, 0x52A1, 0x3002
))
$EmptyUseMessage = -join ([char[]]@(
    0x8BF7, 0x5728, 0x0020, 0x002F, 0x0063, 0x0063, 0x002D, 0x0075,
    0x0073, 0x0065, 0x0020, 0x540E, 0x8F93, 0x5165, 0x0020,
    0x0043, 0x006C, 0x0061, 0x0075, 0x0064, 0x0065, 0x0020,
    0x0043, 0x006F, 0x0064, 0x0065, 0x0020, 0x0073, 0x0065,
    0x0073, 0x0073, 0x0069, 0x006F, 0x006E, 0x0020, 0x540D,
    0x79F0, 0x6216, 0x0020, 0x0049, 0x0044, 0x3002
))
$EmptyRunMessage = -join ([char[]]@(
    0x8BF7, 0x5728, 0x0020, 0x002F, 0x0063, 0x0063, 0x002D, 0x0072,
    0x0075, 0x006E, 0x0020, 0x540E, 0x8F93, 0x5165, 0x8981, 0x8F6C,
    0x53D1, 0x7ED9, 0x0020, 0x0043, 0x006C, 0x0061, 0x0075, 0x0064,
    0x0065, 0x0020, 0x0043, 0x006F, 0x0064, 0x0065, 0x0020, 0x7684,
    0x4EFB, 0x52A1, 0x3002
))
$UnknownCommandMessage = -join ([char[]]@(
    0x8BF7, 0x53D1, 0x9001, 0x0020, 0x002F, 0x0063, 0x0063, 0x3001,
    0x002F, 0x0063, 0x0063, 0x002D, 0x0072, 0x0075, 0x006E, 0x3001,
    0x002F, 0x0063, 0x0063, 0x002D, 0x0073, 0x0065, 0x0073, 0x0073,
    0x0069, 0x006F, 0x006E, 0x3001, 0x002F, 0x0063, 0x0063, 0x002D,
    0x0073, 0x0074, 0x0061, 0x0074, 0x0075, 0x0073, 0x0020, 0x6216,
    0x0020, 0x002F, 0x0063, 0x0063, 0x002D, 0x006C, 0x0061, 0x0073,
    0x0074, 0x0020, 0x547D, 0x4EE4, 0x3002
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

function Invoke-ChildScript {
    param(
        [string]$ScriptPath,
        [string[]]$Arguments
    )

    $childOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1
    $exitCode = $LASTEXITCODE
    $text = ($childOutput | ForEach-Object { $_.ToString() }) -join [Environment]::NewLine
    Write-Output (Redact-Secrets -Text $text.Trim())
    exit $exitCode
}

Set-Location -LiteralPath $ProjectRoot

if (-not [string]::IsNullOrWhiteSpace($MessageText)) {
    $trimmedMessage = $MessageText.Trim()
    if ($trimmedMessage -eq "/cc-status") {
        Invoke-ChildScript -ScriptPath $StatusScript -Arguments @()
    }
    if ($trimmedMessage -eq "/cc-last") {
        Invoke-ChildScript -ScriptPath $LastScript -Arguments @()
    }
    if ($trimmedMessage -eq "/cc-session" -or $trimmedMessage -eq "/cc-sessions") {
        Invoke-ChildScript -ScriptPath $SessionScript -Arguments @()
    }
    if ($trimmedMessage.StartsWith("/cc-use")) {
        $sessionText = $trimmedMessage.Substring(7).Trim()
        if ([string]::IsNullOrWhiteSpace($sessionText)) {
            Write-Output $EmptyUseMessage
            exit 0
        }
        Invoke-ChildScript -ScriptPath $UseScript -Arguments @("-Session", $sessionText)
    }
    if ($trimmedMessage.StartsWith("/cc-run")) {
        $runPromptText = $trimmedMessage.Substring(7).Trim()
        if ([string]::IsNullOrWhiteSpace($runPromptText)) {
            Write-Output $EmptyRunMessage
            exit 0
        }
        Invoke-ChildScript -ScriptPath $RunScript -Arguments @("-PromptText", $runPromptText)
    }
    if (-not $trimmedMessage.StartsWith("/cc")) {
        Write-Output $UnknownCommandMessage
        exit 0
    }
}

if ([string]::IsNullOrEmpty($PromptText)) {
    if ([string]::IsNullOrEmpty($MessageText)) {
        Write-Output $EmptyMessage
        exit 0
    }

    if ($MessageText.StartsWith("/cc")) {
        $PromptText = $MessageText.Substring(3)
        if ($PromptText.Length -gt 0 -and [char]::IsWhiteSpace($PromptText[0])) {
            $PromptText = $PromptText.Substring(1)
        }
    } else {
        $PromptText = $MessageText
    }
}

if ([string]::IsNullOrWhiteSpace($PromptText)) {
    Write-Output $EmptyMessage
    exit 0
}

$RelayOutput = & powershell -NoProfile -ExecutionPolicy Bypass -File $RelayScript -PromptText $PromptText -RawPassThrough 2>&1
$ExitCode = $LASTEXITCODE
$RelayText = ($RelayOutput | ForEach-Object { $_.ToString() }) -join [Environment]::NewLine
$OutputLogLine = $RelayOutput | Where-Object { $_.ToString().StartsWith("Output Log: ") } | Select-Object -Last 1

if ($OutputLogLine) {
    $OutputLog = $OutputLogLine.ToString().Substring("Output Log: ".Length)
    if (Test-Path -LiteralPath $OutputLog) {
        $ClaudeText = Get-Content -LiteralPath $OutputLog -Raw -Encoding UTF8
        Write-Output (Redact-Secrets -Text $ClaudeText.Trim())
        exit $ExitCode
    }
}

Write-Output (Redact-Secrets -Text $RelayText.Trim())
exit $ExitCode
