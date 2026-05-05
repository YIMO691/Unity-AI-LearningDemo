# Unity 6 AI 学习与实战仓库

这个仓库用于按阶段学习并构建一个 **Unity 6 AI 战斗演示**：从传统游戏 AI、群体 AI、ML-Agents 训练，到 Sentis/ONNX 推理集成。

当前仓库先搭好学习和协作基础，真正的 Unity 工程预留在 `UnityProject/` 目录中创建。这样可以把 GitHub、Claude Code、DeepSeek、文档和后续 Unity 项目放在同一个仓库里管理。

## 当前状态

- 原始操作手册已归档到 [docs/manual.md](docs/manual.md)。
- Claude Code/DeepSeek 交接说明已写入 [CLAUDE.md](CLAUDE.md) 和 [AGENTS.md](AGENTS.md)。
- 学习路线见 [docs/learning-roadmap.md](docs/learning-roadmap.md)。
- 项目需求与里程碑见 [docs/project-brief.md](docs/project-brief.md)。
- GitHub 远程仓库创建步骤见 [docs/github-setup.md](docs/github-setup.md)。
- Claude Code + DeepSeek 启动步骤见 [docs/claude-deepseek-workflow.md](docs/claude-deepseek-workflow.md)。

## 推荐目录

```text
F:\Unity6_AI
├─ docs/                  # 学习资料、项目说明、环境报告
├─ prompts/               # 给 Claude Code 的启动提示词
├─ scripts/               # 本地启动/检查脚本
├─ UnityProject/          # 后续用 Unity Hub 创建 Unity 6 工程
├─ CLAUDE.md              # Claude Code 项目指令
└─ AGENTS.md              # 通用 AI 代理交接指令
```

## 下一步

1. 创建 GitHub 远程仓库并推送本地提交，按 [docs/github-setup.md](docs/github-setup.md) 执行。
2. 安装 Unity 6，并在 `F:\Unity6_AI\UnityProject` 创建 3D 项目。
3. 设置 DeepSeek API Key，运行 `scripts\start-claude-deepseek.cmd` 启动 Claude Code。
4. 把 [prompts/first-claude-session.md](prompts/first-claude-session.md) 的内容交给 Claude Code，让它从 Milestone 0 开始推进。

