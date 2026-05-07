# Claude Code 多会话开发说明

## 会话分支 vs Git 分支

Claude Code 会话分支是 Claude Code 的对话上下文，用于恢复同一个开发思路或远程任务链路。

Git 分支是代码仓库的版本分支，用于隔离文件修改、提交和合并。

两者可以一一对应，但不是同一个东西。推荐给每个开发方向登记：

- 一个飞书短名称，例如 `fsm-ai`
- 一个 Claude Code session id/name
- 一个独立 workspace
- 一个 Git 分支

## 为什么多线程开发要用 Git worktree

如果两个 Claude Code 会话同时在同一个 `F:\Unity6_AI` 目录里改文件，很容易互相覆盖、冲突或误判任务状态。

Git worktree 可以让同一个仓库的不同分支拥有独立目录。例如：

```text
F:\Unity6_AI
F:\Unity6_AI.worktrees\fsm-ai
F:\Unity6_AI.worktrees\behavior-tree
```

这样每个 Claude Code session 都只在自己的 workspace 里工作。

## 创建 worktree

```powershell
git worktree add F:\Unity6_AI.worktrees\fsm-ai -b feature/fsm-ai
```

如果分支已存在，可去掉 `-b`：

```powershell
git worktree add F:\Unity6_AI.worktrees\fsm-ai feature/fsm-ai
```

## 登记 session

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\cc-session-add.ps1" `
  -Name "fsm-ai" `
  -Workspace "F:\Unity6_AI.worktrees\fsm-ai" `
  -GitBranch "feature/fsm-ai" `
  -Role "FSM 敌人 AI 原型"
```

如果 workspace 不存在，脚本只会提示先创建 worktree，不会自动创建。

## 查看已登记会话

飞书：

```text
/cc-session
```

如果 `/cc-session` 被 OpenClaw 内置命令抢占，使用别名：

```text
/cc-sessions
```

本地：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\cc-session.ps1"
```

## 选择会话

飞书：

```text
/cc-use fsm-ai
```

本地：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\cc-use.ps1" -Session "fsm-ai"
```

如果 `fsm-ai` 是登记名称，会写入 `.openclaw/cc-target.json`：

```json
{
  "defaultSessionName": "fsm-ai",
  "defaultSession": "",
  "workspace": "F:\\Unity6_AI.worktrees\\fsm-ai",
  "gitBranch": "feature/fsm-ai",
  "mode": "readonly",
  "updatedAt": "..."
}
```

后续 `/cc` 和 `/cc-run` 都会在该 workspace 中执行。

## 查看状态和最近结果

```text
/cc-status
/cc-last
```

## 移除登记

只移除 `.openclaw/cc-sessions.json` 中的登记记录，不删除 workspace、不删除 Git branch、不删除 Claude Code session。

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\cc-session-remove.ps1" -Name "fsm-ai"
```

## 安全限制

- 不要让两个 session 同时修改同一个 workspace。
- workspace 只允许位于 `F:\Unity6_AI` 或 `F:\Unity6_AI.worktrees\` 下。
- 不要 `git push`。
- 不要删除 worktree。
- 不要保存 API Key、Token、App Secret 或密码。
- 不要修改 OpenClaw / Claude / DeepSeek 密钥配置。
