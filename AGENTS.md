# AI 代理交接说明

本仓库是一个中文学习与实战项目。目标是逐步完成 Unity 6 AI 战斗演示，而不是一次性生成大量不可验证代码。

## 项目目标

- 学习传统游戏 AI：FSM、NavMesh、感知系统。
- 学习 Unity Behavior/行为树与群体 AI。
- 使用 Unity ML-Agents 训练智能体。
- 使用 Sentis 或 Unity 推理引擎集成 ONNX 模型。
- 最终交付一个可运行、可讲解、可演示的 3D AI 战斗 Demo。

## 工作方式

- 使用中文和用户沟通，代码标识符保持英文。
- 每次只推进一个小里程碑，先写清验收标准，再实现。
- 先读 `docs/manual.md`、`docs/project-brief.md`、`docs/learning-roadmap.md`。
- Unity 工程根目录约定为 `UnityProject/`。
- 不提交 API Key、Unity Library、训练结果、缓存、用户本地设置。
- 生成代码后必须给出 Unity 中如何验证的步骤。

## 技术约束

- Unity 版本目标是 Unity 6；若本机未安装 Unity 6，先完成安装和项目创建。
- Unity 包版本必须在 Package Manager 中确认，不要凭记忆硬编码。
- C# 脚本放在 `UnityProject/Assets/_Project/Scripts/` 下。
- 测试放在 `UnityProject/Assets/_Project/Tests/` 下。
- AI 训练输出、ONNX 模型、大型资产不要直接提交；需要长期保存时先配置 Git LFS。

