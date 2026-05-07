param(
    [string]$Name,
    [string]$Workspace,
    [string]$GitBranch = "",
    [string]$Role = "",
    [string]$Session = ""
)

[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

$ErrorActionPreference = "Stop"

$ControlRoot = "F:\Unity6_AI"
$WorktreesRoot = "F:\Unity6_AI.worktrees"
$SessionsPath = Join-Path $ControlRoot ".openclaw\cc-sessions.json"

$NeedArgsMessage = -join ([char[]]@(0x8BF7,0x5728,0x0020,0x002F,0x0063,0x0063,0x002D,0x0073,0x0065,0x0073,0x0073,0x0069,0x006F,0x006E,0x002D,0x0061,0x0064,0x0064,0x0020,0x540E,0x63D0,0x4F9B,0x0020,0x004E,0x0061,0x006D,0x0065,0x0020,0x548C,0x0020,0x0057,0x006F,0x0072,0x006B,0x0073,0x0070,0x0061,0x0063,0x0065,0x3002))
$CreateWorktreeMessage = -join ([char[]]@(0x8BF7,0x5148,0x521B,0x5EFA,0x0020,0x0047,0x0069,0x0074,0x0020,0x0077,0x006F,0x0072,0x006B,0x0074,0x0072,0x0065,0x0065,0xFF0C,0x4E0D,0x8981,0x81EA,0x52A8,0x521B,0x5EFA,0xFF1A))
$DuplicateMessage = -join ([char[]]@(0x4F1A,0x8BDD,0x540D,0x79F0,0x5DF2,0x5B58,0x5728,0xFF1A))
$AddedMessage = -join ([char[]]@(0x5DF2,0x767B,0x8BB0,0x0020,0x0043,0x006C,0x0061,0x0075,0x0064,0x0065,0x0020,0x0043,0x006F,0x0064,0x0065,0x0020,0x5F00,0x53D1,0x5206,0x652F,0xFF1A))
$WorkspaceLimitMessage = -join ([char[]]@(0x5B89,0x5168,0x9650,0x5236,0xFF1A,0x0077,0x006F,0x0072,0x006B,0x0073,0x0070,0x0061,0x0063,0x0065,0x0020,0x53EA,0x5141,0x8BB8,0x4F4D,0x4E8E,0x0020,0x0046,0x003A,0x005C,0x0055,0x006E,0x0069,0x0074,0x0079,0x0036,0x005F,0x0041,0x0049,0x0020,0x6216,0x0020,0x0046,0x003A,0x005C,0x0055,0x006E,0x0069,0x0074,0x0079,0x0036,0x005F,0x0041,0x0049,0x002E,0x0077,0x006F,0x0072,0x006B,0x0074,0x0072,0x0065,0x0065,0x0073,0x0020,0x4E0B,0x3002))
$DefaultRole = -join ([char[]]@(0x4E3B,0x7EBF,0xFF1A,0x67E5,0x770B,0x72B6,0x6001,0x3001,0x6574,0x7406,0x6587,0x6863,0x3001,0x8F7B,0x91CF,0x4FEE,0x6539))

function Ensure-SessionsFile {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $SessionsPath) | Out-Null
    if (-not (Test-Path -LiteralPath $SessionsPath)) {
        $default = @([ordered]@{
            name = "unity6ai-main"
            session = ""
            workspace = $ControlRoot
            gitBranch = "main"
            role = $DefaultRole
            status = "idle"
            updatedAt = ""
        })
        ConvertTo-Json -InputObject $default -Depth 5 | Set-Content -LiteralPath $SessionsPath -Encoding UTF8
    }
}

function Read-Sessions {
    Ensure-SessionsFile
    return @(Get-Content -LiteralPath $SessionsPath -Raw -Encoding UTF8 | ConvertFrom-Json)
}

function Save-Sessions {
    param([object[]]$Sessions)
    ConvertTo-Json -InputObject @($Sessions) -Depth 6 | Set-Content -LiteralPath $SessionsPath -Encoding UTF8
}

function Get-FullPath {
    param([string]$Path)
    return [System.IO.Path]::GetFullPath($Path).TrimEnd('\')
}

function Test-WorkspaceAllowed {
    param([string]$Path)
    $full = Get-FullPath -Path $Path
    $root = Get-FullPath -Path $ControlRoot
    $worktrees = Get-FullPath -Path $WorktreesRoot
    return ($full -eq $root -or $full.StartsWith($root + "\", [System.StringComparison]::OrdinalIgnoreCase) -or $full.StartsWith($worktrees + "\", [System.StringComparison]::OrdinalIgnoreCase))
}

Set-Location -LiteralPath $ControlRoot

if ([string]::IsNullOrWhiteSpace($Name) -or [string]::IsNullOrWhiteSpace($Workspace)) {
    Write-Output $NeedArgsMessage
    exit 2
}

if (-not (Test-WorkspaceAllowed -Path $Workspace)) {
    Write-Output $WorkspaceLimitMessage
    exit 2
}

if (-not (Test-Path -LiteralPath $Workspace -PathType Container)) {
    Write-Output "$CreateWorktreeMessage$Workspace"
    exit 2
}

$sessions = Read-Sessions
foreach ($entry in $sessions) {
    if ([string]::Equals($entry.name, $Name, [System.StringComparison]::OrdinalIgnoreCase)) {
        Write-Output "$DuplicateMessage$Name"
        exit 2
    }
}

$newEntry = [ordered]@{
    name = $Name.Trim()
    session = $Session.Trim()
    workspace = (Get-FullPath -Path $Workspace)
    gitBranch = $GitBranch.Trim()
    role = $Role.Trim()
    status = "idle"
    updatedAt = (Get-Date).ToString("o")
}

$updated = @($sessions) + [pscustomobject]$newEntry
Save-Sessions -Sessions $updated
Write-Output "$AddedMessage$($newEntry.name)"
