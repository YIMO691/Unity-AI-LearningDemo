# Unity6_AI TODO

## 阶段状态

- **Milestone 0**（工程基础）：🟡 进行中 — 骨架就绪，收尾任务未完成
- **Milestone 1**（传统游戏 AI）：⏳ 待启动
- **Milestone 2**（群体 AI / Behavior）：⏳ 待启动
- **Milestone 3**（ML-Agents）：⏳ 待启动
- **Milestone 4**（Sentis 推理）：⏳ 待启动

---

## 下一步任务（3 条）

### 1. 补完 Milestone 0 收尾 — 安装剩余包 + 空测试 + Git 首次提交

**验收标准：**
- [ ] `com.unity.behavior` 已安装（Package Manager 中可见）
- [ ] `com.unity.ml-agents` 已安装（版本统一记录到 `docs/planning/package-manifest.md`）
- [ ] `com.unity.sentis` 已安装
- [ ] `_Project/Tests/EditMode/SmokeTest.cs` 存在，Test Runner 显示 1/1 通过
- [ ] 首次 `git add . && git commit -m "Milestone 0: Unity 6 project skeleton"` 完成

### 2. 打开 Unity 验证场景 + 清理 Console 错误

**验收标准：**
- [ ] Unity Hub 中打开 `F:\Unity6_AI\UnityProject`
- [ ] Main.unity 加载无报错
- [ ] Play 模式下能看到灰色地面 + 光照
- [ ] Console 无红色/黄色错误
- [ ] 如果包安装后有新报错，记录并修复

### 3. 启动 Milestone 1 — FSM 敌人 AI 原型

**验收标准：**
- [ ] `_Project/Scripts/AI/` 下存在 FSM 枚举 `EnemyState` 定义
- [ ] `_Project/Scripts/AI/EnemyFSM.cs` 实现基础巡逻、追逐、攻击状态切换
- [ ] 场景中放置一个简易敌人 GameObject 并挂载脚本
- [ ] 手持测试：Play 模式下敌人可用键盘/鼠标控制目标，并验证状态切换

---

## 备忘

- 不要提交 `UnityProject/Library/`、`Temp/`、`.openclaw/cc-target.json`、`.openclaw/cc-sessions.json` 等本地状态文件
- 包版本统一记录在 `docs/planning/package-manifest.md`
- 所有 C# 脚本放在 `UnityProject/Assets/_Project/Scripts/` 下
- 所有场景放在 `UnityProject/Assets/_Project/Scenes/` 下
