---
name: learning-blog
description: 根据对话中学到的知识生成学习 Blog。当你学会新工具、新概念、或完成一套环境配置后，生成包含速查卡、原理深挖和输出成果的三层结构化 markdown 文章。
disable-model-invocation: true
---

# 学习 Blog 生成器

## 触发条件

用户说"生成学习 Blog"、"写一篇学习 Blog"、"记录一下今天学的"、"记一篇笔记"等。

## 流程

### Step 1 — 询问主题

问用户：这篇 Blog 的主题是什么？是单个工具/概念（如"SSH Key"）还是一套流程（如"工具链搭建"）？

### Step 2 — 询问风格

让用户选择：

- **A）纯速查卡** — 核心命令 + 排错表，1 页内
- **B）纯原理深挖** — 概念、Mermaid 图、协议细节，2000 字左右
- **C）纯备忘** — 只记操作步骤，不带解释
- （默认）**全部** — 速查卡 + 原理深挖 + 输出成果

### Step 3 — 提取素材

从当前对话中提取：
- 完成了哪些操作、用了哪些命令
- 遇到了什么错误、怎么解决的
- 涉及什么原理、和项目的什么部分关联
- 最终状态（验证命令输出）

### Step 4 — 按模板生成

模板文件位于 `docs/templates/learning-blog-template.md`。生成的文件放在 `LearningBlog/YYYY-MM-DD-{slug}.md`。

文件名为当前日期 + 主题 slug（小写英文，连字符分隔）。

### Step 5 — 更新索引

如果 `LearningBlog/README.md` 存在，在"文章列表"节追加新条目。

## 内容约束

- 代码块标注 `powershell`（终端命令）或 `cpp`/`csharp`（引擎代码）
- Mermaid 图只画序列图（`sequenceDiagram`）或流程图（`graph LR/TD`）
- 排错表用 markdown 表格，三列：现象 / 原因 / 解决
- 不写模板里没有的章节（如"总结"、"推荐阅读"）
- 不保存 API Key、Token、密码原文到 Blog
