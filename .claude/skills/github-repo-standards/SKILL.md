---
name: github-repo-standards
description: 检查和补齐 GitHub 仓库社区标准文件（SECURITY.md、CODEOWNERS、CONTRIBUTING.md、Issue/PR 模板、CI 等），确保仓库达到 GitHub 社区健康标准。
trigger: manual
---

# GitHub 仓库规范检查器

## 触发条件

用户说"检查仓库规范""规范仓库""仓库健康检查""补齐社区标准""仓库标准化"等。

## 流程

### Step 1 — 扫描现有文件

检查以下文件是否存在且非空：

| 文件 | 位置 | 用途 |
| --- | --- | --- |
| `CLAUDE.md` | 根目录 | AI 代理项目指令 |
| `README.md` | 根目录 | 项目介绍与快速开始 |
| `.gitignore` | 根目录 | 排除不需要版本控制的文件 |
| `.gitattributes` | 根目录 | Git LFS 与换行规则 |
| `.editorconfig` | 根目录 | 跨编辑器编码规范 |
| `SECURITY.md` | 根目录 | 安全漏洞报告流程 |
| `CONTRIBUTING.md` | 根目录 | 贡献指南 |
| `.github/CODEOWNERS` | `.github/` | 文件所有权与审查责任 |
| `.github/PULL_REQUEST_TEMPLATE.md` | `.github/` | PR 描述模板 |
| `.github/ISSUE_TEMPLATE/` | `.github/` | Issue 模板 |
| `.github/workflows/*.yml` | `.github/workflows/` | CI/CD 工作流 |
| `docs/README.md` | `docs/` | 文档索引 |

### Step 2 — 报告缺失

列出缺失或为空的文件，按优先级排列：
- 高优先级：`SECURITY.md`、`.github/CODEOWNERS`
- 中优先级：`CONTRIBUTING.md`、CI 工作流
- 低优先级：Issue 模板变体、文档索引

### Step 3 — 逐个补齐

询问用户要补齐哪些文件。对每个选中的文件：
1. 读取 `docs/templates/github/<filename>` 模板
2. 根据当前项目信息填充占位符
3. 写入目标位置
4. 如果是新目录（如 `.github/`），确保目录已存在

### Step 4 — 更新 CLAUDE.md

如果新增了之前未在 CLAUDE.md 中引用的重要文件，追加到文档索引表中。

## 模板位置

标准化文件模板位于 `docs/templates/github/`：

| 模板 | 对应输出 |
| --- | --- |
| `docs/templates/github/SECURITY.md` | `SECURITY.md` |
| `docs/templates/github/CODEOWNERS` | `.github/CODEOWNERS` |
| `docs/templates/github/CONTRIBUTING.md` | `CONTRIBUTING.md` |

## 内容约束

- 模板中的 `{GITHUB_USERNAME}` 等占位符需替换为实际值（从 `git config user.name` 或 GitHub API 获取）
- 不包含任何 API Key、Token、密码
- 适配单人学习项目的特点（CONTRIBUTING.md 简化，CODEOWNERS 设为项目作者）
