# Unity 6 AI — 战斗演示

[![Unity](https://img.shields.io/badge/Unity-6000.4.5f1-000000?logo=unity)](https://unity.com/releases/editor/whats-new/6000.4.5)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![AI](https://img.shields.io/badge/AI-FSM%20|%20Behavior%20|%20ML--Agents%20|%20Sentis-ff6a00)](docs/planning/learning-roadmap.md)
[![Status](https://img.shields.io/badge/status-M0%20%E5%AE%8C%E6%88%90%20%7C%20M1%20%E5%B0%B1%E7%BB%AA-brightgreen)](docs/status/PROGRESS.md)

[**English Version**](README.md)

一个从传统游戏 AI 到现代机器学习推理，按阶段构建 **Unity 6 3D AI 战斗演示** 的学习仓库。

---

## 目录

- [项目概述](#项目概述)
- [当前状态](#当前状态)
- [里程碑](#里程碑)
- [快速开始](#快速开始)
- [目录结构](#目录结构)
- [远程开发](#远程开发)
- [工程化基础](#工程化基础)
- [文档索引](#文档索引)
- [参与贡献](#参与贡献)
- [许可证](#许可证)

---

## 项目概述

本仓库按阶段推进一个完整的 AI 战斗 Demo：玩家 vs 多名敌人，每个阶段引入一种新的 AI 技术，从简单的有限状态机逐步过渡到运行时神经网络推理。

每个里程碑都产出可运行、可验证、可讲解的交付物。项目由 Claude Code + DeepSeek 辅助开发，并通过飞书 + OpenClaw 实现远程控制。

### 涉及技术

| 阶段 | 技术 | 你将看到 |
| --- | --- | --- |
| **M1** 传统 AI | FSM、NavMesh、感知 | 敌人巡逻、感知、追踪、攻击 |
| **M2** 行为树与群体 | Unity Behavior、群体行为 | 小队协作、动态行为决策 |
| **M3** 强化学习 | PPO、TensorBoard | 自主训练智能体、可观察奖励曲线 |
| **M4** 推理集成 | ONNX、Burst CPU | 游戏内实时神经网络推理 |
| **M5** 集成交付 | CI、演示录屏 | 从零可复现的完整演示 |

> 详细路线图：[docs/planning/learning-roadmap.md](docs/planning/learning-roadmap.md)

---

## 当前状态

里程碑 0（工程基础）**已完成**。Unity 6 URP 工程已创建，全部核心包已安装，目录结构已建立，SmokeTest 通过，代码已推送 GitHub。里程碑 1（FSM + NavMesh 敌人 AI 原型）准备开始。

| 项目 | 状态 |
| --- | --- |
| Unity 6 工程 | ✅ 已创建 |
| 包安装 | ✅ AI Navigation 2.0.12, Behavior 1.0.15, ML-Agents 4.0.3, Test Framework 1.6.0 |
| 基础场景 | ✅ Main.unity（地面 + 光照 + 摄像机） |
| 冒烟测试 | ✅ 1/1 通过 |
| Git LFS | ✅ 已初始化 |
| CI 流水线 | ✅ GitHub Actions 已配置 |
| 文档体系 | ✅ 6 类 25+ 份文档 |

> 完整状态：[PROGRESS.md](docs/status/PROGRESS.md) | [TODO.md](docs/status/TODO.md)

---

## 里程碑

| 里程碑 | 状态 | 交付物 |
| --- | --- | --- |
| **M0** 工程基础 | ✅ 已完成 | Unity 6 工程骨架、包安装、CI、文档体系 |
| **M1** 传统游戏 AI | 🟡 进行中 | FSM + NavMesh 巡逻/追踪/攻击 |
| **M2** 行为树与群体 | ⏳ 待启动 | Unity Behavior 行为图、小队协作 |
| **M3** 强化学习训练 | ⏳ 待启动 | PPO 训练、TensorBoard、ONNX 模型 |
| **M4** 推理集成 | ⏳ 待启动 | ONNX 导入、Burst CPU 运行时推理 |
| **M5** 最终交付 | ⏳ 待启动 | 完整 Demo、CI 通过、演示录屏 |

> 详细计划：[M0 任务清单](docs/planning/milestone-m0-plan.md) | [架构决策记录](docs/planning/architecture-decisions.md)

---

## 快速开始

### 前置要求

| 工具 | 版本 | 用途 |
| --- | --- | --- |
| Unity Hub + Unity 6 | 6000.4.5f1+ | 编辑器与运行时 |
| Git | 2.40+ | 版本控制 |
| Git LFS | 3.x | 大文件存储 |
| GitHub CLI (`gh`) | 2.x | PR、Issue、CI 管理 |
| PowerShell | 5.1+ | 自动化脚本 |

### 克隆与初始化

```powershell
git clone https://github.com/YIMO691/Unity-AI-LearningDemo.git
cd Unity_AI
git lfs install
```

### 在 Unity 中打开

1. 启动 **Unity Hub**
2. 点击 **Open** → 选择 `Unity_AI/UnityProject/`
3. 等待包还原和脚本编译完成
4. 打开 `Assets/_Project/Scenes/Main.unity`
5. 点击 **Play** — 应看到灰色地面和光照，Console 无错误

### 运行测试

```
Window → General → Test Runner → EditMode → Run All
```

应显示 `SmokeTest.Project_CanRunEditModeTest` ✅ 1/1 通过。

### 项目状态查看

```powershell
powershell -ExecutionPolicy Bypass -File ".\tools\mobile-status.ps1"
```

### AI 助手启动

```powershell
$env:DEEPSEEK_API_KEY="sk-your-key"
.\scripts\start-claude-deepseek.cmd
```

> ⚠️ 不要将 API Key 写入仓库文件。配置参考 `.env.example`。

---

## 目录结构

```text
F:\Unity6_AI
├─ .claude/                  # Claude Code 技能、规则与命令
├─ .github/                  # CI 工作流、PR/Issue 模板、CODEOWNERS
├─ .openclaw/                # OpenClaw Gateway 状态与 Agent 配置
├─ docs/                     # 全部项目文档
│  ├─ planning/              # 计划、里程碑、架构决策、包清单
│  ├─ status/                # PROGRESS.md、TODO.md、AI_DEV_LOG.md
│  ├─ reference/             # 手册、文件组织规范、Skill 清单
│  ├─ workflows/             # 搭建指南（CI、GitHub、飞书、Claude Code）
│  ├─ environment/           # 环境检测报告
│  └─ templates/             # 可复用文件模板
├─ LearningBlog/             # 结构化学习笔记
├─ Logs/                     # 运行日志（不提交）
├─ prompts/                  # AI 启动提示词
├─ scripts/                  # Claude Code + DeepSeek 启动脚本
├─ tools/                    # 自动化 PowerShell 脚本
│  ├─ claude-code-relay.ps1  # 中继：飞书 → Claude Code
│  ├─ mobile-status.ps1      # 手机端项目状态
│  └─ cc-*.ps1              # /cc、/cc-run、/cc-status、/cc-session 命令
├─ UnityProject/             # Unity 6 工程根目录
│  └─ Assets/_Project/       # 业务代码与资源
│     ├─ Art/                # 材质、模型、纹理
│     ├─ Prefabs/            # 可复用预制体
│     ├─ Scenes/             # Main.unity 及后续场景
│     ├─ Scripts/            # C# 脚本（Core/AI/Player/Training）
│     └─ Tests/              # EditMode + PlayMode 测试
├─ LICENSE                   # MIT 许可证
├─ CLAUDE.md                 # Claude Code 项目指令
├─ AGENTS.md                 # AI 代理交接说明
├─ CONTRIBUTING.md           # 贡献指南
├─ SECURITY.md               # 安全策略
└─ README.md                 # 英文版 README
```

---

## 远程开发

通过飞书 + OpenClaw 在手机端查看项目进度、下达编码任务、监控 CI，全部通过聊天完成。Relay 架构确保安全边界：只读命令绝不修改文件，写命令需要显式授权。

```text
飞书手机端 → OpenClaw Gateway → unity6ai Agent → Claude Code Relay → Claude Code + DeepSeek → 结果摘要 → 飞书
```

| 命令 | 模式 | 功能 |
| --- | --- | --- |
| `/cc` | 只读 | 项目状态、TODO 检查、日志分析 |
| `/cc-run <任务>` | 编辑（受限） | 通过 relay 安全执行编辑任务 |
| `/cc-run-big <任务>` | 编辑（无限制） | 直接执行大任务 |
| `/cc-status` | 只读 | 当前 Claude Code 任务状态 |
| `/cc-last` | 只读 | 最近执行摘要 |
| `/progress` | 只读 | 移动端项目进度 |

> 搭建指南：[飞书 + OpenClaw 部署](docs/workflows/feishu-openclaw-deployment.md)
> Relay 指南：[Claude Code Relay](docs/workflows/claude-code-relay.md)

---

## 工程化基础

| 基础项 | 文件 | 用途 |
| --- | --- | --- |
| **架构决策** | [ADR](docs/planning/architecture-decisions.md) | 8 条技术决策及理由 |
| **文件组织** | [规范](docs/reference/file-organization-convention.md) | 每种文件放哪的规则 |
| **Skill 清单** | [清单](docs/reference/skills-manifest.md) | 20 个活跃 skill 及使用决策 |
| **编码规则** | [C# 规范](.claude/rules/unity-csharp.md) | Unity C# 编码约定 |
| **Git LFS** | [.gitattributes](.gitattributes) | 二进制文件追踪（ONNX、FBX、纹理、音频） |
| **CI 流水线** | [unity-ci.yml](.github/workflows/unity-ci.yml) | GitHub Actions：编译 + EditMode 测试 |
| **包版本** | [清单](docs/planning/package-manifest.md) | 版本锁定，确保可复现 |
| **安全策略** | [SECURITY.md](SECURITY.md) | 安全漏洞报告流程 |

---

## 文档索引

### 入口文档

| 文档 | 用途 |
| --- | --- |
| [CLAUDE.md](CLAUDE.md) | Claude Code 项目指令 |
| [AGENTS.md](AGENTS.md) | AI 代理交接说明 |
| [CONTRIBUTING.md](CONTRIBUTING.md) | 贡献指南与 PR 检查清单 |
| [SECURITY.md](SECURITY.md) | 安全策略与报告流程 |
| [LICENSE](LICENSE) | MIT 许可证 |

### 计划文档

| 文档 | 用途 |
| --- | --- |
| [project-brief.md](docs/planning/project-brief.md) | 项目需求与里程碑概要 |
| [learning-roadmap.md](docs/planning/learning-roadmap.md) | 分阶段学习路线 |
| [milestone-m0-plan.md](docs/planning/milestone-m0-plan.md) | M0 详细任务清单 |
| [architecture-decisions.md](docs/planning/architecture-decisions.md) | 架构决策记录（8 条） |
| [package-manifest.md](docs/planning/package-manifest.md) | Unity 包版本锁定 |

### 状态跟踪

| 文档 | 用途 |
| --- | --- |
| [PROGRESS.md](docs/status/PROGRESS.md) | 当前进度与已完成项 |
| [TODO.md](docs/status/TODO.md) | 待办任务与验收标准 |
| [AI_DEV_LOG.md](docs/status/AI_DEV_LOG.md) | AI 协作记录 |

### 参考文档

| 文档 | 用途 |
| --- | --- |
| [manual.md](docs/reference/manual.md) | 原始学习手册（只读归档） |
| [file-organization-convention.md](docs/reference/file-organization-convention.md) | 文件组织规范与根目录白名单 |
| [skills-manifest.md](docs/reference/skills-manifest.md) | 20 个 skill 清单与使用决策 |

### 工作流

| 文档 | 用途 |
| --- | --- |
| [claude-deepseek-workflow.md](docs/workflows/claude-deepseek-workflow.md) | Claude Code + DeepSeek 启动 |
| [github-setup.md](docs/workflows/github-setup.md) | GitHub 仓库创建 |
| [feishu-openclaw-deployment.md](docs/workflows/feishu-openclaw-deployment.md) | 远程开发链路搭建 |
| [claude-code-relay.md](docs/workflows/claude-code-relay.md) | Relay 脚本使用说明 |
| [skills-strategy.md](docs/workflows/skills-strategy.md) | Skill 使用策略 |
| [docs/README.md](docs/README.md) | 文档目录索引 |

### 学习笔记

| 文档 | 主题 |
| --- | --- |
| [LearningBlog/README.md](LearningBlog/README.md) | 按日期和标签浏览 |
| [工具链搭建](LearningBlog/2026-05-06-toolchain-ssh-lfs-gh.md) | SSH Key、Git LFS、GitHub CLI 原理深挖 |
| [远程开发链路](LearningBlog/2026-05-06-unity6-ai-openclaw-feishu-claude-code-relay.md) | 飞书 + OpenClaw + Claude Code Relay |

---

## 参与贡献

这是个人学习项目。欢迎通过 GitHub Issues 提出建议和讨论。代码贡献请遵循 [CONTRIBUTING.md](CONTRIBUTING.md)、[CLAUDE.md](CLAUDE.md) 和 [.claude/rules/unity-csharp.md](.claude/rules/unity-csharp.md) 中的约定。

### 分支命名

```
milestone/m{N}-{slug}
# 示例：milestone/m1-fsm、milestone/m2-behavior
```

### 代码约定

- 中文沟通，英文标识符
- `[SerializeField] private` 优先于 `public` 字段
- AI 参数暴露到 Inspector
- 写代码后必须说明：挂载方式、所需组件、验证步骤
- 不提交：API Key、Unity Library、Temp、训练产物、用户设置

---

## 许可证

MIT — 详见 [LICENSE](LICENSE)。

---

<p align="center">
  <sub>用 Unity 6 构建 | Claude Code + DeepSeek 辅助开发 | 飞书 + OpenClaw 远程控制</sub>
</p>
