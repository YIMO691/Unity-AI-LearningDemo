$ErrorActionPreference = "Continue"
[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

function Write-Section {
    param([string]$Title)
    Write-Output ""
    Write-Output "===== $Title ====="
}

function Redact-Secrets {
    param([string[]]$Lines)

    $patterns = @(
        'sk-[A-Za-z0-9_\-]{12,}',
        'sk-ant-[A-Za-z0-9_\-]{12,}',
        'ANTHROPIC_AUTH_TOKEN\s*=\s*["'']?[^"''\s]+',
        'OPENAI_API_KEY\s*=\s*["'']?[^"''\s]+',
        'DEEPSEEK_API_KEY\s*=\s*["'']?[^"''\s]+',
        'appSecret"\s*:\s*"[^"]+"',
        'App Secret\s*[:=]\s*[^,\s]+',
        'FEISHU_APP_SECRET\s*=\s*["'']?[^"''\s]+'
    )

    foreach ($line in $Lines) {
        $safe = $line
        foreach ($p in $patterns) {
            $safe = [regex]::Replace($safe, $p, '[REDACTED_SECRET]')
        }
        Write-Output $safe
    }
}

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptRoot
Set-Location $ProjectRoot
$NoLocalUnityLogsMessage = -join ([char[]]@(
    0x672A, 0x627E, 0x5230, 0x9879, 0x76EE, 0x672C, 0x5730, 0x0020,
    0x0055, 0x006E, 0x0069, 0x0074, 0x0079, 0x0020, 0x65E5, 0x5FD7,
    0xFF0C, 0x8BF7, 0x5148, 0x8FD0, 0x884C, 0x0020, 0x0055, 0x006E,
    0x0069, 0x0074, 0x0079, 0x0020, 0x6D4B, 0x8BD5, 0x6216, 0x6784,
    0x5EFA, 0x751F, 0x6210, 0x0020, 0x004C, 0x006F, 0x0067, 0x0073,
    0x0020, 0x6587, 0x4EF6, 0x3002
))

Write-Output "Unity6_AI Mobile Status Report"
Write-Output "Generated At: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Output "Project Root: $ProjectRoot"

Write-Section "Unity Project Check"
if ((Test-Path ".\Assets") -and (Test-Path ".\Packages") -and (Test-Path ".\ProjectSettings")) {
    Write-Output "Unity project structure: OK"
} elseif ((Test-Path ".\UnityProject\Assets") -and (Test-Path ".\UnityProject\Packages") -and (Test-Path ".\UnityProject\ProjectSettings")) {
    Write-Output "Unity project structure: OK (nested UnityProject/)"
} else {
    Write-Output "Warning: Unity project structure may be incomplete."
}

Write-Section "Git Branch"
try {
    git branch --show-current
} catch {
    Write-Output "Git branch unavailable."
}

Write-Section "Recent Commits"
try {
    git log --oneline -5
} catch {
    Write-Output "Git log unavailable."
}

Write-Section "Working Tree"
try {
    git status --short
} catch {
    Write-Output "Git status unavailable."
}

$ProgressPath = ".\docs\status\PROGRESS.md"
$TodoPath = ".\docs\status\TODO.md"
$DevLogPath = ".\docs\status\AI_DEV_LOG.md"

Write-Section "docs/status/PROGRESS.md"
if (Test-Path $ProgressPath) {
    Redact-Secrets -Lines (Get-Content $ProgressPath -TotalCount 120)
} else {
    Write-Output "docs/status/PROGRESS.md not found."
}

Write-Section "docs/status/TODO.md"
if (Test-Path $TodoPath) {
    Redact-Secrets -Lines (Get-Content $TodoPath -TotalCount 120)
} else {
    Write-Output "docs/status/TODO.md not found."
}

Write-Section "docs/status/AI_DEV_LOG.md"
if (Test-Path $DevLogPath) {
    Redact-Secrets -Lines (Get-Content $DevLogPath -Tail 120)
} else {
    Write-Output "docs/status/AI_DEV_LOG.md not found."
}

Write-Section "Unity Logs"
$logCandidates = @(
    ".\Logs\EditModeBatch.log",
    ".\Logs\EditModeResults.xml",
    ".\Logs\UnityBatch.log"
)

$foundLocalLogs = $false
foreach ($log in $logCandidates) {
    if (Test-Path $log) {
        $foundLocalLogs = $true
        Write-Output "--- $log ---"
        try {
            Redact-Secrets -Lines (Get-Content -LiteralPath $log -Tail 80 -ErrorAction Stop)
        } catch {
            Write-Output "Unable to read log: $($_.Exception.Message)"
        }
    }
}
if (-not $foundLocalLogs) {
    Write-Output $NoLocalUnityLogsMessage
}

Write-Section "Likely Errors"
$errorPattern = 'error CS|Exception|Failed|FAIL|Compilation failed|NullReferenceException'
$scanFiles = @(
    ".\Logs\EditModeBatch.log",
    ".\Logs\EditModeResults.xml",
    ".\Logs\UnityBatch.log"
)

$foundLocalLogsForScan = $false
foreach ($file in $scanFiles) {
    if (Test-Path $file) {
        $foundLocalLogsForScan = $true
        Write-Output "--- scanning $file ---"
        try {
            $matches = Select-String -LiteralPath $file -Pattern $errorPattern -CaseSensitive:$false -ErrorAction Stop | Select-Object -Last 40
            if ($matches) {
                Redact-Secrets -Lines ($matches | ForEach-Object { $_.Line })
            } else {
                Write-Output "No obvious recent errors found."
            }
        } catch {
            Write-Output "Unable to scan log: $($_.Exception.Message)"
        }
    }
}
if (-not $foundLocalLogsForScan) {
    Write-Output $NoLocalUnityLogsMessage
}

Write-Section "Summary Hint"
Write-Output "Use this output to summarize: current phase, completed work, blockers, recent errors, next step."
