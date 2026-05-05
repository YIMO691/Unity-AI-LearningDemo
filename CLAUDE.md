# Claude Code 项目指令

@AGENTS.md

你接手的是一个 Unity 6 AI 学习与实战仓库。请先阅读：

- `docs/manual.md`
- `docs/project-brief.md`
- `docs/learning-roadmap.md`
- `docs/claude-deepseek-workflow.md`

## 开工顺序

1. 先确认 `UnityProject/` 是否已经是 Unity 6 工程。
2. 如果不是，指导用户用 Unity Hub 创建 Unity 6 3D 项目到 `F:\Unity6_AI\UnityProject`。
3. 创建工程后，优先完成 Milestone 0：项目结构、包清单、基础场景、空测试。
4. 然后进入 Milestone 1：FSM 巡逻/追踪/攻击原型。

## 交付习惯

- 每个阶段都更新 `docs/learning-roadmap.md` 的进度。
- 每次代码改动后说明：改了什么、如何在 Unity 中验证、下一步是什么。
- 对 Unity、ML-Agents、Sentis、GitHub Actions 的当前用法不确定时，先查官方文档。
- 不要改写 `docs/manual.md`，它是原始手册归档；补充内容写到其他文档。

