@echo off
setlocal

if not "%~1"=="" (
  set "DEEPSEEK_API_KEY=%~1"
)

if "%DEEPSEEK_API_KEY%"=="" (
  echo Missing DEEPSEEK_API_KEY.
  echo Set it first in PowerShell:
  echo   $env:DEEPSEEK_API_KEY="sk-your-key"
  echo Then run:
  echo   scripts\start-claude-deepseek.cmd
  exit /b 1
)

set "ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic"
set "ANTHROPIC_AUTH_TOKEN=%DEEPSEEK_API_KEY%"
set "ANTHROPIC_MODEL=deepseek-v4-pro[1m]"
set "ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro[1m]"
set "ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-pro[1m]"
set "ANTHROPIC_DEFAULT_HAIKU_MODEL=deepseek-v4-flash"
set "CLAUDE_CODE_SUBAGENT_MODEL=deepseek-v4-flash"
set "CLAUDE_CODE_EFFORT_LEVEL=max"

cd /d "%~dp0.."
claude

