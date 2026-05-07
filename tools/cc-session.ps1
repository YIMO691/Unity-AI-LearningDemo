[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

$ErrorActionPreference = "Stop"

$ControlRoot = "F:\Unity6_AI"
$SessionsPath = Join-Path $ControlRoot ".openclaw\cc-sessions.json"
$TargetConfigPath = Join-Path $ControlRoot ".openclaw\cc-target.json"

function Read-Sessions {
    if (-not (Test-Path -LiteralPath $SessionsPath)) {
        return @()
    }
    try {
        return @(Get-Content -LiteralPath $SessionsPath -Raw -Encoding UTF8 | ConvertFrom-Json)
    } catch {
        return @()
    }
}

function Read-Target {
    if (-not (Test-Path -LiteralPath $TargetConfigPath)) {
        return $null
    }
    try {
        return Get-Content -LiteralPath $TargetConfigPath -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        return $null
    }
}

function Format-Timestamp {
    param([string]$Raw)
    if ([string]::IsNullOrWhiteSpace($Raw)) { return "-" }
    try {
        $dt = [datetime]::Parse($Raw)
        return $dt.ToString("MM-dd HH:mm")
    } catch {
        return $Raw
    }
}

Set-Location -LiteralPath $ControlRoot
$sessions = Read-Sessions
$target = Read-Target

Write-Output ""
Write-Output "=============================="
Write-Output " Claude Code 会话列表"
Write-Output "=============================="

if ($sessions.Count -eq 0) {
    Write-Output ""
    Write-Output "  （空）没有注册的 Claude Code 会话"
    Write-Output ""
    Write-Output "使用 /cc-use <名称> 注册一个新会话"
    exit 0
}

foreach ($entry in $sessions) {
    $name = if ($entry.name) { $entry.name } else { "(unnamed)" }
    $status = if ($entry.status) { $entry.status } else { "idle" }
    $role = if ($entry.role) { $entry.role } else { "-" }
    $branch = if ($entry.gitBranch) { $entry.gitBranch } else { "-" }
    $updated = Format-Timestamp -Raw $entry.updatedAt

    Write-Output ""
    Write-Output "  [$name]"
    Write-Output "    状态: $status"
    Write-Output "    角色: $role"
    Write-Output "    分支: $branch"
    Write-Output "    更新: $updated"
}

$selectedName = ""
if ($target -and -not [string]::IsNullOrWhiteSpace($target.defaultSessionName)) {
    $selectedName = $target.defaultSessionName
} else {
    $selectedName = "(无)"
}
Write-Output ""
Write-Output "---"
Write-Output "当前选中: $selectedName"
Write-Output ""
Write-Output "切换会话: /cc-use <名称>"
