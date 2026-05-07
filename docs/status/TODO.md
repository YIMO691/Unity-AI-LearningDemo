# Unity6_AI TODO

## 阶段状态

- **Milestone 0**（工程基础）：✅ 已完成（2026-05-07）
- **Milestone 1**（传统游戏 AI）：🟡 进行中
- **Milestone 2**（群体 AI / Behavior）：⏳ 待启动
- **Milestone 3**（ML-Agents）：⏳ 待启动
- **Milestone 4**（Sentis 推理）：⏳ 待启动

---

## 当前任务（M1 — FSM 敌人 AI 原型）

### 1. 创建 FSM 枚举与核心脚本

**验收标准：**
- [ ] `Assets/_Project/Scripts/AI/EnemyState.cs` — 定义 `Patrol / Chase / Attack / Dead` 枚举
- [ ] `Assets/_Project/Scripts/AI/EnemyFSM.cs` — 实现状态切换逻辑
- [ ] 关键参数暴露到 Inspector：视野距离、攻击范围、巡逻速度、追踪速度

### 2. 配置 NavMesh

**验收标准：**
- [ ] Scene 中 Ground 标记 Navigation Static
- [ ] 添加 NavMesh Surface 组件并 Bake
- [ ] Scene 视图显示蓝色 NavMesh 行走区域

### 3. 搭建场景测试

**验收标准：**
- [ ] 场景中有 Player Cube + Enemy Capsule
- [ ] Enemy 挂载 EnemyFSM + NavMeshAgent
- [ ] Play 模式下：Player 远离时 Enemy 巡逻 → Player 靠近时追逐 → 进入范围后攻击

---

## 备忘

- 不要提交 `UnityProject/Library/`、`Temp/`、`.openclaw/` 等本地状态文件
- 包版本统一记录在 `docs/planning/package-manifest.md`
- 所有 C# 脚本放在 `UnityProject/Assets/_Project/Scripts/` 下

---

## 备忘

- 不要提交 `UnityProject/Library/`、`Temp/`、`.openclaw/cc-target.json`、`.openclaw/cc-sessions.json` 等本地状态文件
- 包版本统一记录在 `docs/planning/package-manifest.md`
- 所有 C# 脚本放在 `UnityProject/Assets/_Project/Scripts/` 下
- 所有场景放在 `UnityProject/Assets/_Project/Scenes/` 下
