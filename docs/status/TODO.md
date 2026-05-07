# Unity6_AI TODO

## 阶段状态

- **Milestone 0**（工程基础）：✅ 已完成（2026-05-07）
- **Milestone 1**（传统游戏 AI）：✅ 已完成（2026-05-07）
- **Milestone 2**（行为树 / 群体 AI）：🟡 进行中
- **Milestone 3**（ML-Agents）：⏳ 待启动
- **Milestone 4**（Sentis 推理）：⏳ 待启动

---

## 当前任务（M2 — 行为树 / 群体 AI）

### 选项

**A) Unity Behavior 行为图**
- [ ] 安装并打开 Unity Behavior 包
- [ ] 创建 Behavior Graph 替代 FSM
- [ ] 用可视化节点实现 Patrol→Chase→Attack→Death
- [ ] 验证行为与 M1 功能等价

**B) 群体 AI**
- [ ] 复制 3-5 个 Enemy 到场景
- [ ] 实现 Boids 分离/对齐/凝聚
- [ ] 验证多敌人不重叠、有分工

**C) 两者同时推进**
- [ ] 先 A 后 B

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
