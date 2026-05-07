# Skill 清单与使用决策

> 最后更新：2026-05-07 | 维护：新增/删除 skill 时同步更新此文档

---

## 总览

| 来源 | 数量 | 说明 |
| --- | --- | --- |
| 项目级 skill（`.claude/skills/`） | 4 | 本项目专用，优先使用 |
| 项目级 command（`.claude/commands/`） | 1 | 轻量快捷命令 |
| 项目级 rule（`.claude/rules/`） | 2 | 自动规则，无需手动触发 |
| superpowers 插件 skill | 14 | 通用开发工作流 |
| github 插件 | 1 | GitHub 操作 |

**当前活跃的 skill/command 总数：20**

---

## 使用决策流程图

```
我要做什么？
├─ 📋 查进度 / 飞书汇报
│   → progress command（轻量）/ unity6-ai-progress-reporter skill（详细）
│
├─ 🏗️ 推进里程碑 / 写 Unity 代码
│   → unity6-ai-project skill（项目总控）
│   → 代码规则自动生效：unity-csharp rule
│   → 远程操作限制自动生效：remote-commands rule
│
├─ 🎨 规划新功能 / 设计方案
│   → superpowers:brainstorming（必用）
│   → superpowers:writing-plans（写实现计划）
│
├─ ⌨️ 写代码实现功能
│   → superpowers:test-driven-development（先写测试）
│   → superpowers:using-git-worktrees（隔离工作区）
│   → superpowers:subagent-driven-development（多任务并行）
│   → superpowers:executing-plans（按计划逐步执行）
│
├─ 🔍 遇到 Bug / 测试失败
│   → superpowers:systematic-debugging（必用，不要自己猜）
│
├─ ✅ 完成功能 / 准备合并
│   → superpowers:verification-before-completion（先验证再声称完成）
│   → superpowers:requesting-code-review（请求审查）
│   → superpowers:finishing-a-development-branch（决定合并方式）
│
├─ 📝 写学习笔记
│   → learning-blog skill（速查卡 + 原理深挖 + 输出成果）
│
├─ 🏥 检查仓库规范
│   → github-repo-standards skill
│
├─ 🔧 改配置 / 权限 / 自动化
│   → update-config skill（settings.json 管理）
│
└─ 📦 GitHub 操作（PR / Issue / CI）
    → review skill（审查 PR）
    → security-review skill（安全检查）
    → gh CLI（创建 PR / Issue 用命令行更直接）
```

---

## 项目专用 skill（最优先）

### `unity6-ai-project`
| 项目 | 值 |
| --- | --- |
| **触发** | 工作在这个仓库时自动激活 |
| **用途** | 项目总控 — 里程碑规划、工程结构、包安装、学习路线更新、验证说明 |
| **何时不用** | 非 Unity6_AI 仓库、纯粹聊天 |

### `unity6-ai-progress-reporter`
| 项目 | 值 |
| --- | --- |
| **触发** | 询问项目进度、移动端状态、飞书状态、Git 状态、Unity 日志、测试结果 |
| **用途** | 汇总项目状态，适合飞书/手机查看 |
| **何时不用** | 实际上手写代码、架构设计 |

### `learning-blog`
| 项目 | 值 |
| --- | --- |
| **触发** | 手动 — 说"生成学习 Blog""记一篇笔记" |
| **用途** | 从对话中提取知识，生成三层结构化 markdown |
| **何时不用** | 项目文档、计划文档 |
| **注意** | `disable-model-invocation: true`，必须明确说出口令 |

### `github-repo-standards`
| 项目 | 值 |
| --- | --- |
| **触发** | 手动 — 说"检查仓库规范""补齐社区标准" |
| **用途** | 扫描缺失的 GitHub 标准文件，按模板生成 |
| **何时不用** | 日常开发、写代码 |

---

## 项目专用 Command

### `progress`
| 项目 | 值 |
| --- | --- |
| **触发** | 手动 — `/progress` 或说"项目进度" |
| **用途** | 轻量级进度摘要（1200 字内），调 `mobile-status.ps1` |
| **与 unity6-ai-progress-reporter 的区别** | `progress` 是快捷指令，输出精简；`progress-reporter` 是完整 skill，可分析 Unity 日志 |

---

## 项目专用 Rule（自动生效，无需手动触发）

| Rule | 作用范围 | 内容 |
| --- | --- | --- |
| `unity-csharp.md` | `UnityProject/Assets/**/*.cs` | SerializeField private、Inspector 参数化、组件缓存、验证说明 |
| `remote-commands.md` | 全局 | 远程指令安全边界（禁 push、禁删目录、禁泄露密钥） |

---

## Superpowers 插件 skill（通用开发流程）

### 规划阶段
| Skill | 何时用 | 何时不用 |
| --- | --- | --- |
| `brainstorming` | 开始任何创造性工作之前 | 修 typo、单行改动 |
| `writing-plans` | 有 spec/需求，准备写代码前 | 无需计划的小改动 |
| `dispatching-parallel-agents` | 2+ 个独立任务可并行 | 任务有依赖关系 |

### 开发阶段
| Skill | 何时用 | 何时不用 |
| --- | --- | --- |
| `test-driven-development` | 实现功能或修 Bug 前 | 已写好测试的项目、纯文档修改 |
| `using-git-worktrees` | 开始功能开发前、执行实现计划前 | 已经在 worktree 中 |
| `subagent-driven-development` | 执行有独立任务的实现计划 | 单个简单任务 |
| `executing-plans` | 有完整实现计划要执行 | 没有计划直接写代码 |

### 审查与完成阶段
| Skill | 何时用 | 何时不用 |
| --- | --- | --- |
| `verification-before-completion` | 声称完成/修复/通过之前 | 确认还没做完 |
| `requesting-code-review` | 完成大功能、准备合并前 | 途中草稿 |
| `receiving-code-review` | 收到审查反馈，实施修改前 | 只是阅读反馈 |
| `finishing-a-development-branch` | 实现完成、测试通过后决定如何合并 | 还在开发中 |
| `systematic-debugging` | 遇到 Bug、测试失败、意外行为 | 已经知道根因的简单修复 |

### 工具类
| Skill | 何时用 | 何时不用 |
| --- | --- | --- |
| `using-superpowers` | 新会话开始时 | 已知 superpowers 用法 |
| `writing-skills` | 创建/编辑 skill 时 | 使用已有 skill |
| `simplify` | 代码审查/质量检查 | 功能尚未完成 |
| `fewer-permission-prompts` | 频繁被权限弹窗打断 | 权限配置已经稳定 |

---

## 独立工具 skill

| Skill | 来源 | 何时用 |
| --- | --- | --- |
| `review` | claude-code built-in | PR 审查 |
| `security-review` | claude-code built-in | 分支合并前安全检查 |
| `init` | claude-code built-in | 新仓库初始化 CLAUDE.md |
| `update-config` | claude-code built-in | 修改 settings.json、hooks、权限 |
| `claude-api` | claude-code built-in | 写 Claude API / Anthropic SDK 代码时 |
| `keybindings-help` | claude-code built-in | 自定义键盘快捷键 |
| `loop` | claude-code built-in | 创建定时/重复任务 |

---

## 禁止清单

以下 skill **在 M0-M1 阶段不应启用**，避免上下文过载：

| Skill | 何时启用 |
| --- | --- |
| `ml-agents-training`（计划中） | M3 开始 |
| `sentis-inference`（计划中） | M4 开始 |
| `unity-ci-release`（计划中） | CI 稳定后 |
| `unity-csharp-review`（计划中） | 第一批脚本写出后 |
| `unity-test-runner`（计划中） | SmokeTest.cs 跑通后 |

---

## 维护规则

1. **新增 skill 后必须更新本文档** — 加到对应分组，写好触发条件
2. **删除 skill 后必须更新本文档** — 移除条目，如果影响决策流程则更新流程图
3. **里程碑复盘时检查 skill 清单** — 有没有创建了但从未用过的 skill？考虑停用或删除
4. **每个 skill 的 SKILL.md 保持短小** — 只写触发条件和核心流程，详细资料放 `docs/`
5. **上下文预算** — 当前 20 个 skill 已经不少，新增前先问：能不能合并到已有 skill？
