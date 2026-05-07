---
description: Summarize Unity6_AI project progress for Feishu/OpenClaw mobile viewing.
allowed-tools: Bash(git status:*), Bash(git log:*), Bash(git branch:*), Bash(powershell:*)
---

# Unity6_AI Progress Summary

请读取当前 Unity6_AI 项目的状态，并输出适合手机飞书查看的中文摘要。

你可以检查：

- 当前 Git 分支
- 最近 5 次提交
- 当前未提交文件
- docs/status/PROGRESS.md
- docs/status/TODO.md
- docs/status/AI_DEV_LOG.md
- Logs/EditModeBatch.log
- Logs/EditModeResults.xml
- Logs/UnityBatch.log 中最近的错误

优先调用：

```powershell
powershell -ExecutionPolicy Bypass -File ".\tools\mobile-status.ps1"
```

输出格式：

## 当前阶段

## 已完成

## 当前问题

## 最近错误

## 下一步建议

限制：

- 不要修改任何文件。
- 不要提交代码。
- 不要输出任何密钥。
- 不要超过 1200 字。
