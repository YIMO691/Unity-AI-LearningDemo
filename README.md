# Unity 6 AI — Combat Demo / 战斗演示

[![Unity](https://img.shields.io/badge/Unity-6000.4.5f1-000000?logo=unity)](https://unity.com/releases/editor/whats-new/6000.4.5)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![AI](https://img.shields.io/badge/AI-FSM%20|%20Behavior%20|%20ML--Agents%20|%20Sentis-ff6a00)](docs/planning/learning-roadmap.md)
[![Status](https://img.shields.io/badge/status-M0%20complete%20%7C%20M1%20ready-brightgreen)](docs/status/PROGRESS.md)
[![Platform](https://img.shields.io/badge/platform-Windows%2010-lightgrey)]()

**English** | [中文](#中文)

A step-by-step learning repository for building a **3D AI combat demo** in Unity 6 — from traditional game AI (FSM, NavMesh, perception) to modern ML inference (ML-Agents, Sentis/ONNX).

一个从传统游戏 AI 到现代机器学习推理，按阶段构建 **Unity 6 3D AI 战斗演示** 的学习仓库。

---

## Table of Contents / 目录

- [Overview / 项目概述](#overview--项目概述)
- [Current Status / 当前状态](#current-status--当前状态)
- [Milestones / 里程碑](#milestones--里程碑)
- [Quick Start / 快速开始](#quick-start--快速开始)
- [Project Structure / 目录结构](#project-structure--目录结构)
- [Remote Development / 远程开发](#remote-development--远程开发)
- [Engineering Foundations / 工程化基础](#engineering-foundations--工程化基础)
- [Documentation / 文档索引](#documentation--文档索引)
- [Contributing / 参与贡献](#contributing--参与贡献)
- [License / 许可证](#license--许可证)

---

## Overview / 项目概述

**English:** This repository builds a complete AI combat demo in phases — one player versus multiple enemies. Each phase introduces a new AI technique, progressing from simple finite state machines to trained neural network inference at runtime.

Every milestone produces runnable, verifiable, and documented output. The project is AI-assisted via Claude Code + DeepSeek and remotely controllable via Feishu + OpenClaw.

**中文：** 本仓库按阶段推进一个完整的 AI 战斗 Demo：玩家 vs 多名敌人，每个阶段引入一种新的 AI 技术，从简单的有限状态机逐步过渡到运行时神经网络推理。

每个里程碑都产出可运行、可验证、可讲解的交付物。项目由 Claude Code + DeepSeek 辅助开发，并通过飞书 + OpenClaw 实现远程控制。

### AI Techniques Covered / 涉及技术

| Phase / 阶段 | Tech / 技术 | What You'll See / 你将看到 |
| --- | --- | --- |
| **M1** Traditional AI / 传统 AI | FSM, NavMesh, Perception | Enemies patrol, detect, chase, and attack / 敌人巡逻、感知、追踪、攻击 |
| **M2** Behavior & Swarm / 行为树与群体 | Unity Behavior, Group Behavior | Coordinated squad tactics, dynamic decision trees / 小队协作、动态行为决策 |
| **M3** ML-Agents / 强化学习 | PPO, TensorBoard | Self-trained agents with observable reward curves / 自主训练智能体、可观察奖励曲线 |
| **M4** Sentis Inference / 推理集成 | ONNX, Burst CPU | Real-time neural network inference in-game / 游戏内实时神经网络推理 |
| **M5** Integration & Delivery / 集成交付 | CI, Demo Video | Reproducible full demo from scratch / 从零可复现的完整演示 |

> Detailed roadmap: [docs/planning/learning-roadmap.md](docs/planning/learning-roadmap.md)

---

## Current Status / 当前状态

**English:** Milestone 0 (Project Foundation) is complete. Unity 6 URP project created, all core packages installed, directory structure established, SmokeTest passing, and code pushed to GitHub. Milestone 1 (FSM + NavMesh enemy AI prototype) is ready to begin.

**中文：** 里程碑 0（工程基础）已完成。Unity 6 URP 工程已创建，全部核心包已安装，目录结构已建立，SmokeTest 通过，代码已推送 GitHub。里程碑 1（FSM + NavMesh 敌人 AI 原型）准备开始。

| Item / 项目 | Status / 状态 |
| --- | --- |
| Unity 6 Project / Unity 6 工程 | ✅ Created / 已创建 |
| Package Installation / 包安装 | ✅ AI Navigation 2.0.12, Behavior 1.0.15, ML-Agents 4.0.3, Test Framework 1.6.0 |
| Base Scene / 基础场景 | ✅ Main.unity (Ground + Lighting + Camera) |
| Smoke Test / 冒烟测试 | ✅ 1/1 passing / 1/1 通过 |
| Git LFS / Git 大文件 | ✅ Initialized / 已初始化 |
| CI Pipeline / 持续集成 | ✅ GitHub Actions configured / 已配置 |
| Documentation / 文档体系 | ✅ 25+ docs across 6 categories / 6 类 25+ 份文档 |

> Full status: [PROGRESS.md](docs/status/PROGRESS.md) | [TODO.md](docs/status/TODO.md)

---

## Milestones / 里程碑

| Milestone / 里程碑 | Status / 状态 | Deliverables / 交付物 |
| --- | --- | --- |
| **M0** Project Foundation / 工程基础 | ✅ Complete / 已完成 | Unity 6 skeleton, packages, CI, docs system |
| **M1** Traditional Game AI / 传统游戏 AI | 🟡 In Progress / 进行中 | FSM + NavMesh patrol/chase/attack |
| **M2** Behavior Tree & Swarm / 行为树与群体 | ⏳ Pending / 待启动 | Unity Behavior graph, squad coordination |
| **M3** ML-Agents Training / 强化学习训练 | ⏳ Pending / 待启动 | PPO training, TensorBoard, ONNX model |
| **M4** Sentis Inference / 推理集成 | ⏳ Pending / 待启动 | ONNX import, Burst CPU runtime inference |
| **M5** Final Delivery / 最终交付 | ⏳ Pending / 待启动 | Full demo, CI green, video walkthrough |

> Detailed plan: [M0 Task Plan](docs/planning/milestone-m0-plan.md) | [Architecture Decisions](docs/planning/architecture-decisions.md)

---

## Quick Start / 快速开始

### Prerequisites / 前置要求

| Tool | Version | Purpose |
| --- | --- | --- |
| Unity Hub + Unity 6 | 6000.4.5f1+ | Editor & runtime / 编辑器与运行时 |
| Git | 2.40+ | Version control / 版本控制 |
| Git LFS | 3.x | Large binary storage / 大文件存储 |
| GitHub CLI (`gh`) | 2.x | PR, Issue, CI management / PR/Issue/CI 管理 |
| PowerShell | 5.1+ | Automation scripts / 自动化脚本 |

### Clone & Setup / 克隆与初始化

```powershell
git clone https://github.com/YIMO691/Unity_AI.git
cd Unity_AI
git lfs install
```

### Open in Unity / 在 Unity 中打开

1. Launch **Unity Hub**
2. Click **Open** → select `Unity_AI/UnityProject/`
3. Wait for package restoration and script compilation
4. Open `Assets/_Project/Scenes/Main.unity`
5. Press **Play** — should see gray ground with lighting, no Console errors

### Run Tests / 运行测试

```
Window → General → Test Runner → EditMode → Run All
```

Should show `SmokeTest.Project_CanRunEditModeTest` ✅ 1/1 passing.

### Project Status Check / 项目状态查看

```powershell
# Local summary / 本地状态摘要
powershell -ExecutionPolicy Bypass -File ".\tools\mobile-status.ps1"
```

### AI Assistant Setup / AI 助手启动

```powershell
$env:DEEPSEEK_API_KEY="sk-your-key"
.\scripts\start-claude-deepseek.cmd
```

> ⚠️ Never commit API keys. Never write keys into project files. See `.env.example` for configuration reference.
> ⚠️ 不要将 API Key 写入仓库文件。配置参考 `.env.example`。

---

## Project Structure / 目录结构

```text
F:\Unity6_AI
├─ .claude/                  # Claude Code skills, rules, commands / 技能、规则与命令
├─ .github/                  # CI workflows, PR/Issue templates, CODEOWNERS
├─ .openclaw/                # OpenClaw Gateway state & agent config / 网关状态与 Agent 配置
├─ docs/                     # All project documentation / 全部项目文档
│  ├─ planning/              # Plans, milestones, ADR, package manifest / 计划与架构
│  ├─ status/                # PROGRESS.md, TODO.md, AI_DEV_LOG.md
│  ├─ reference/             # Manuals, file organization convention, skills manifest
│  ├─ workflows/             # Setup guides (CI, GitHub, Feishu, Claude Code)
│  ├─ environment/           # Environment reports / 环境检测报告
│  └─ templates/             # Reusable file templates / 可复用模板
├─ LearningBlog/             # Structured learning notes / 学习笔记
├─ Logs/                     # Runtime logs (not committed) / 运行日志（不提交）
├─ prompts/                  # AI session starter prompts / AI 启动提示词
├─ scripts/                  # Claude Code + DeepSeek startup scripts / 启动脚本
├─ tools/                    # Automation PowerShell scripts / 自动化脚本
│  ├─ claude-code-relay.ps1  # Relay: Feishu → Claude Code
│  ├─ mobile-status.ps1      # Phone-friendly project status / 手机端项目状态
│  └─ cc-*.ps1              # /cc, /cc-run, /cc-status, /cc-session commands
├─ UnityProject/             # Unity 6 project root / Unity 6 工程根目录
│  └─ Assets/_Project/       # Project source code & assets / 业务代码与资源
│     ├─ Art/                # Materials, models, textures / 材质、模型、纹理
│     ├─ Prefabs/            # Reusable prefabs / 可复用预制体
│     ├─ Scenes/             # Main.unity and future scenes / 场景文件
│     ├─ Scripts/            # C# scripts by domain / C# 脚本（Core/AI/Player/Training）
│     └─ Tests/              # EditMode + PlayMode tests / 测试
├─ LICENSE                   # MIT license / MIT 许可证
├─ CLAUDE.md                 # Claude Code project instructions / 项目指令
├─ AGENTS.md                 # AI agent handoff notes / AI 代理交接说明
├─ CONTRIBUTING.md           # Contribution guide / 贡献指南
├─ SECURITY.md               # Security policy / 安全策略
└─ README.md                 # This file / 本文件
```

---

## Remote Development / 远程开发

**English:** Control this project from your phone via Feishu + OpenClaw. Check progress, dispatch coding tasks, and monitor CI — all through chat. The relay architecture ensures safety boundaries: read-only commands never modify files, write commands require explicit authorization.

**中文：** 通过飞书 + OpenClaw 在手机端查看项目进度、下达编码任务、监控 CI，全部通过聊天完成。Relay 架构确保安全边界：只读命令绝不修改文件，写命令需要显式授权。

```text
Feishu Mobile / 飞书手机端
    → OpenClaw Gateway / 本地自动化网关
    → unity6ai Agent / 项目专属 Agent
    → Claude Code Relay / 安全中继
    → Claude Code + DeepSeek / AI 编码
    → Result summary → Feishu / 结果摘要返回飞书
```

| Command / 命令 | Mode / 模式 | Function / 功能 |
| --- | --- | --- |
| `/cc` | Read-only / 只读 | Project status, TODO check, log analysis / 状态检查、日志分析 |
| `/cc-run <task>` | Edit (restricted) / 编辑（受限） | Execute task via relay with safety rules / 通过 relay 安全执行 |
| `/cc-run-big <task>` | Edit (unrestricted) / 编辑（无限制） | Direct Claude Code execution for large tasks / 直接执行大任务 |
| `/cc-status` | Read-only / 只读 | Current Claude Code task state / 当前任务状态 |
| `/cc-last` | Read-only / 只读 | Last execution summary / 最近执行摘要 |
| `/progress` | Read-only / 只读 | Mobile-optimized project progress / 移动端项目进度 |

> Setup guide: [Feishu + OpenClaw Deployment](docs/workflows/feishu-openclaw-deployment.md)
> Relay guide: [Claude Code Relay](docs/workflows/claude-code-relay.md)

---

## Engineering Foundations / 工程化基础

| Foundation / 基础 | File / 文件 | Purpose / 用途 |
| --- | --- | --- |
| **Architecture Decisions** | [ADR](docs/planning/architecture-decisions.md) | 8 technical decisions with rationale / 8 条技术决策及理由 |
| **File Organization** | [Convention](docs/reference/file-organization-convention.md) | Where every file type belongs / 每种文件放哪的规则 |
| **Skills Manifest** | [Manifest](docs/reference/skills-manifest.md) | 20 active skills with decision flow / 20 个活跃 skill 及使用决策 |
| **Coding Rules** | [C# Rules](.claude/rules/unity-csharp.md) | Unity C# conventions, Inspector, validation / C# 编码规范 |
| **Git LFS** | [.gitattributes](.gitattributes) | Binary file tracking (ONNX, FBX, textures, audio) |
| **CI Pipeline** | [unity-ci.yml](.github/workflows/unity-ci.yml) | GitHub Actions: compile + EditMode tests |
| **Package Versions** | [Manifest](docs/planning/package-manifest.md) | Locked versions for reproducibility / 版本锁定 |
| **Security Policy** | [SECURITY.md](SECURITY.md) | Vulnerability reporting & scope / 安全漏洞报告流程 |

---

## Documentation / 文档索引

### Entry Points / 入口文档

| Document / 文档 | Purpose / 用途 |
| --- | --- |
| [README.md](README.md) | Project introduction & quick start / 项目介绍与快速开始 |
| [CLAUDE.md](CLAUDE.md) | Claude Code project instructions / Claude Code 项目指令 |
| [AGENTS.md](AGENTS.md) | AI agent handoff notes / AI 代理交接说明 |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guide & PR checklist / 贡献指南与 PR 检查清单 |
| [SECURITY.md](SECURITY.md) | Security policy & reporting / 安全策略与报告流程 |
| [LICENSE](LICENSE) | MIT license / MIT 许可证 |

### Planning / 计划文档

| Document / 文档 | Purpose / 用途 |
| --- | --- |
| [project-brief.md](docs/planning/project-brief.md) | Project requirements & milestone summary / 项目需求与里程碑概要 |
| [learning-roadmap.md](docs/planning/learning-roadmap.md) | Phased learning path / 分阶段学习路线 |
| [milestone-m0-plan.md](docs/planning/milestone-m0-plan.md) | M0 detailed task breakdown / M0 详细任务清单 |
| [architecture-decisions.md](docs/planning/architecture-decisions.md) | Architecture Decision Records (8 ADRs) / 架构决策记录 |
| [package-manifest.md](docs/planning/package-manifest.md) | Locked Unity package versions / Unity 包版本锁定 |

### Status / 状态跟踪

| Document / 文档 | Purpose / 用途 |
| --- | --- |
| [PROGRESS.md](docs/status/PROGRESS.md) | Current progress & completed items / 当前进度与已完成项 |
| [TODO.md](docs/status/TODO.md) | Task backlog & acceptance criteria / 待办任务与验收标准 |
| [AI_DEV_LOG.md](docs/status/AI_DEV_LOG.md) | AI collaboration log / AI 协作记录 |

### Reference / 参考文档

| Document / 文档 | Purpose / 用途 |
| --- | --- |
| [manual.md](docs/reference/manual.md) | Original learning manual (read-only archive) / 原始学习手册（只读归档） |
| [file-organization-convention.md](docs/reference/file-organization-convention.md) | File placement rules & root whitelist / 文件组织规范与根目录白名单 |
| [skills-manifest.md](docs/reference/skills-manifest.md) | 20 skills inventory with decision flow / 20 个 skill 清单与使用决策 |

### Workflows / 工作流

| Document / 文档 | Purpose / 用途 |
| --- | --- |
| [claude-deepseek-workflow.md](docs/workflows/claude-deepseek-workflow.md) | Claude Code + DeepSeek setup / Claude Code + DeepSeek 启动 |
| [github-setup.md](docs/workflows/github-setup.md) | GitHub repository creation / GitHub 仓库创建 |
| [feishu-openclaw-deployment.md](docs/workflows/feishu-openclaw-deployment.md) | Remote development setup / 远程开发链路搭建 |
| [claude-code-relay.md](docs/workflows/claude-code-relay.md) | Claude Code relay script guide / Relay 脚本使用说明 |
| [skills-strategy.md](docs/workflows/skills-strategy.md) | Skills/agents/hooks adoption strategy / Skill 使用策略 |
| [docs/README.md](docs/README.md) | Documentation index & audit / 文档目录索引 |

### Learning Blog / 学习笔记

| Document / 文档 | Topic / 主题 |
| --- | --- |
| [LearningBlog/README.md](LearningBlog/README.md) | Blog index by date & tag / 按日期和标签浏览 |
| [Toolchain Setup](LearningBlog/2026-05-06-toolchain-ssh-lfs-gh.md) | SSH Key, Git LFS, GitHub CLI deep-dive / 工具链原理深挖 |
| [Remote Dev Chain](LearningBlog/2026-05-06-unity6-ai-openclaw-feishu-claude-code-relay.md) | OpenClaw + Feishu + Claude Code relay / 远程开发链路 |

---

## Contributing / 参与贡献

**English:** This is a personal learning project. Suggestions and discussions are welcome via GitHub Issues. Code contributions should follow the conventions in [CONTRIBUTING.md](CONTRIBUTING.md), [CLAUDE.md](CLAUDE.md), and [.claude/rules/unity-csharp.md](.claude/rules/unity-csharp.md).

**中文：** 这是个人学习项目。欢迎通过 GitHub Issues 提出建议和讨论。代码贡献请遵循 [CONTRIBUTING.md](CONTRIBUTING.md)、[CLAUDE.md](CLAUDE.md) 和 [.claude/rules/unity-csharp.md](.claude/rules/unity-csharp.md) 中的约定。

### Branch Naming / 分支命名

```
milestone/m{N}-{slug}
# Examples / 示例:
# milestone/m1-fsm
# milestone/m2-behavior
# milestone/m3-ml-agents
```

### Commit Conventions / 提交约定

- Descriptive English commit messages / 英文描述性提交信息
- Prefix batch context when helpful: `M0:`, `M1:`, `Docs:`, `CI:`
- Each commit is one logical change / 每次提交一个逻辑变更

### Code Conventions / 代码约定

- Communication in Chinese, identifiers in English / 中文沟通，英文标识符
- `[SerializeField] private` over `public` fields / 序列化私有不公开
- AI parameters exposed in Inspector / AI 参数 Inspector 可调
- After writing code, always explain: which GameObject, which components, how to verify / 写代码后说明挂载方式和验证步骤
- Never commit: API keys, Unity Library, Temp, training artifacts, user settings / 不提交密钥和缓存

---

## License / 许可证

MIT — see [LICENSE](LICENSE) for details.

---

<p align="center">
  <sub>Built with Unity 6 | AI-assisted by Claude Code + DeepSeek | Remote-controlled via Feishu + OpenClaw</sub><br>
  <sub>用 Unity 6 构建 | Claude Code + DeepSeek 辅助开发 | 飞书 + OpenClaw 远程控制</sub>
</p>
