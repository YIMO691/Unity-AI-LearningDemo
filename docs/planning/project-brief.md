# 项目简报：Unity 6 AI 战斗演示

## 目标

构建一个 3D 战斗演示：一名玩家面对多名敌人。敌人需要展示巡逻、发现玩家、追踪、协同攻击、死亡，以及后续通过 ML-Agents 或 Sentis 增强的智能行为。

## 功能边界

- 玩家：基础移动、攻击、受伤、死亡。
- 敌人：FSM 原型，后续升级为行为树或 Unity Behavior。
- 导航：使用 NavMesh 控制敌人追踪和巡逻。
- 感知：视野、距离、遮挡检测，必要时加入听觉或警戒状态。
- 群体 AI：队长/队员或简单 flocking/队形协作。
- ML-Agents：至少完成一个可训练任务，并保留训练配置与评估记录。
- Sentis/推理：导入 ONNX 模型并在 Unity 中完成一次可验证推理。

## 里程碑

| 阶段 | 目标 | 主要交付物 | 验收标准 |
| --- | --- | --- | --- |
| M0 | Unity 6 工程基础 | `UnityProject/`、基础场景、包清单、测试目录 | Unity 可打开，空场景可运行 |
| M1 | 传统 AI 原型 | 敌人 FSM、NavMesh 巡逻/追踪/攻击 | 敌人能稳定切换状态 |
| M2 | 行为树与群体 AI | 行为图或行为树，小队协作 | 多敌人行为自然且可调参 |
| M3 | ML-Agents 训练 | 训练环境、YAML 配置、TensorBoard 记录 | 训练指标可解释并有模型产物 |
| M4 | Sentis 推理集成 | ONNX 导入、推理脚本、性能记录 | 模型在运行时可执行推理 |
| M5 | 集成与交付 | 完整 Demo、README、演示录屏、CI | 能从零复现并通过基础测试 |

## 推荐工程结构

```text
UnityProject/
├─ Assets/
│  └─ _Project/
│     ├─ Art/
│     ├─ Prefabs/
│     ├─ Scenes/
│     ├─ Scripts/
│     │  ├─ Core/
│     │  ├─ AI/
│     │  ├─ Player/
│     │  └─ Training/
│     └─ Tests/
├─ Packages/
└─ ProjectSettings/
```

## 初始包清单

在 Unity 6 Package Manager 中确认并安装：

- AI Navigation
- Behavior 或 Unity Behavior 相关包
- ML-Agents
- Sentis 或 Unity Inference Engine
- Test Framework

具体包名与版本以后续 Unity 6 Package Manager 显示为准。

