[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

$ErrorActionPreference = "Stop"

$ProjectRoot = "F:\Unity6_AI"
$LogRoot = Join-Path $ProjectRoot "Logs\ClaudeRelay"
$NoSummaryMessage = -join ([char[]]@(
    0x6682, 0x65E0, 0x0020, 0x0043, 0x006C, 0x0061, 0x0075,
    0x0064, 0x0065, 0x0020, 0x0043, 0x006F, 0x0064, 0x0065,
    0x0020, 0x6267, 0x884C, 0x6458, 0x8981, 0x3002
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

if (-not (Test-Path -LiteralPath $LogRoot)) {
    Write-Output $NoSummaryMessage
    exit 0
}

$latest = Get-ChildItem -LiteralPath $LogRoot -Filter "*-summary.txt" -File |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

if (-not $latest) {
    Write-Output $NoSummaryMessage
    exit 0
}

$summary = Get-Content -LiteralPath $latest.FullName -Raw -Encoding UTF8
Write-Output (Redact-Secrets -Text $summary.Trim())
