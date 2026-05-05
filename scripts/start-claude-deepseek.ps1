param(
    [string]$DeepSeekApiKey = $env:DEEPSEEK_API_KEY
)

if ([string]::IsNullOrWhiteSpace($DeepSeekApiKey)) {
    Write-Error 'Missing DEEPSEEK_API_KEY. Set $env:DEEPSEEK_API_KEY first, or pass -DeepSeekApiKey.'
    exit 1
}

$env:ANTHROPIC_BASE_URL = 'https://api.deepseek.com/anthropic'
$env:ANTHROPIC_AUTH_TOKEN = $DeepSeekApiKey
$env:ANTHROPIC_MODEL = 'deepseek-v4-pro[1m]'
$env:ANTHROPIC_DEFAULT_OPUS_MODEL = 'deepseek-v4-pro[1m]'
$env:ANTHROPIC_DEFAULT_SONNET_MODEL = 'deepseek-v4-pro[1m]'
$env:ANTHROPIC_DEFAULT_HAIKU_MODEL = 'deepseek-v4-flash'
$env:CLAUDE_CODE_SUBAGENT_MODEL = 'deepseek-v4-flash'
$env:CLAUDE_CODE_EFFORT_LEVEL = 'max'

Set-Location -LiteralPath (Resolve-Path (Join-Path $PSScriptRoot '..'))
claude

