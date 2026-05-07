# Unity6_AI Progress

## Current Phase

Phase 0 completed / Phase 1 ready.

## Completed

- Project progress tracking file initialized.
- OpenClaw installed successfully.
- Feishu plugin installed and enabled.
- Feishu default channel configured successfully.
- OpenClaw Gateway started successfully.
- DeepSeek model available.
- `unity6ai` Agent created.
- Feishu default channel bound to the `unity6ai` Agent.
- `unity6ai` workspace confirmed as `F:\Unity6_AI`.
- Feishu private chat bot can read and summarize `tools/mobile-status.ps1` project status.
- `tools/mobile-status.ps1` fixed to read only project-local `Logs` files, not the global Unity Editor.log.
- GitHub remote configured as `https://github.com/YIMO691/Unity_AI`.
- Canonical Unity project path prepared as `F:\Unity6_AI\UnityProject`.
- Unity source folders copied from the legacy `AI` project into `UnityProject`.
- Standard `_Project` folder skeleton created under `UnityProject/Assets/_Project`.
- `UnityProject` opened successfully in Unity.
- Unity generated cache/IDE files and template tutorial assets cleaned from `UnityProject`.
- Default scene moved to `UnityProject/Assets/_Project/Scenes/Main.unity`.
- Root `Logs/ClaudeRelay` runtime files cleaned, keeping only `.gitkeep`.
- OpenClaw local agent workspace notes are now ignored by Git.
- Legacy `F:\Unity6_AI\AI` copy deleted after user confirmation.
- `.repo-backups` deleted after user confirmation.
- Markdown docs classified into `docs/planning`, `docs/workflows`, `docs/status`, `docs/environment`, `docs/templates`, and `docs/reference`.
- Added `docs/README.md` as the documentation index and duplicate/usefulness audit.

## Command Reference

| 命令 | 前缀含义 | 功能 |
| --- | --- | --- |
| `/cc` | Claude Code | 项目全局状态检查 |
| `/cc-run` | CC relay 任务 | 通过 relay 执行编辑任务（超时 20min，带安全+日志） |
| `/cc-run-big` | CC 直调 | 直接 exec claude 执行大任务（不限时，无 relay 防护） |
| `/cc-status` | CC 状态 | 里程碑进度、包安装、阻塞项 |
| `/cc-last` | CC 最近 | Git 记录 + 未提交变更 |
| `/cc-sessions` | CC 会话列表 | 列出 `.openclaw/cc-sessions.json` 中注册的 Claude Code 会话 |
| `/cc-use <名称>` | CC 切换 | 切换 Claude Code 目标会话 |
| `/oc-session` | OC 运行时 | 当前 Agent 运行时详情（模型、上下文、缓存、花费） |
| `/oc-sessions` | OC 会话列表 | Gateway 所有活跃会话 |

## Current Blockers

- Reopen `F:\Unity6_AI\UnityProject` in Unity Hub once after cleanup to regenerate Library/cache and verify `Main.unity`.
- Unity generated cache folders are intentionally left in place locally and ignored by Git.

## Next Steps

- Reopen and verify `F:\Unity6_AI\UnityProject` after cleanup.
- Prepare Phase 1 Unity AI foundation tasks.
- Start FSM enemy AI implementation after the Unity project opens cleanly.
