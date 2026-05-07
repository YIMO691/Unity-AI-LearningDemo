$ErrorActionPreference = "Continue"

$ProjectRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $ProjectRoot

$status = powershell -ExecutionPolicy Bypass -File ".\tools\mobile-status.ps1"

Write-Output "Summarize the Unity6_AI project status below as a Chinese Feishu mobile message."
Write-Output "Requirements:"
Write-Output "1. Do not output secrets."
Write-Output "2. Keep the message under 1200 Chinese characters."
Write-Output "3. Use these sections in Chinese: current phase, completed, current issues, recent errors, next steps."
Write-Output "4. If no clear errors are found, explicitly say that no obvious errors were found."
Write-Output ""
Write-Output "===== RAW STATUS START ====="
$status | Select-Object -First 300
Write-Output "===== RAW STATUS END ====="
