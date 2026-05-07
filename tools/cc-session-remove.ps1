param(
    [string]$Name
)

[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

$ErrorActionPreference = "Stop"

$ControlRoot = "F:\Unity6_AI"
$SessionsPath = Join-Path $ControlRoot ".openclaw\cc-sessions.json"

$NeedNameMessage = -join ([char[]]@(0x8BF7,0x5728,0x0020,0x002F,0x0063,0x0063,0x002D,0x0073,0x0065,0x0073,0x0073,0x0069,0x006F,0x006E,0x002D,0x0072,0x0065,0x006D,0x006F,0x0076,0x0065,0x0020,0x540E,0x8F93,0x5165,0x8981,0x79FB,0x9664,0x7684,0x4F1A,0x8BDD,0x540D,0x79F0,0x3002))
$NotFoundMessage = -join ([char[]]@(0x672A,0x627E,0x5230,0x4F1A,0x8BDD,0x8BB0,0x5F55,0xFF1A))
$RemovedMessage = -join ([char[]]@(0x5DF2,0x79FB,0x9664,0x0020,0x0043,0x006C,0x0061,0x0075,0x0064,0x0065,0x0020,0x0043,0x006F,0x0064,0x0065,0x0020,0x5F00,0x53D1,0x5206,0x652F,0x767B,0x8BB0,0xFF1A))
$CannotRemoveMainMessage = -join ([char[]]@(0x4E0D,0x80FD,0x79FB,0x9664,0x9ED8,0x8BA4,0x4E3B,0x7EBF,0x4F1A,0x8BDD,0xFF1A,0x0075,0x006E,0x0069,0x0074,0x0079,0x0036,0x0061,0x0069,0x002D,0x006D,0x0061,0x0069,0x006E))
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

Set-Location -LiteralPath $ControlRoot

if ([string]::IsNullOrWhiteSpace($Name)) {
    Write-Output $NeedNameMessage
    exit 2
}

if ([string]::Equals($Name, "unity6ai-main", [System.StringComparison]::OrdinalIgnoreCase)) {
    Write-Output $CannotRemoveMainMessage
    exit 2
}

Ensure-SessionsFile
$sessions = @(Get-Content -LiteralPath $SessionsPath -Raw -Encoding UTF8 | ConvertFrom-Json)
$remaining = @($sessions | Where-Object { -not [string]::Equals($_.name, $Name, [System.StringComparison]::OrdinalIgnoreCase) })

if ($remaining.Count -eq $sessions.Count) {
    Write-Output "$NotFoundMessage$Name"
    exit 2
}

ConvertTo-Json -InputObject @($remaining) -Depth 6 | Set-Content -LiteralPath $SessionsPath -Encoding UTF8
Write-Output "$RemovedMessage$Name"
