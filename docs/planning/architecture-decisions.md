# 架构决策记录 (ADR)

本文档记录本项目关键技术选型及其理由。后续阶段如有变更，追加新条目而非覆盖旧条目。

---

## ADR-001: M1 FSM 实现方式 — MonoBehaviour + enum-switch

**决策日期:** 2026-05-06
**状态:** 已确定

在 M1 阶段，敌人 AI 使用 **MonoBehaviour + enum 状态机** 实现，不引入 ScriptableObject 或第三方 FSM 框架。

**理由:**
- 这是 Unity 中最简单、最直接的模式，适合学习传统 AI 的第一步。
- M2 会用 Unity Behavior 行为图替换 FSM，M1 的 FSM 只是原型和对照基线。
- ScriptableObject-based FSM 虽然更灵活，但增加复杂度，学习效果不如直接写 switch 清晰。

**关键实现约束:**
- 状态枚举统一为 `Patrol / Chase / Attack / Dead`
- 状态转换条件在 `Update()` 中逐帧检查
- 每个状态的行为封装为独立方法（`Patrol()`, `ChasePlayer()`, 等）
- 关键参数（视野距离、攻击范围、巡逻速度）暴露到 Inspector

---

## ADR-002: 行为树选型 — Unity Behavior (官方包)

**决策日期:** 2026-05-06
**状态:** 已更新（2026-05-07）

M2 阶段原计划使用 **Unity Behavior**（Unity 6 内置行为图包）。经过实际评估后，改为使用 **C# 代码行为树**（BTSelector/BTSequence/BTCondition/BTAction）。

**评估结论 (2026-05-07):**

| 需求 | Unity Behavior | C# Behavior Tree |
| --- | --- | --- |
| 随机巡逻点 | 内置 Patrol 节点功能有限 | `Random.insideUnitSphere` 任意定制 |
| 视线角度检测 | 条件表达式难以实现 | `Vector3.Angle` 一行 |
| Raycast 遮挡 | 图里无法实现 | 三行 `Physics.Raycast` |
| Inspector 调参 | 需要 Blackboard 手动绑定 | `[SerializeField]` 自动暴露 |
| 版本控制 | 二进制 .asset 文件，diff 不可读 | 纯文本 .cs，Git 友好 |

**最终方案:** C# Behavior Tree（6 个节点类 <100 行，`EnemyBT.cs` ~160 行）。
Behavior Graph 适合简单触发式逻辑（"进入区域→播放动画"），不适合需要每帧精确计算的战斗 AI。

---

## ADR-003: NavMesh 策略 — NavMesh Surface（运行时烘焙）

**决策日期:** 2026-05-06
**状态:** 已确定

使用 **NavMesh Surface** 组件（AI Navigation 包），而非 Unity 经典 NavMesh 窗口烘焙。

**理由:**
- NavMesh Surface 支持运行时重新烘焙，对动态场景更友好。
- Unity 6 中 NavMesh Surface 已成为推荐方案。
- 手动文档 (`docs/reference/manual.md`) 中引用的也是 NavMesh Surface 方式。

**约束:**
- 地面物体必须标记 Navigation Static
- 代理参数（半径 0.5m、高度 2m、步高 0.3m）作为项目默认值

---

## ADR-004: 感知系统 — Raycast + OverlapSphere 混合

**决策日期:** 2026-05-06
**状态:** 已确定

敌人感知使用 **Raycast（视线检测）+ OverlapSphere（近距感知）** 组合，不使用 Unity Perception 包或 ECS Sensors。

**理由:**
- 对于战斗 Demo 的规模（1 玩家 vs 5-10 敌人），Physics 开销在可接受范围内。
- LayerMask 过滤 + 缓存 Component 引用已足够优化。
- 学习目标之一是理解感知系统的底层实现，而非依赖高级抽象。

**后续演进:**
- M3 ML-Agents 阶段，感知可由 Agent 的观察空间替代。
- 如需听觉/警戒系统，用 OverlapSphere 梯度检测实现。

---

## ADR-005: 训练算法 — PPO（Proximal Policy Optimization）

**决策日期:** 2026-05-06
**状态:** 已确定

M3 ML-Agents 训练使用 **PPO** 算法。

**理由:**
- PPO 是 ML-Agents 的默认和主力算法，文档与社区支持最完善。
- 适合连续/离散混合动作空间，也是本项目战斗场景的需求。
- SAC（Soft Actor-Critic）作为备选，仅在 PPO 不收敛时考虑。

**训练配置基线:** 参见 `docs/reference/manual.md` 中的 YAML 示例配置。

---

## ADR-006: Sentis 推理后端 — Burst CPU 优先

**决策日期:** 2026-05-06
**状态:** 已确定

M4 Sentis 推理默认使用 **Burst CPU** 后端，GPU Compute 仅在视觉模型（ResNet 等）场景使用。

**理由:**
- 官方文档指出 Burst CPU 对于大多数模型速度更快。
- 战斗 Demo 中的推理模型预计较小（导航/决策），CPU 完全够用。
- 减少 GPU 占用，将 GPU 资源留给渲染。

---

## ADR-007: 项目目录结构 — Assets/_Project

**决策日期:** 2026-05-06
**状态:** 已确定

所有项目源代码、美术资源、预制体放在 `Assets/_Project/` 下，与第三方导入资源（`Assets/` 根目录）隔离。

**理由:**
- 下划线前缀在 Unity 中表示"项目自有内容"，与 Asset Store 导入内容区分。
- 便于 LICENSE 声明（`_Project` 内容为项目原创）。
- 这是 Unity 社区的广泛实践。

---

## ADR-008: 版本控制策略 — 分支 + PR + LFS

**决策日期:** 2026-05-06
**状态:** 已确定

- **分支命名:** `milestone/m{N}-{slug}`（如 `milestone/m1-fsm`）
- **合并方式:** Pull Request，需要至少一次代码审查（自己审查即可，但走 PR 流程保证记录）
- **LFS:** ONNX 模型、FBX/纹理/音频等二进制文件通过 Git LFS 存储
- **不提交的内容:** Unity Library/、Build/、训练 results/、`.env`、用户本地设置
