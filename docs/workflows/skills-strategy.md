# Claude Code Skills 使用策略

本项目的原则：**少装通用 plugin，多写项目专用 skill；让 skill 处理重复流程，让文档保存项目事实。**

## 目录约定

```text
.claude/
├─ skills/
│  └─ unity6-ai-project/
│     └─ SKILL.md
├─ rules/
│  └─ unity-csharp.md
├─ agents/       # M1 以后按需添加
├─ commands/     # 仅保留少量手动快捷命令
└─ hooks/        # M0 暂不启用
```

Claude Code 项目级 skill 放在 `.claude/skills/<skill-name>/SKILL.md`。仓库根目录不再保留单独的 `skills/` 草稿目录，避免同一个 skill 出现两个来源。

## 已有能力

- **superpowers plugin**：用于复杂任务拆解、连续开发、复盘与自检。
- **GitHub plugin/skill**：用于 PR、issue、CI、提交和 GitHub 工作流。
- **skill-creator**：用于创建或改进自定义 skill。
- **skill-installer**：用于安装 curated 或 GitHub 上的 Codex skills。
- **`/plugin`**：Claude Code 中用于浏览、安装和管理插件；不要写成 `/plugins`。

## 当前启用的项目 skill

### `unity6-ai-project`

用途：本仓库的总控 skill。它应该在处理 Unity6_AI 项目、M0-M5 里程碑、Unity 工程结构、学习路线、Claude/DeepSeek 交接时触发。

位置：`.claude/skills/unity6-ai-project/SKILL.md`。

### `learning-blog`

用途：手动生成学习 Blog，把一次工具链配置、概念学习或里程碑经验整理成速查卡、原理深挖和输出成果。通过 `/learning-blog` 触发，不让模型自动调用。

位置：`.claude/skills/learning-blog/SKILL.md`。模板位于 `docs/templates/learning-blog-template.md`，输出目录为 `LearningBlog/`。

## 后续按里程碑新增

### `unity-csharp-review`

用途：M1-M2 开始后创建。专门约束 Unity C#、MonoBehaviour、FSM、NavMesh、感知系统、行为树、Inspector 调参、Unity Test Runner 验证。

建议创建时机：Unity 6 工程创建完成，并写出第一批脚本后。

### `unity-test-runner`

用途：M1 以后创建。专门记录 EditMode/PlayMode 测试、Unity Test Runner 操作、CI 中测试结果排查。

建议创建时机：第一个 `SmokeTest.cs` 创建并跑通后。

### `ml-agents-training`

用途：M3 开始后创建。专门记录 Python 环境、`mlagents-learn` 命令、YAML 配置、奖励设计、TensorBoard 记录和训练产物管理。

建议创建时机：ML-Agents 包和 Python 环境确定后。

### `sentis-inference`

用途：M4 开始后创建。专门记录 ONNX 导入、输入输出映射、Tensor 转换、CPU/GPU 后端选择和性能记录流程。

建议创建时机：第一个 ONNX 模型进入项目后。

### `unity-ci-release`

用途：M5 或 CI 稳定后创建。专门处理 GitHub Actions、GameCI、Unity License、测试、构建、Artifact 和 Release。

建议创建时机：`UnityProject/` 已经可以被 CI 打开并跑测试后。

## Agents、Commands、Hooks、MCP 策略

- **Agents**：M1 以后按需添加 `.claude/agents/unity-architect.md`、`.claude/agents/gameplay-ai-engineer.md`、`.claude/agents/unity-test-engineer.md`。M0 暂不创建，避免职责过早固化。
- **Commands**：少量高频手动流程可放到 `.claude/commands/`。如果同一流程也适合作为 skill，优先写成 skill，并按需要设置为仅手动触发。
- **Hooks**：M0 暂不启用。后续优先添加安全型 hook，例如阻止提交 API Key、`Library/`、训练输出。
- **MCP servers / monitors**：等 Unity 工程、测试、CI 跑通后再评估。只接入可信来源，并在启用前记录权限边界。

## 不建议现在安装太多通用 skills

现在项目还在 M0，最容易出问题的是上下文过载。除非马上需要，否则先不要安装一大批和 Unity 无关的文档、表格、PPT、PDF、图片处理类 skills。

目前真正需要的是：

- superpowers：保留。
- GitHub：保留。
- 项目自定义 `unity6-ai-project`：已迁移到 `.claude/skills/`，优先使用。
- 学习记录 `learning-blog`：保留为手动触发 skill。
- 后续按里程碑再创建 `unity-csharp-review`、`unity-test-runner`、`ml-agents-training`、`sentis-inference`。

## 触发规则

- 问“怎么推进项目/下一步做什么/里程碑状态”：用 `unity6-ai-project`。
- 写 Unity C# 行为脚本：用 `unity-csharp-review`，未创建前用 `.claude/rules/unity-csharp.md`。
- 生成或排查 Unity 测试：用 `unity-test-runner`。
- 训练智能体：用 `ml-agents-training`。
- 导入或运行 ONNX：用 `sentis-inference`。
- PR、CI、issue、远程仓库：用 GitHub skill。
- 学习笔记、阶段复盘、工具链记录：手动触发 `/learning-blog`。
- 浏览或安装 Claude Code 插件：用 `/plugin`。
- 创建或修改 skill 本身：用 skill-creator。
- 安装第三方 skill：用 skill-installer。

## 维护规则

- 每个 skill 的 `SKILL.md` 保持短小，只写触发条件和核心流程。
- 详细资料放在 `docs/`，不要复制进 skill。
- 每个里程碑结束后复盘一次：哪些流程重复了三次以上，就考虑沉淀为 skill。
- skill 不保存密钥、账号、License 或本地绝对路径以外的私人凭据。
- 安装第三方 plugin 前确认来源可信；plugin 可能包含 commands、agents、hooks、skills、MCP servers 或 monitors。
