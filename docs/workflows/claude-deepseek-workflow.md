# Claude Code + DeepSeek 工作流

## 已确认的本机状态

- Claude Code 已安装，`claude --version` 可用。
- Node.js 已安装。
- PowerShell 当前阻止直接运行 `npm.ps1`；需要用 `npm.cmd` 或调整执行策略。
- DeepSeek 不需要单独 CLI，本项目通过 DeepSeek API 作为 Claude Code 后端。

## 官方对接方式

DeepSeek 官方文档说明 Claude Code 可通过 Anthropic API 兼容端点接入 DeepSeek：

```powershell
$env:ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
$env:ANTHROPIC_AUTH_TOKEN="<your DeepSeek API Key>"
$env:ANTHROPIC_MODEL="deepseek-v4-pro[1m]"
$env:ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-v4-pro[1m]"
$env:ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-v4-pro[1m]"
$env:ANTHROPIC_DEFAULT_HAIKU_MODEL="deepseek-v4-flash"
$env:CLAUDE_CODE_SUBAGENT_MODEL="deepseek-v4-flash"
$env:CLAUDE_CODE_EFFORT_LEVEL="max"
claude
```

本仓库已经把这些变量封装到 `scripts/start-claude-deepseek.cmd` 和 `scripts/start-claude-deepseek.ps1`。

## 推荐启动方式

PowerShell 临时设置 API Key：

```powershell
cd F:\Unity6_AI
$env:DEEPSEEK_API_KEY="sk-你的真实key"
.\scripts\start-claude-deepseek.cmd
```

如果你希望长期保存到当前 Windows 用户环境：

```powershell
setx DEEPSEEK_API_KEY "sk-你的真实key"
```

重新打开终端后运行：

```powershell
cd F:\Unity6_AI
.\scripts\start-claude-deepseek.cmd
```

## 第一次交给 Claude Code 的提示词

打开 Claude Code 后，把 [prompts/first-claude-session.md](../prompts/first-claude-session.md) 的内容粘贴进去。

## 重要提醒

- 不要把 DeepSeek API Key 写进仓库文件。
- Claude Code 生成 Unity 代码后，必须在 Unity 编辑器里验证。
- 让 Claude Code 每次只推进一个里程碑，避免一次性堆出不可调试的系统。

## 参考

- DeepSeek 官方：<https://api-docs.deepseek.com/guides/coding_agents>
- Claude Code 设置：<https://docs.claude.com/en/docs/claude-code/setup>
- Claude Code 记忆与 `CLAUDE.md`：<https://docs.claude.com/en/docs/claude-code/memory>

