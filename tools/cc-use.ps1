param(
    [string]$Session
)

[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

$ErrorActionPreference = "Stop"

$ProjectRoot = "F:\Unity6_AI"
$TargetConfigPath = Join-Path $ProjectRoot ".openclaw\cc-target.json"
$SessionsPath = Join-Path $ProjectRoot ".openclaw\cc-sessions.json"
$EmptySessionMessage = -join ([char[]]@(
    0x8BF7, 0x5728, 0x0020, 0x002F, 0x0063, 0x0063, 0x002D, 0x0075,
    0x0073, 0x0065, 0x0020, 0x540E, 0x8F93, 0x5165, 0x0020,
    0x0043, 0x006C, 0x0061, 0x0075, 0x0064, 0x0065, 0x0020,
    0x0043, 0x006F, 0x0064, 0x0065, 0x0020, 0x0073, 0x0065,
    0x0073, 0x0073, 0x0069, 0x006F, 0x006E, 0x0020, 0x540D,
    0x79F0, 0x6216, 0x0020, 0x0049, 0x0044, 0x3002
))
$SwitchedPrefix = -join ([char[]]@(
    0x5DF2, 0x5207, 0x6362, 0x0020, 0x0043, 0x006C, 0x0061,
    0x0075, 0x0064, 0x0065, 0x0020, 0x0043, 0x006F, 0x0064,
    0x0065, 0x0020, 0x76EE, 0x6807, 0x4F1A, 0x8BDD, 0xFF1A
))
$WorkspaceLabel = -join ([char[]]@(0x5DE5,0x4F5C,0x533A,0xFF1A))
$BranchLabel = -join ([char[]]@(0x5206,0x652F,0xFF1A))

if ([string]::IsNullOrWhiteSpace($Session)) {
    Write-Output $EmptySessionMessage
    exit 2
}

Set-Location -LiteralPath $ProjectRoot
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $TargetConfigPath) | Out-Null

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

$inputValue = $Session.Trim()
$sessions = Read-Sessions
$matched = $null
foreach ($entry in $sessions) {
    if ([string]::Equals($entry.name, $inputValue, [System.StringComparison]::OrdinalIgnoreCase)) {
        $matched = $entry
        break
    }
}

if ($matched) {
    $config = [ordered]@{
        defaultSessionName = $matched.name
        defaultSession = if ($matched.session) { $matched.session } else { "" }
        workspace = $matched.workspace
        gitBranch = if ($matched.gitBranch) { $matched.gitBranch } else { "" }
        mode = "readonly"
        updatedAt = (Get-Date).ToString("o")
    }
} else {
    $config = [ordered]@{
        defaultSessionName = ""
        defaultSession = $inputValue
        workspace = $ProjectRoot
        gitBranch = ""
        mode = "readonly"
        updatedAt = (Get-Date).ToString("o")
    }
}

$config | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $TargetConfigPath -Encoding UTF8
$display = if ($config.defaultSessionName) { $config.defaultSessionName } elseif ($config.defaultSession) { $config.defaultSession } else { "(unbound)" }
Write-Output "$SwitchedPrefix$display"
Write-Output "$WorkspaceLabel$($config.workspace)"
if (-not [string]::IsNullOrWhiteSpace($config.gitBranch)) {
    Write-Output "$BranchLabel$($config.gitBranch)"
}
