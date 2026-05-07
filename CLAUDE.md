# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是一个 Unity 6 AI 学习与实战仓库，目标是逐步构建一个 **3D AI 战斗演示**：玩家 vs 多名敌人，涵盖 FSM、行为树、NavMesh、感知系统、群体 AI、ML-Agents 训练和 Sentis/ONNX 推理。

## 当前状态

**Phase 0 completed / Phase 1 ready** — `UnityProject/` 已创建并可由 Unity 6 打开。当前重点是重新确认 `Assets/_Project/Scenes/Main.unity` 无 Console 新错误，然后开始 M1 的 FSM、NavMesh、感知系统原型。

## 启动方式

```powershell
cd F:\Unity6_AI
$env:DEEPSEEK_API_KEY="sk-你的key"
.\scripts\start-claude-deepseek.cmd
```

启动脚本会自动设置 Anthropic 兼容端点指向 DeepSeek API，模型配置见 `.env.example`。不要将 API Key 写入仓库文件。

## 常用命令

- 启动 Claude Code（DeepSeek 后端）：`.\scripts\start-claude-deepseek.cmd`
- 分支命名：`milestone/m0-setup`、`milestone/m1-fsm` 等
- Unity 工程内测试通过 Unity Test Runner 运行，不使用 dotnet CLI

## 工程结构

```text
UnityProject/
├─ Assets/_Project/
│  ├─ Art/
│  ├─ Prefabs/
│  ├─ Scenes/
│  ├─ Scripts/
│  │  ├─ Core/
│  │  ├─ AI/
│  │  ├─ Player/
│  │  └─ Training/
│  └─ Tests/
├─ Packages/
└─ ProjectSettings/
```

C# 脚本放在 `Assets/_Project/Scripts/` 下，测试放在 `Assets/_Project/Tests/` 下。

## 里程碑

| 阶段 | 目标 | 交付物 |
| --- | --- | --- |
| M0 | Unity 6 工程基础 | 工程创建、目录结构、包安装、基础场景、空测试 |
| M1 | 传统 AI 原型 | 敌人 FSM、NavMesh 巡逻/追踪/攻击 |
| M2 | 行为树与群体 AI | 行为图/行为树、小队协作 |
| M3 | ML-Agents 训练 | 训练环境、YAML 配置、TensorBoard 记录 |
| M4 | Sentis 推理集成 | ONNX 导入、推理脚本、性能记录 |
| M5 | 集成与交付 | 完整 Demo、README、CI、演示录屏 |

## Unity 包清单（需在 M0 确认）

- AI Navigation
- Behavior（Unity Behavior 行为图）
- ML-Agents
- Sentis（或 Unity Inference Engine）
- Test Framework

包名与版本以 Unity 6 Package Manager 实际显示为准，不要凭记忆硬编码。

## 开发约束

- 使用中文沟通，代码标识符保持英文
- 每次只推进一个小里程碑，先写清验收标准再实现
- 序列化字段使用 `[SerializeField] private`，避免 public 字段
- AI 行为关键参数（半径、速度、冷却时间）放到 Inspector
- 生成代码后必须说明：挂载到哪个 GameObject、需要哪些组件、如何在 Unity 中验证
- 不提交 API Key、Unity Library、训练结果、缓存、用户本地设置
- `.claude/rules/unity-csharp.md` 中有更详细的 C# 编码规则

## 远程指令规则

以下规则对 OpenClaw Agent 和 Claude Code 均适用：

### 角色边界

- **OpenClaw Agent 不直接编辑项目文件。** 所有文件修改必须通过 Claude Code CLI 执行。
- 文件读取、检查状态、查看日志等只读操作可由 Agent 直接执行。

### 指令转述规则

- `/cc-run <任务>` — 原封不动将 `<任务>` 传给 relay 脚本，不做包装、不做解释、不增删改。
- `/cc-run-big <任务>` — 原封不动将 `<任务>` 传给 claude CLI（headless 模式），不做包装、不做解释、不增删改。

### 安全约束

- 禁止 git push。
- 禁止删除文件或目录。
- 禁止输出或保存 API Key、Token、密码。
- 禁止修改 OpenClaw/Claude Code 密钥配置。
- 禁止修改 Windows 系统级设置。

> 详细规则见 `.claude/rules/remote-commands.md`。

## 关键文档

| 文档 | 用途 |
| --- | --- |
| `AGENTS.md` | 通用 AI 代理交接说明 |
| `docs/README.md` | 文档分类索引 |
| `docs/reference/manual.md` | 原始学习手册归档（只读） |
| `docs/planning/project-brief.md` | 项目需求与里程碑详情 |
| `docs/planning/learning-roadmap.md` | 学习路线与进度跟踪（每阶段更新） |
| `docs/planning/milestone-m0-plan.md` | **M0 详细任务清单与验收标准** |
| `docs/planning/architecture-decisions.md` | **架构决策记录（技术选型与理由）** |
| `docs/workflows/claude-deepseek-workflow.md` | Claude Code + DeepSeek 启动详解 |
| `docs/workflows/github-setup.md` | GitHub 仓库创建步骤 |
| `docs/environment/environment-report.md` | 本机环境检测报告 |
| `docs/planning/package-manifest.md` | Unity 包名与版本锁定记录 |
| `docs/workflows/skills-strategy.md` | Claude Code Skills/Agents/Commands/Hooks/MCP 使用策略 |
| `docs/status/PROGRESS.md` | 项目当前进度 |
| `docs/status/TODO.md` | 当前任务清单 |
| `docs/status/AI_DEV_LOG.md` | AI 协作记录 |
| `docs/reference/skills-manifest.md` | **Skill 清单与使用决策流程（新增 skill 前必读）** |
| `docs/reference/file-organization-convention.md` | 文件组织规范（新文件放哪的决策流程） |
| `SECURITY.md` | 安全漏洞报告流程 |
| `CONTRIBUTING.md` | 贡献指南与 PR 检查清单 |
| `.github/CODEOWNERS` | 文件所有权与审查责任分配 |

## 工程化基础

- **架构决策：** `docs/planning/architecture-decisions.md` — 所有技术选型及理由，M1-M5 编码前必读
- **M0 执行：** 按 `docs/planning/milestone-m0-plan.md` 逐步完成，每完成一个 Task 勾选验收
- **CI：** `.github/workflows/unity-ci.yml` — 使用 `game-ci/unity-builder`，需要在 GitHub Secrets 配置 `UNITY_LICENSE`、`UNITY_EMAIL`、`UNITY_PASSWORD`
- **Git LFS：** `.gitattributes` 已配置，首次提交前运行 `git lfs install` 确认 LFS 已初始化
- **包版本锁定：** M0 安装包后记录实际版本到 `docs/planning/package-manifest.md`
- **文件组织：** `docs/reference/file-organization-convention.md` — 新增文件前必须参考，确保每个文件放在正确位置，根目录仅允许白名单中的文件

## Skill 使用策略

> 完整清单与决策流程见 **`docs/reference/skills-manifest.md`**（当前 20 个 skill，按场景分组）。

- 项目级 skill 优先：`unity6-ai-project`（总控）、`unity6-ai-progress-reporter`（进度）、`learning-blog`（笔记）、`github-repo-standards`（仓库规范）
- 开发流程用 superpowers：规划→brainstorming→writing-plans→test-driven-development→verification→code-review
- Unity C# 代码规则自动生效：`.claude/rules/unity-csharp.md`
- 插件管理用 `/plugin`，不要写成 `/plugins`
- 新增 skill 前先查 manifest，避免重复；新增后必须更新 manifest
- 不要在 M0-M1 阶段启用 ML-Agents、Sentis、CI 相关的计划中 skill
