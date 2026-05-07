# Milestone 0：Unity 6 工程基础

**预计耗时:** 0.5-1 天 | **前置条件:** 无

---

## M0 目标

创建可运行、可测试、可版本控制的 Unity 6 工程骨架，为 M1 编码做准备。

## 定义完成 (DoD)

- [ ] Unity 6 编辑器可打开 `UnityProject/` 且无错误
- [ ] 基础场景可 Play 运行，Game 视图显示地面和光照
- [ ] 所有计划包已安装且版本已记录
- [ ] 第一个空 EditMode 测试通过（Test Runner 绿色）
- [ ] Git LFS 已初始化且 `.gitattributes` 生效
- [ ] 代码已推送 GitHub，CI 编译通过

---

## 任务拆分

### Task 0.1: 检查本机环境

| 项目 | 说明 |
| --- | --- |
| **检查项** | Unity Hub 是否已安装？Unity 6 编辑器是否可用？ |
| **操作** | 打开 Unity Hub → Installs，确认有 Unity 6.x 版本 |
| **若未安装** | 在 Unity Hub → Installs → Install Editor → 选择 Unity 6 LTS → 勾选 Windows Build Support → 安装 |
| **验收** | Unity Hub 显示 Unity 6 编辑器可用 |

### Task 0.2: 创建 Unity 6 3D 项目

| 项目 | 说明 |
| --- | --- |
| **操作** | Unity Hub → New Project → 3D (URP 或 Built-in) → 项目名 `UnityProject` → 路径 `F:\Unity6_AI\UnityProject` |
| **渲染管线** | 先选 Built-in Render Pipeline（学习项目不需要 URP/HDRP 的复杂度，后续可升级） |
| **验收** | Unity 编辑器打开，Project 窗口显示默认 `SampleScene`，无 Console 错误 |

### Task 0.3: 建立目录结构

在 `Assets/` 下创建以下目录：

```text
Assets/
├─ _Project/
│  ├─ Art/
│  │  ├─ Materials/
│  │  ├─ Models/
│  │  └─ Textures/
│  ├─ Prefabs/
│  ├─ Scenes/
│  ├─ Scripts/
│  │  ├─ Core/
│  │  ├─ AI/
│  │  ├─ Player/
│  │  └─ Training/
│  └─ Tests/
│     ├─ EditMode/
│     └─ PlayMode/
```

| **验收** | Project 窗口中所有目录可见，`_Project` 在 `Assets` 下 |

### Task 0.4: 创建基础场景

| 项目 | 说明 |
| --- | --- |
| **操作** | 保存/重命名默认 SampleScene 为 `Main`，放在 `_Project/Scenes/` |
| **内容** | 添加 Plane (Ground)、Directional Light、Main Camera（挂在空 GameObject 或保持默认） |
| **Plane 设置** | Scale (3, 1, 3)，Material 为默认灰色 |
| **验收** | 点击 Play → Game 视图显示灰色地面和光照 → 无错误 → 停止 Play |

### Task 0.5: 安装并记录 Unity 包

在 Window → Package Manager 中安装以下包（如有已预装的可跳过安装，但必须记录版本）：

| 包名 | 用途 | 安装后版本 |
| --- | --- | --- |
| `com.unity.ai.navigation` | NavMesh 运行时 | 记录：_____ |
| `com.unity.behavior` | Unity Behavior 行为图 | 记录：_____ |
| `com.unity.ml-agents` | 强化学习训练 | 记录：_____ |
| `com.unity.sentis` | ONNX 推理 | 记录：_____ |
| `com.unity.test-framework` | EditMode/PlayMode 测试 | 记录：_____ |

| **操作** | 安装完成后，把实际包名和版本记录到 `docs/planning/package-manifest.md` |
| **验收** | Package Manager 中所有上述包显示为已安装，无版本冲突 |

### Task 0.6: 创建第一个空测试

在 `_Project/Tests/EditMode/` 下创建 `SmokeTest.cs`：

```csharp
using NUnit.Framework;

public class SmokeTest
{
    [Test]
    public void Project_CanRunEditModeTest()
    {
        Assert.IsTrue(true);
    }
}
```

| **操作** | Window → General → Test Runner → EditMode → Run All |
| **验收** | Test Runner 显示 1/1 通过（绿色勾） |

### Task 0.7: 配置 Git LFS

| 项目 | 说明 |
| --- | --- |
| **操作** | `git lfs install`（如未安装，先 `winget install Git.LFS`） |
| **验证** | `git lfs track` 应显示 `.gitattributes` 中的规则已生效 |
| **验收** | 后续添加的 `.onnx` 等文件自动走 LFS 存储 |

### Task 0.8: 首次提交与推送

| 项目 | 说明 |
| --- | --- |
| **操作** | `git add .` → `git commit -m "Milestone 0: Unity 6 工程基础"` → `git push` |
| **前提** | 已完成 GitHub 远程仓库创建（`docs/workflows/github-setup.md`） |
| **注意** | 只提交源码和配置，不要提交 `UnityProject/Library/`、`Temp/` 等（`.gitignore` 已覆盖） |
| **验收** | GitHub 上可见完整目录结构，CI 编译通过 |

### Task 0.9: CI 编译通过

| **验收** | `.github/workflows/unity-ci.yml` 触发的 Action 绿色通过（编译 + 空测试运行） |

---

## M0 完成后的下一步

- 更新 `docs/planning/learning-roadmap.md` 中阶段 0 状态为"已完成"
- 把 `prompts/first-claude-session.md`（如需修改）交给 Claude Code → 进入 Milestone 1
