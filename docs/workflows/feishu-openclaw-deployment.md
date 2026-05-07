# Unity6_AI - Feishu + OpenClaw Deployment Guide

## Goal

Use Feishu on mobile to check Unity6_AI project progress through OpenClaw Gateway.

## Architecture

```text
Feishu mobile app
-> Feishu Bot
-> OpenClaw Feishu channel
-> Local OpenClaw Gateway
-> Unity6_AI/tools/mobile-status.ps1
-> Feishu progress summary
```

## Phase 1: Read-only Mode

Allowed:

- Check Git status
- Check recent commits
- Read PROGRESS.md
- Read TODO.md
- Read AI_DEV_LOG.md
- Read Unity logs
- Summarize errors

Forbidden:

- Modify code
- Delete files
- Run git push
- Store secrets in repo
- Run arbitrary shell commands from Feishu

## Feishu Manual Setup

1. Create a Feishu custom app.
2. Enable Bot capability.
3. Copy App ID and App Secret.
4. Configure message permissions.
5. Configure event subscription.
6. Prefer WebSocket / long connection mode.
7. Add receive message event, usually im.message.receive_v1.
8. Publish the app if required by your organization.

## OpenClaw Setup

Check version:

```bash
openclaw --version
```

If needed:

```bash
openclaw update
```

If Feishu plugin is not bundled in the installed OpenClaw version:

```bash
openclaw plugins install @openclaw/feishu
```

Recommended setup:

```bash
openclaw onboard
```

Or:

```bash
openclaw channels add
```

Choose Feishu and enter App ID + App Secret.

Start Gateway:

```bash
openclaw gateway
```

Check status:

```bash
openclaw gateway status
openclaw logs --follow
```

## Pairing

Send a direct message to the Feishu bot.

If it replies with a pairing code:

```bash
openclaw pairing list feishu
openclaw pairing approve feishu <CODE>
```

## Local Test

From Unity6_AI root:

```powershell
powershell -ExecutionPolicy Bypass -File ".\tools\mobile-status.ps1"
```

Expected result:

- Git branch
- Recent commits
- Working tree
- Progress file
- TODO file
- Unity logs
- Recent error scan

## Feishu Test Messages

```text
查看 Unity6_AI 项目进度
```

```text
看看 Unity6_AI 有没有编译错误，只总结，不要修改
```

```text
查看 Git 状态和下一步建议
```

## Security Notes

Never commit:

- App Secret
- DeepSeek Key
- Claude Token
- OpenAI API Key
- Feishu verification token
- Feishu encrypt key

If leaked, rotate immediately.

