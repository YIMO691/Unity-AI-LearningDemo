# 文件组织规范

> 本文件是项目文件分类的**唯一权威规则**。添加新文件前必须参考此文档。

---

## 核心原则

1. **每个文件有唯一归属目录** — 不存在"临时放一下根目录"的情况
2. **根目录最小化** — 仅保留外部工具期望的入口文件
3. **同类文件同目录** — 按类型分层，不按创建时间分散
4. **先看规则再建文件** — 新增文件前用下面的决策流程找到正确位置

---

## 新文件决策流程

```
问自己：这是什么类型？
├─ Unity 项目文件（C#/场景/预制体/材质/Shader）
│   → UnityProject/Assets/_Project/ （按 Scripts/Scenes/Prefabs/Art/Tests 分层）
│
├─ 项目文档（计划/架构/状态/环境/工作流）
│   → docs/ （按子域：planning/ status/ reference/ workflows/ environment/ templates/）
│
├─ 学习笔记（工具原理/排错经验/配置记录）
│   → LearningBlog/YYYY-MM-DD-{slug}.md
│
├─ 自动化脚本（PowerShell/Python/Bash）
│   ├─ 启动/环境相关 → scripts/
│   └─ 通用工具脚本 → tools/
│
├─ 配置文件
│   ├─ Git 相关（.gitignore/.gitattributes/.editorconfig）→ 根目录
│   ├─ GitHub 相关（CI/模板/CODEOWNERS）→ .github/
│   ├─ Claude Code 相关（skills/rules/commands/hooks）→ .claude/
│   ├─ OpenClaw 相关（agent notes/session state）→ .openclaw/
│   └─ Unity 相关（manifest.json/ProjectSettings）→ UnityProject/（由 Unity 管理）
│
├─ AI 代理入口文档（CLAUDE.md/AGENTS.md/README.md）
│   → 根目录（外部工具默认读取）
│
├─ AI 提示词模板
│   → prompts/（活跃使用）/ docs/templates/（归档参考）
│
└─ 运行时日志输出
    → Logs/ （不提交到 Git）
```

---

## 顶层目录职责

### `UnityProject/`
| 属性 | 值 |
| --- | --- |
| **职责** | Unity 6 游戏工程，由 Unity 编辑器全权管理 |
| **管理者** | Unity Editor + `.gitignore` |
| **禁止放入** | 非 Unity 文档、独立脚本、学习笔记 |

内部结构：
```text
UnityProject/
├─ Assets/_Project/         ← 项目原创资源（与第三方资源隔离）
│  ├─ Art/                  ← 材质、模型、纹理
│  ├─ Prefabs/              ← 预制体
│  ├─ Scenes/               ← 场景文件
│  ├─ Scripts/              ← C# 脚本（Core/AI/Player/Training）
│  └─ Tests/                ← EditMode + PlayMode 测试
├─ Assets/Settings/         ← Unity Input/URP 等设置资产
├─ Packages/                ← manifest.json + packages-lock.json
├─ ProjectSettings/         ← Unity 编辑器全局设置
├─ Library/                 ← 本地缓存（.gitignore 排除）
├─ Logs/                    ← 本地日志（.gitignore 排除）
└─ UserSettings/            ← 用户本地设置（.gitignore 排除）
```

### `docs/`
| 属性 | 值 |
| --- | --- |
| **职责** | 所有项目文档，按子域分层 |
| **禁止放入** | 可执行脚本、Unity 资产、日志、个人笔记 |

子域约定：
```text
docs/
├─ README.md                ← 文档分类索引（必须维护）
├─ planning/                ← 计划类：里程碑、路线图、架构决策、包清单
├─ status/                  ← 状态类：PROGRESS.md、TODO.md、AI_DEV_LOG.md
├─ reference/               ← 参考类：手册归档、文件组织规范
├─ workflows/               ← 流程类：启动步骤、CI/CD、工具链操作
├─ environment/             ← 环境类：本机检测报告
└─ templates/               ← 模板类：可复用的文件模板（github/、learning-blog/ 等）
```

### `LearningBlog/`
| 属性 | 值 |
| --- | --- |
| **职责** | 个人学习笔记，记录工具原理、排错经验、配置成果 |
| **文件名** | `YYYY-MM-DD-{slug}.md` |
| **禁止放入** | 项目计划、架构决策、README 类索引文档 |

### `tools/`
| 属性 | 值 |
| --- | --- |
| **职责** | 本地自动化 PowerShell 脚本 |
| **禁止放入** | 文档、配置文件、启动脚本（放 `scripts/`） |

脚本分类：
```text
tools/
├─ claude-code-relay.ps1   ← Claude Code relay 核心
├─ cc-run.ps1              ← /cc-run 编辑模式
├─ cc-run-big.ps1          ← /cc-run 长任务模式
├─ cc-command.ps1          ← /cc 只读命令
├─ cc-status.ps1           ← /cc-status 任务状态
├─ cc-last.ps1             ← /cc-last 最近摘要
├─ cc-session.ps1          ← 会话管理
├─ cc-session-add.ps1      ← 添加会话
├─ cc-session-remove.ps1   ← 移除会话
├─ cc-use.ps1              ← 指定会话
├─ oc-session.ps1          ← OpenClaw 会话
├─ claude-code-summary.ps1 ← 摘要生成
├─ mobile-status.ps1       ← 飞书移动端状态
├─ feishu-progress-command.ps1 ← 飞书进度指令
└─ unity-log-summary.ps1   ← Unity 日志摘要
```

> 注意：`tools/` 中的脚本被 `.openclaw/`、`.claude/commands/` 和飞书指令引用，移动脚本路径前必须检查所有引用方。

### `scripts/`
| 属性 | 值 |
| --- | --- |
| **职责** | Claude Code/DeepSeek 启动与环境配置脚本 |
| **禁止放入** | 通用工具脚本（放 `tools/`）、文档 |

### `.claude/`
| 属性 | 值 |
| --- | --- |
| **职责** | Claude Code 配置 |
| **标准子目录** | `skills/`、`rules/`、`commands/`、`agents/`、`hooks/` |
| **禁止放入** | 用户密钥、个人设置（放 settings.local.json，由 .gitignore 排除） |

### `.github/`
| 属性 | 值 |
| --- | --- |
| **职责** | GitHub 平台配置 |
| **标准内容** | `workflows/*.yml`、`ISSUE_TEMPLATE/`、`PULL_REQUEST_TEMPLATE.md`、`CODEOWNERS` |
| **禁止放入** | 非 GitHub 配置、文档 |

### `.openclaw/`
| 属性 | 值 |
| --- | --- |
| **职责** | OpenClaw Gateway 运行状态与 Agent 配置 |
| **管理者** | OpenClaw CLI |
| **禁止放入** | 项目文档、仓库需要版本控制的文件 |

### `prompts/`
| 属性 | 值 |
| --- | --- |
| **职责** | 给 AI 代理的启动提示词模板 |
| **禁止放入** | 已过期/已完成的提示词、通用文档 |

### `Logs/`
| 属性 | 值 |
| --- | --- |
| **职责** | 项目本地日志输出（CI 结果、测试运行记录） |
| **提交策略** | 不提交到 Git（.gitignore 已覆盖） |

---

## 根目录白名单

根目录**仅允许**以下文件存在：

| 允许的文件/目录 | 类型 | 原因 |
| --- | --- | --- |
| `.editorconfig` | 配置 | 跨编辑器编码规范 |
| `.gitignore` | 配置 | Git 忽略规则 |
| `.gitattributes` | 配置 | Git LFS 与换行规则 |
| `.env.example` | 配置 | 环境变量模板（不含真实密钥） |
| `README.md` | 文档 | GitHub/Git 平台默认展示 |
| `CLAUDE.md` | 文档 | Claude Code 默认读取 |
| `AGENTS.md` | 文档 | AI 代理交接说明 |
| `SECURITY.md` | 文档 | GitHub 安全策略 |
| `CONTRIBUTING.md` | 文档 | 贡献指南 |
| `.claude/` | 目录 | Claude Code 配置 |
| `.github/` | 目录 | GitHub 配置 |
| `.openclaw/` | 目录 | OpenClaw 配置 |
| `docs/` | 目录 | 项目文档 |
| `LearningBlog/` | 目录 | 学习笔记 |
| `UnityProject/` | 目录 | Unity 工程 |
| `tools/` | 目录 | 自动化脚本 |
| `scripts/` | 目录 | 启动脚本 |
| `prompts/` | 目录 | 提示词模板 |
| `Logs/` | 目录 | 本地日志 |

**任何不在此清单的文件或目录，不得放在根目录。**

---

## 违规处理

如果发现文件放错位置：
1. 不是紧急问题 → 记录到 `docs/status/TODO.md`
2. 如果文件被其他文件引用 → 先检查引用链，再移动
3. 移动后必须更新所有引用该文件路径的代码/文档

---

## 维护

- 本文件由 `github-repo-standards` skill 在"检查仓库规范"时对比实际状态
- 新增顶层目录类型时，同步更新此文档和根目录白名单
