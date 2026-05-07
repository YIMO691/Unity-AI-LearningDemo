# Unity6_AI 文档索引

本目录按用途分类，避免所有 Markdown 都堆在 `docs/` 根目录。

## Planning

项目规划、路线、架构决策和 Unity 包清单：

- [项目简报](planning/project-brief.md)
- [学习路线](planning/learning-roadmap.md)
- [架构决策记录](planning/architecture-decisions.md)
- [M0 计划](planning/milestone-m0-plan.md)
- [Unity 包清单](planning/package-manifest.md)

## Workflows

工具链、GitHub、Claude Code、OpenClaw 和 Skills 工作流：

- [GitHub 设置](workflows/github-setup.md)
- [Claude Code + DeepSeek 工作流](workflows/claude-deepseek-workflow.md)
- [Claude Code Relay](workflows/claude-code-relay.md)
- [Claude Code 多会话开发](workflows/claude-code-sessions.md)
- [Feishu + OpenClaw 部署](workflows/feishu-openclaw-deployment.md)
- [Skills 使用策略](workflows/skills-strategy.md)

## Status

项目当前状态、任务和 AI 协作记录：

- [当前进度](status/PROGRESS.md)
- [任务清单](status/TODO.md)
- [AI 开发日志](status/AI_DEV_LOG.md)

## Environment

本机环境与工具检测：

- [环境报告](environment/environment-report.md)

## Templates

可复用模板：

- [学习 Blog 模板](templates/learning-blog-template.md)

## Reference

归档参考资料，通常只读：

- [原始学习手册](reference/manual.md)

## 文件审查结论

- 保留：当前所有已分类文档都有用途，未发现需要立即删除的重复正文。
- 合并关系：`docs/reference/manual.md` 是长手册原文；`planning/learning-roadmap.md`、`planning/project-brief.md`、`planning/milestone-m0-plan.md` 是从手册拆出的执行版，不算重复。
- 本地忽略：`.openclaw/HEARTBEAT.md`、`IDENTITY.md`、`SOUL.md`、`TOOLS.md`、`USER.md` 属于 OpenClaw 本地 agent workspace notes，已通过 `.gitignore` 排除，不作为仓库文档维护。
- 工具约定：`README.md`、`AGENTS.md`、`CLAUDE.md` 留在根目录，因为外部工具会默认读取这些文件。
