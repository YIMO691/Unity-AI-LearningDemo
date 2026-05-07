# Unity6 AI Claude Relay

## 用途

飞书通过 OpenClaw 远程控制指定 Claude Code session / branch，让 Claude Code 在 `F:\Unity6_AI` 中执行任务、写入日志和状态文件，并允许随时查询状态与最近结果。

## 指令规则

### /cc-session / /cc-sessions

```text
/cc-session
```

调用：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-session.ps1"
```

作用：返回 `.openclaw/cc-sessions.json` 中已登记的 Claude Code 开发会话 / Git 分支 / workspace 列表，并标记当前选中项。

如果 `/cc-session` 被 OpenClaw 内置命令抢占，优先使用：

```text
/cc-sessions
```

### /cc-use

```text
/cc-use <session>
```

调用：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-use.ps1" -Session "<session>"
```

作用：写入 `.openclaw/cc-target.json` 的 `defaultSession`。后续 `/cc` 默认恢复这个 Claude Code session。

如果 `<session>` 匹配 `.openclaw/cc-sessions.json` 中的 `name`，则同时写入：

- `defaultSessionName`
- `defaultSession`
- `workspace`
- `gitBranch`

如果不匹配登记名称，则按 Claude Code session id/name 写入 `defaultSession`，workspace 使用 `F:\Unity6_AI`。

### /cc

```text
/cc <prompt>
```

调用：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\claude-code-relay.ps1" -PromptText "<prompt>" -RawPassThrough
```

要求：

- `<prompt>` 必须是 `/cc` 后面的原文。
- 默认 `-RawPassThrough`。
- 如果 `.openclaw/cc-target.json` 有 `workspace`，relay 会在该 workspace 中执行。
- 如果 `.openclaw/cc-target.json` 有 `defaultSession`，relay 会使用 `claude -p --resume "<session>" "<prompt>"`。
- 如果没有 session，则使用普通 `claude -p "<prompt>"`。
- 如果 `/cc` 后为空，返回：`请在 /cc 后输入要转发给 Claude Code 的任务。`
- 如果 `Logs/ClaudeRelay/current-task.json` 显示已有 `running` 任务，不启动新任务，提示用户先查看 `/cc-status`。

### /cc-run

```text
/cc-run <prompt>
```

调用：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-run.ps1" -PromptText "<prompt>"
```

作用：允许 Claude Code 修改 `F:\Unity6_AI` 项目文件，但必须使用 relay 的 `-AllowEdit` 安全包装提示词。

要求：

- `<prompt>` 必须是 `/cc-run` 后面的原文。
- 允许编辑项目文件。
- 禁止 `git push`。
- 禁止删除项目目录。
- 禁止输出 API Key、App Secret、Token 或其他密钥。
- 禁止修改 OpenClaw / Claude / DeepSeek 密钥配置。
- 禁止自动 `git commit`，除非用户明确允许 commit。
- 如果任务内容明显危险，拒绝执行。
- 执行完成后必须返回修改文件列表和验证结果。
- 如果已有 `running` 任务，不启动新任务，提示用户先查看 `/cc-status`。

### /cc-status

```text
/cc-status
```

调用：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-status.ps1"
```

作用：读取 `Logs/ClaudeRelay/current-task.json` 并返回当前任务状态。

### /cc-last

```text
/cc-last
```

调用：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-last.ps1"
```

作用：读取 `Logs/ClaudeRelay/` 中最新的 `*-summary.txt`，返回最近一次 Claude Code 执行摘要。

## 可选统一入口

如果 OpenClaw 只能把完整飞书消息交给一个脚本，可统一调用：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-command.ps1" -MessageText "<飞书原始消息>"
```

`cc-command.ps1` 会路由 `/cc-session`、`/cc-sessions`、`/cc-use`、`/cc`、`/cc-run`、`/cc-status`、`/cc-last`。

## 安全边界

- 默认只读。
- `/cc-run` 显式允许编辑，但仍套用安全提示词。
- 工作目录固定为 `F:\Unity6_AI`。
- relay 执行 workspace 只允许位于 `F:\Unity6_AI` 或 `F:\Unity6_AI.worktrees\` 下。
- 多线程开发必须使用独立 workspace，推荐 Git worktree。
- 不允许 `git push`。
- 不允许删除文件。
- 不允许输出 API Key、App Secret、Token 或其他密钥。
- 不允许修改 OpenClaw / Claude / DeepSeek 密钥配置。
- 每次 Claude Code 执行都必须写入 `Logs/ClaudeRelay/`。
- 不修改 Unity 业务代码。

## 验收标准

- `/cc-session` 会显示 `unity6ai-main`。
- `/cc-use unity6ai-main` 会更新 `.openclaw/cc-target.json`。
- `/cc 只回复 OK` 会转发到目标 session，并返回 `OK`。
- `/cc-run <任务>` 会允许 Claude Code 修改项目文件，并返回修改文件列表和验证结果。
- `/cc-status` 能看到当前或最近任务状态。
- `/cc-last` 能看到最近一次 Claude Code 摘要。
