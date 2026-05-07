[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

$ErrorActionPreference = "Stop"

$ProjectRoot = "F:\Unity6_AI"
$CurrentTaskPath = Join-Path $ProjectRoot "Logs\ClaudeRelay\current-task.json"
$NoTaskMessage = -join ([char[]]@(
    0x6682, 0x65E0, 0x0020, 0x0043, 0x006C, 0x0061, 0x0075,
    0x0064, 0x0065, 0x0020, 0x0043, 0x006F, 0x0064, 0x0065,
    0x0020, 0x0072, 0x0065, 0x006C, 0x0061, 0x0079, 0x0020,
    0x4EFB, 0x52A1
))
$NoOutputMessage = -join ([char[]]@(0x6682, 0x65E0, 0x8F93, 0x51FA, 0x65E5, 0x5FD7, 0x3002))
$NoSessionMessage = -join ([char[]]@(0x0028, 0x672A, 0x6307, 0x5B9A, 0x0029))
$UnknownMessage = -join ([char[]]@(0x0028, 0x672A, 0x77E5, 0x0029))
$LabelPrompt = -join ([char[]]@(0x5F53, 0x524D, 0x4EFB, 0x52A1, 0xFF1A))
$LabelSession = -join ([char[]]@(0x76EE, 0x6807, 0x4F1A, 0x8BDD, 0xFF1A))
$LabelWorkspace = -join ([char[]]@(0x0077,0x006F,0x0072,0x006B,0x0073,0x0070,0x0061,0x0063,0x0065,0xFF1A))
$LabelGit = -join ([char[]]@(0x0067,0x0069,0x0074,0xFF1A))
$LabelStarted = -join ([char[]]@(0x5F00, 0x59CB, 0x65F6, 0x95F4, 0xFF1A))
$LabelStatus = -join ([char[]]@(0x72B6, 0x6001, 0xFF1A))
$LabelExitCode = -join ([char[]]@(0x9000, 0x51FA, 0x7801, 0xFF1A))
$LabelRecent = -join ([char[]]@(0x6700, 0x8FD1, 0x65E5, 0x5FD7, 0xFF1A))

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

function Limit-Text {
    param(
        [string]$Text,
        [int]$MaxLength
    )

    if ([string]::IsNullOrWhiteSpace($Text)) {
        return ""
    }

    $trimmed = $Text.Trim()
    if ($trimmed.Length -le $MaxLength) {
        return $trimmed
    }

    return $trimmed.Substring(0, $MaxLength) + "..."
}

Set-Location -LiteralPath $ProjectRoot

if (-not (Test-Path -LiteralPath $CurrentTaskPath)) {
    Write-Output $NoTaskMessage
    exit 0
}

try {
    $task = Get-Content -LiteralPath $CurrentTaskPath -Raw -Encoding UTF8 | ConvertFrom-Json
} catch {
    Write-Output $NoTaskMessage
    exit 0
}

$recent = ""
if ($task.summaryLog -and (Test-Path -LiteralPath $task.summaryLog)) {
    $recent = Get-Content -LiteralPath $task.summaryLog -Raw -Encoding UTF8
} elseif ($task.outputLog -and (Test-Path -LiteralPath $task.outputLog)) {
    $recent = Get-Content -LiteralPath $task.outputLog -Raw -Encoding UTF8
}
$recent = Limit-Text -Text (Redact-Secrets -Text $recent) -MaxLength 240
if ([string]::IsNullOrWhiteSpace($recent)) {
    $recent = $NoOutputMessage
}

$targetSession = if (-not [string]::IsNullOrWhiteSpace($task.sessionName)) {
    $task.sessionName
} elseif ([string]::IsNullOrWhiteSpace($task.session)) {
    $NoSessionMessage
} else {
    $task.session
}
$started = if ($task.startedAt) { $task.startedAt } else { $UnknownMessage }
$prompt = Limit-Text -Text (Redact-Secrets -Text $task.prompt) -MaxLength 80

Write-Output "$LabelPrompt$prompt"
Write-Output "$LabelSession$targetSession"
if (-not [string]::IsNullOrWhiteSpace($task.workspace)) {
    Write-Output "$LabelWorkspace$($task.workspace)"
}
if (-not [string]::IsNullOrWhiteSpace($task.gitBranch)) {
    Write-Output "$LabelGit$($task.gitBranch)"
}
Write-Output "$LabelStarted$started"
Write-Output "$LabelStatus$($task.status)"
if ($task.exitCode -ne $null) {
    Write-Output "$LabelExitCode$($task.exitCode)"
}
Write-Output "$LabelRecent$recent"
