# Claude Code Relay

## 目标

通过飞书和 OpenClaw 控制指定 Claude Code session / branch，让 Claude Code 在 `F:\Unity6_AI` 中执行任务，并把任务状态和执行摘要写入 `Logs/ClaudeRelay/`。

官方 session 文档说明，Claude Code session 绑定项目目录保存，可以通过 `claude --resume <name/session-id>` 恢复；headless/non-interactive 模式支持 `claude -p --resume "<session>" "<prompt>"` 这种调用方式。

参考：

- [Manage sessions - Claude Code Docs](https://code.claude.com/docs/en/sessions)
- [Run Claude Code programmatically](https://code.claude.com/docs/en/headless)

## 配置文件

`.openclaw/cc-target.json`：

```json
{
  "defaultSessionName": "",
  "defaultSession": "",
  "workspace": "F:\\Unity6_AI",
  "gitBranch": "",
  "mode": "readonly",
  "updatedAt": ""
}
```

使用 `/cc-use <session>` 更新 `defaultSession`。

`.openclaw/cc-sessions.json` 用于登记多个 Claude Code 开发会话和对应 workspace。详见 [claude-code-sessions.md](claude-code-sessions.md)。

## 飞书指令

### /cc-session

```text
/cc-session
```

如被 OpenClaw 内置命令抢占，也可用：

```text
/cc-sessions
```

本地等价命令：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-session.ps1"
```

返回已登记的 Claude Code 开发分支列表，并标记当前选中项。

## /cc 与 /cc-run 的区别

- `/cc`：只读模式，适合查看、分析、总结，不允许修改文件；默认 `-RawPassThrough`。
- `/cc-run`：可编辑模式，适合让 Claude Code 修改项目文件；必须使用 `-AllowEdit` 安全包装提示词，禁止 `git push`、删除文件、输出密钥或修改密钥配置。

### /cc-use

```text
/cc-use <session-id-or-name>
```

本地等价命令：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-use.ps1" -Session "<session-id-or-name>"
```

如果传入值匹配 `.openclaw/cc-sessions.json` 中的 `name`，会同时选择该记录的 `workspace`、`gitBranch` 和 `session`。

如果不匹配登记名称，则按 Claude Code session id/name 写入 `defaultSession`，workspace 回到 `F:\Unity6_AI`。

### /cc

```text
/cc <任务内容>
```

本地等价命令：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\claude-code-relay.ps1" -PromptText "<任务内容>" -RawPassThrough
```

如果已设置 `defaultSession`，relay 会调用：

```powershell
claude -p --resume "<session>" "<任务内容>" --output-format text --allowedTools "<tools>"
```

如果没有 session，则调用：

```powershell
claude -p "<任务内容>" --output-format text --allowedTools "<tools>"
```

如果已设置 `workspace`，relay 会在该 workspace 中执行。workspace 必须位于 `F:\Unity6_AI` 或 `F:\Unity6_AI.worktrees\` 下。

### /cc-run

```text
/cc-run <任务内容>
```

本地等价命令：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-run.ps1" -PromptText "<任务内容>"
```

`/cc-run` 会调用：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\claude-code-relay.ps1" -PromptText "<任务内容>" -AllowEdit
```

AllowEdit 模式会给 Claude Code 包装安全提示词，允许修改 `F:\Unity6_AI` 内的普通源码、文档、配置、Unity 项目文件和项目日志，但禁止：

- `git push`
- 删除项目目录或递归删除命令
- 输出、保存或修改 API Key、Token、App Secret、密码
- 修改 OpenClaw / Claude / DeepSeek 密钥配置
- 安装未知全局工具
- 修改 Windows 系统级设置
- 自动 `git commit`，除非用户明确允许 commit

执行前后 relay 会记录 `git status --short`，并在摘要里输出：

- 新增文件
- 修改文件
- 删除文件

如果检测到删除文件，摘要会高亮提醒人工确认。

### /cc-status

```text
/cc-status
```

本地等价命令：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-status.ps1"
```

### /cc-last

```text
/cc-last
```

本地等价命令：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-last.ps1"
```

## 状态文件

`Logs/ClaudeRelay/current-task.json` 在任务开始时写入：

```json
{
  "status": "running",
  "mode": "allow-edit",
  "runId": "...",
  "sessionName": "...",
  "session": "...",
  "workspace": "...",
  "gitBranch": "...",
  "prompt": "...",
  "startedAt": "...",
  "outputLog": "...",
  "summaryLog": ""
}
```

完成时更新：

```json
{
  "status": "completed",
  "mode": "allow-edit",
  "exitCode": 0,
  "completedAt": "...",
  "summaryLog": "...",
  "changedFiles": {
    "added": [],
    "modified": [],
    "deleted": []
  }
}
```

失败时更新：

```json
{
  "status": "failed",
  "mode": "allow-edit",
  "exitCode": 1,
  "error": "...",
  "completedAt": "..."
}
```

## 日志文件

每次 Claude Code 执行会生成：

- `Logs/ClaudeRelay/<runid>-prompt.txt`
- `Logs/ClaudeRelay/<runid>-output.txt`
- `Logs/ClaudeRelay/<runid>-meta.json`
- `Logs/ClaudeRelay/<runid>-summary.txt`

## 安全限制

- 默认只读。
- 不允许 `git push`。
- 不允许删除文件。
- 不允许输出 API Key、App Secret、Token。
- 不允许修改 OpenClaw / Claude / DeepSeek 密钥配置。
- 每次执行必须写入 `Logs/ClaudeRelay/`。
- workspace 只允许位于 `F:\Unity6_AI` 或 `F:\Unity6_AI.worktrees\` 下。
- 如果当前已有 `running` 任务，新的 `/cc` 不会启动。
- 如果当前已有 `running` 任务，新的 `/cc-run` 也不会启动。
- 不修改 Unity 业务代码。

## 失败排错

- 如果提示已有任务正在运行，先执行 `/cc-status` 查看 `current-task.json`。
- 如果 Claude Code 超时，检查 `Logs/ClaudeRelay/<runid>-output.txt`。
- 如果 `/cc-run` 没有修改文件，检查 Claude Code 摘要中的验证结果和剩余问题。
- 如果摘要出现删除文件提醒，先人工检查 `git status --short`，不要继续提交。
- 如果出现密钥样式内容，relay 会脱敏为 `[REDACTED_SECRET]`，仍应检查原始环境变量是否被误读。

## 本地测试

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-use.ps1" -Session "<session-id-or-name>"
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-session.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\claude-code-relay.ps1" -PromptText "只回复 OK" -RawPassThrough
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-run.ps1" -PromptText "请在 AI_DEV_LOG.md 末尾追加一条测试记录：cc-run smoke test completed。不要修改其他文件。"
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-status.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "F:\Unity6_AI\tools\cc-last.ps1"
```

## 飞书测试

```text
/cc-use <session-id-or-name>
/cc-session
/cc 只回复 OK
/cc-run 请在 AI_DEV_LOG.md 末尾追加一条测试记录：feishu cc-run smoke test completed。不要修改其他文件。
/cc-status
/cc-last
```

预期 `/cc 只回复 OK` 返回：

```text
OK
```
