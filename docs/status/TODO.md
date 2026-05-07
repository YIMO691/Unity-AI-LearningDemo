# Unity6_AI TODO

## 阶段状态

- **Milestone 0**（工程基础）：✅ 已完成（2026-05-07）
- **Milestone 1**（传统游戏 AI）：✅ 已完成（2026-05-07）
- **Milestone 2**（行为树 / 群体 AI）：✅ 已完成（2026-05-07）
- **Milestone 3**（ML-Agents）：⏳ 待启动
- **Milestone 4**（Sentis 推理）：⏳ 待启动

---

## 当前任务（M3 — ML-Agents 强化学习训练）

### 前置准备
- [ ] 确认 `com.unity.ml-agents` 4.0.3 已安装
- [ ] 搭建 Python 训练环境（mlagents Python 包）
- [ ] 创建训练配置文件（YAML）

### 训练任务
- [ ] 设计训练场景（TrainEnv.unity）
- [ ] 实现自定义 Agent（观察空间 + 动作空间 + 奖励）
- [ ] 本地训练并观察 TensorBoard 曲线
- [ ] 导出 ONNX 模型

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
