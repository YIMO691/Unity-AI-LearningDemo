# GitHub 仓库创建步骤

当前本机已经有 Git，但没有安装 GitHub CLI `gh`。因此远程仓库有两种创建方式。

## 方式 A：安装 GitHub CLI 后一键创建

1. 安装 GitHub CLI：

```powershell
winget install --id GitHub.cli
```

2. 关闭并重新打开终端，登录 GitHub：

```powershell
gh auth login
```

3. 进入仓库目录并创建私有远程仓库：

```powershell
cd F:\Unity6_AI
gh repo create Unity6_AI --private --source . --remote origin --push
```

如果你想公开学习过程，把 `--private` 改成 `--public`。

## 方式 B：网页创建远程仓库

1. 打开 GitHub，新建仓库。
2. 仓库名建议：`Unity6_AI`。
3. Visibility 建议先选 Private。
4. 不要勾选初始化 README、`.gitignore`、License，因为本地已经有这些基础文件。
5. 创建完成后，在本地执行：

```powershell
cd F:\Unity6_AI
git remote add origin https://github.com/<你的用户名>/Unity6_AI.git
git branch -M main
git push -u origin main
```

## 日常分支流程

```powershell
git checkout -b milestone/m1-fsm
# 完成一个可验证小任务
git status
git add .
git commit -m "Implement M1 FSM prototype"
git push -u origin milestone/m1-fsm
```

然后在 GitHub 上打开 Pull Request。PR 模板已经放在 `.github/pull_request_template.md`。

## 参考

- GitHub CLI Windows 安装说明：<https://raw.githubusercontent.com/cli/cli/trunk/docs/install_windows.md>

