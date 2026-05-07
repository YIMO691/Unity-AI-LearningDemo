# Unity 包清单

> 在 M0 Task 0.5 完成后填写此文件。记录精确包名和版本号，确保环境可复现。

## 核心包

| 包名（com.unity.xxx） | 版本 | 用途 | 安装日期 |
| --- | --- | --- | --- |
| `com.unity.ai.navigation` | `2.0.12` | NavMesh 运行时与 Surface 组件 | 2026-05-06 |
| `com.unity.behavior` | 未安装 | Unity Behavior 可视化行为图 | 待确认 |
| `com.unity.ml-agents` | 未安装 | 强化学习训练框架 | 待确认 |
| `com.unity.sentis` | 未安装 | ONNX 模型推理引擎 | 待确认 |
| `com.unity.test-framework` | `1.6.0` | EditMode/PlayMode 测试 | 2026-05-06 |

## 间接依赖（自动安装）

记录安装上述包时 Unity 自动引入的关键依赖及其版本：

| 包名 | 版本 | 来源 |
| --- | --- | --- |
| `com.unity.inputsystem` | `1.19.0` | UnityProject/Packages/manifest.json |
| `com.unity.render-pipelines.universal` | `17.4.0` | UnityProject/Packages/manifest.json |
| `com.unity.visualscripting` | `1.9.11` | UnityProject/Packages/manifest.json |
