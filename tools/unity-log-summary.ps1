$ErrorActionPreference = "Continue"

$ProjectRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $ProjectRoot

$files = @(
    ".\Logs\EditModeBatch.log",
    ".\Logs\UnityBatch.log",
    "$env:LOCALAPPDATA\Unity\Editor\Editor.log"
)

Write-Output "Unity Log Summary"
Write-Output "Generated At: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Output ""
        Write-Output "===== $file ====="
        try {
            Select-String -LiteralPath $file -Pattern "error CS|Exception|Failed|FAIL|Compilation failed|NullReferenceException|warning CS" -CaseSensitive:$false -ErrorAction Stop |
                Select-Object -Last 80 |
                ForEach-Object { $_.Line }
        } catch {
            Write-Output "Unable to read log: $($_.Exception.Message)"
        }
    }
}
