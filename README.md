# Unity 6 AI — Combat Demo / 战斗演示

[![Unity](https://img.shields.io/badge/Unity-6000.4.5f1-000000?logo=unity)](https://unity.com/releases/editor/whats-new/6000.4.5)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![AI](https://img.shields.io/badge/AI-FSM%20|%20Behavior%20|%20ML--Agents%20|%20Sentis-ff6a00)](docs/planning/learning-roadmap.md)
[![Status](https://img.shields.io/badge/status-M0%20in%20progress-yellow)](docs/status/PROGRESS.md)
[![Platform](https://img.shields.io/badge/platform-Windows%2010%2B-lightgrey)]()

**English** | [中文](#中文)

A step-by-step learning repository for building a **3D AI combat demo** in Unity 6 — from traditional game AI (FSM, NavMesh, perception) to modern ML inference (ML-Agents, Sentis/ONNX).

一个从传统游戏 AI 到现代机器学习推理，按阶段构建 **Unity 6 3D AI 战斗演示** 的学习仓库。

---

## Table of Contents / 目录

- [Overview / 项目概述](#overview--项目概述)
- [Architecture / 架构](#architecture--架构)
- [Milestones / 里程碑](#milestones--里程碑)
- [Quick Start / 快速开始](#quick-start--快速开始)
- [Project Structure / 目录结构](#project-structure--目录结构)
- [Remote Development / 远程开发](#remote-development--远程开发)
- [Documentation / 文档索引](#documentation--文档索引)
- [Contributing / 参与贡献](#contributing--参与贡献)
- [License / 许可证](#license--许可证)

---

## Overview / 项目概述

**English:** This repository builds a complete AI combat demo in phases — one player versus multiple enemies. Each phase introduces a new AI technique, from simple finite state machines to trained neural network inference at runtime.

**中文：** 本仓库按阶段推进一个完整的 AI 战斗 Demo：玩家 vs 多名敌人，每个阶段引入一种新的 AI 技术，从简单的有限状态机到运行时神经网络推理。

| Phase / 阶段 | Tech Stack / 技术栈 | Goal / 目标 |
| --- | --- | --- |
| **M1 — Traditional AI / 传统 AI** | FSM, NavMesh, Perception | Patrol, chase, attack / 巡逻、追踪、攻击 |
| **M2 — Behavior Tree & Swarm / 行为树与群体** | Unity Behavior, Group Behavior | Complex decisions, squad coordination / 复杂决策、小队协作 |
| **M3 — ML-Agents / 强化学习** | Reinforcement Learning (PPO) | Autonomous agent training / 智能体自主训练 |
| **M4 — Sentis Inference / 推理集成** | ONNX Model, Burst CPU | In-game model inference / 游戏内模型推理 |
| **M5 — Integration & Delivery / 集成交付** | CI, Video Demo | Reproducible full demo / 可复现完整演示 |

> Detailed roadmap: [docs/planning/learning-roadmap.md](docs/planning/learning-roadmap.md)

---

## Architecture / 架构

```text
Feishu Mobile / 飞书手机端         ← Remote progress check & task dispatch
    ↓                                  远程查看进度、下达任务
OpenClaw Gateway                   ← Local automation gateway / 本地自动化网关
    ↓
unity6ai Agent                     ← Project-specific agent / 项目专属 Agent
    ↓
Claude Code Relay + DeepSeek       ← AI coding assistant / AI 编码助手
    ↓
F:\Unity6_AI\UnityProject\         ← Unity 6 project / Unity 6 工程
```

See also: [Claude Code Relay Guide](docs/CLAUDE_CODE_RELAY.md) | [Claude Code Sessions](docs/CLAUDE_CODE_SESSIONS.md)

---

## Milestones / 里程碑

| Milestone / 里程碑 | Status / 状态 | Content / 内容 |
| --- | --- | --- |
| **M0** Project Foundation / 工程基础 | 🟡 In Progress / 进行中 | Unity 6 skeleton, packages, Git, CI |
| **M1** Traditional Game AI / 传统游戏 AI | ⏳ Pending / 待启动 | FSM + NavMesh + Perception |
| **M2** Behavior Tree & Swarm / 行为树与群体 | ⏳ Pending / 待启动 | Unity Behavior, squad AI |
| **M3** ML-Agents Training / 强化学习训练 | ⏳ Pending / 待启动 | PPO training, TensorBoard |
| **M4** Sentis Inference / 推理集成 | ⏳ Pending / 待启动 | ONNX import, runtime inference |
| **M5** Final Delivery / 最终交付 | ⏳ Pending / 待启动 | Full demo, CI, video |

> Detailed plans: [M0 Plan](docs/planning/milestone-m0-plan.md) | [TODO](docs/status/TODO.md) | [Progress](docs/status/PROGRESS.md)

---

## Quick Start / 快速开始

### Prerequisites / 前置要求

- **Unity Hub** + **Unity 6000.4.5f1** (with Windows Build Support / 需安装 Windows Build Support)
- **Git** + **Git LFS**
- **PowerShell 5.1+**

### Clone & Open / 克隆与打开

```powershell
git clone https://github.com/YIMO691/Unity_AI.git
cd Unity_AI
git lfs install

# Open UnityProject/ with Unity Hub
# 用 Unity Hub 打开 UnityProject/
```

### Verify / 验证

```powershell
# Local project status summary / 本地项目状态摘要
powershell -ExecutionPolicy Bypass -File ".\tools\mobile-status.ps1"
```

### AI Assistant Setup / AI 助手启动

```powershell
# Start Claude Code with DeepSeek backend
# 以 DeepSeek 后端启动 Claude Code
$env:DEEPSEEK_API_KEY="sk-your-key"
.\scripts\start-claude-deepseek.cmd
```

> Never commit API keys. See `.env.example` for configuration reference.
> 不要将 API Key 写入仓库。配置参考 `.env.example`。

---

## Project Structure / 目录结构

```text
F:\Unity6_AI
├─ .claude/               # Claude Code rules & skills / 规则和技能
├─ .github/               # PR/Issue templates & CI / 模板与 CI 配置
├─ docs/                  # Planning, workflows, status, reference
│  ├─ planning/           # Project plans, milestones, ADR / 项目规划、里程碑、架构决策
│  ├─ workflows/          # Workflow guides (CI, Claude Code, Feishu)
│  ├─ status/             # Progress tracking (PROGRESS, TODO, AI_DEV_LOG)
│  ├─ environment/        # Environment reports / 环境检测报告
│  ├─ reference/          # Reference manuals / 参考手册
│  └─ templates/          # Document templates / 文档模板
├─ LearningBlog/          # Learning notes & reflections / 学习笔记
├─ Logs/                  # Runtime logs / 运行日志
├─ prompts/               # AI session starter prompts / AI 对话启动提示词
├─ scripts/               # Local startup/inspection scripts / 本地启动/检查脚本
├─ tools/                 # Utility scripts (status, relay, log summary)
├─ UnityProject/          # Unity 6 project root / Unity 6 工程根目录
│  └─ Assets/_Project/    # Project source code, scenes, assets / 业务代码、场景、资源
│     ├─ Art/
│     ├─ Prefabs/
│     ├─ Scenes/
│     ├─ Scripts/
│     │  ├─ Core/
│     │  ├─ AI/
│     │  ├─ Player/
│     │  └─ Training/
│     └─ Tests/
├─ CLAUDE.md              # Claude Code project instructions / 项目指令
├─ AGENTS.md              # AI agent handoff notes / AI 代理交接说明
└─ README.md              # This file / 本文件
```

---

## Remote Development / 远程开发

**English:** Control this project from your phone via Feishu + OpenClaw. Check progress, dispatch coding tasks, and monitor CI — all through chat.

**中文：** 通过飞书 + OpenClaw 在手机端查看项目进度、下达编码任务、监控 CI，全部通过聊天完成。

| Command / 命令 | Function / 功能 |
| --- | --- |
| `/cc` | Read-only analysis: project status, TODO check / 只读分析 |
| `/cc-run <task>` | Execute editing task via relay / 通过 relay 执行编辑任务 |
| `/cc-run-big <task>` | Execute large task directly / 直接执行大任务 |
| `/cc-status` | Claude Code task status / 当前任务状态 |
| `/cc-last` | Last execution summary / 最近执行摘要 |
| `/cc-session` | Agent runtime details / Agent 运行时详情 |
| `/progress` | Mobile-optimized project progress / 移动端项目进度 |

> Setup guide: [Feishu + OpenClaw Deployment](docs/workflows/feishu-openclaw-deployment.md)

---

## Documentation / 文档索引

| Document / 文档 | Description / 说明 |
| --- | --- |
| [AGENTS.md](AGENTS.md) | AI agent handoff notes / AI 代理交接说明 |
| [CLAUDE.md](CLAUDE.md) | Claude Code project instructions / Claude Code 项目指令 |
| [docs/README.md](docs/README.md) | Documentation index & audit / 文档目录与使用审计 |
| [docs/planning/project-brief.md](docs/planning/project-brief.md) | Project requirements / 项目需求概要 |
| [docs/planning/architecture-decisions.md](docs/planning/architecture-decisions.md) | Architecture Decision Records / 架构决策记录 |
| [docs/planning/learning-roadmap.md](docs/planning/learning-roadmap.md) | Learning roadmap / 学习路线图 |
| [docs/planning/milestone-m0-plan.md](docs/planning/milestone-m0-plan.md) | M0 detailed task list / M0 任务清单 |
| [docs/status/PROGRESS.md](docs/status/PROGRESS.md) | Current progress / 项目进度 |
| [docs/status/TODO.md](docs/status/TODO.md) | Task backlog / 待办任务 |
| [docs/status/AI_DEV_LOG.md](docs/status/AI_DEV_LOG.md) | AI collaboration log / AI 协作记录 |
| [docs/reference/manual.md](docs/reference/manual.md) | Original learning manual (read-only) / 原始学习手册 |
| [LearningBlog/README.md](LearningBlog/README.md) | Learning blog index / 学习 Blog 索引 |

---

## Contributing / 参与贡献

**English:** This is a personal learning project. Suggestions and discussions are welcome via GitHub Issues. Code contributions should follow the conventions in [CLAUDE.md](CLAUDE.md) and [.claude/rules/unity-csharp.md](.claude/rules/unity-csharp.md).

**中文：** 这是个人学习项目。欢迎通过 GitHub Issues 提出建议和讨论。代码贡献请遵循 [CLAUDE.md](CLAUDE.md) 和 [.claude/rules/unity-csharp.md](.claude/rules/unity-csharp.md) 中的约定。

### Branch Naming / 分支命名

```
milestone/m{N}-{slug}
# e.g.: milestone/m1-fsm, milestone/m2-behavior
```

### Code Conventions / 代码约定

- Communication in Chinese, identifiers in English / 中文沟通，英文标识符
- `[SerializeField] private` over `public` fields / 优先使用 SerializeField
- AI parameters exposed in Inspector / AI 参数暴露到 Inspector
- Never commit: API keys, Unity Library, training results, caches / 不提交密钥和缓存

---

## License / 许可证

MIT — see [LICENSE](LICENSE) for details.

---

<p align="center">
  <sub>Built with Unity 6 | AI-assisted by Claude Code + DeepSeek | Remote-controlled via Feishu + OpenClaw</sub>
</p>
