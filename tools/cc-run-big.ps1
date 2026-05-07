[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

$ErrorActionPreference = "Stop"

$ProjectRoot = "F:\Unity6_AI"
Set-Location -LiteralPath $ProjectRoot

if ($args.Count -eq 0 -or [string]::IsNullOrWhiteSpace($args[0])) {
    Write-Output "请在 /cc-run-big 后输入任务描述"
    exit 1
}

$promptText = $args -join " "

$promptPath = Join-Path $ProjectRoot "Logs\ClaudeRelay\bigtask-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"
$promptText | Set-Content -Path $promptPath -Encoding UTF8

Write-Output "任务已提交至 Claude Code（大任务模式，无超时限制）"
Write-Output "提示词已保存到：$promptPath"
Write-Output ""
Write-Output "⚠️  注意：大任务模式不经过 relay 安全防护"
Write-Output "   请勿要求 git push、删除文件、泄露密钥"
