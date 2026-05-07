[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

$ErrorActionPreference = "Stop"

$ProjectRoot = "F:\Unity6_AI"
Set-Location -LiteralPath $ProjectRoot

Write-Output ""
Write-Output "================================"
Write-Output " OpenClaw Agent 运行时信息"
Write-Output "================================"
Write-Output ""
Write-Output "本命令已重命名: /oc-session"
Write-Output ""
Write-Output "提示：调用 OpenClaw Gateway API 获取实时会话详情"
Write-Output "     请在飞书中发送 /oc-session"
Write-Output ""
Write-Output "旧命令 /cc-session 已废弃，请使用 /oc-session"
