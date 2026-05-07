---
paths:
  - "tools/cc-run.ps1"
  - "tools/cc-run-big.ps1"
  - "tools/claude-code-relay.ps1"
---

# 远程指令规则

## 角色边界

- OpenClaw Agent（我）不直接编辑项目文件。
- 所有文件修改操作必须通过 Claude Code CLI 执行。
- 文件读取、检查状态、查看日志等只读操作可以由 Agent 直接执行。

## 指令转述规则

- `/cc-run <任务>` — 原封不动将 `<任务>` 传给 relay 脚本，不做包装、不做解释、不增删改。
- `/cc-run-big <任务>` — 原封不动将 `<任务>` 传给 claude CLI（headless 模式），不做包装、不做解释、不增删改。

## 安全约束

- 禁止 git push。
- 禁止删除文件或目录。
- 禁止输出或保存 API Key、Token、密码。
- 禁止修改 OpenClaw/Claude Code 密钥配置。
- 禁止修改 Windows 系统级设置。
