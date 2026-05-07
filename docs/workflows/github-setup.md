# GitHub 仓库设置

当前项目远程仓库：

```text
https://github.com/YIMO691/Unity-AI-LearningDemo
```

本地 `origin` 已设置为上面的仓库地址。不要在未检查 `.gitignore` 和密钥前执行 `git push`。

## 验证 remote

```powershell
cd F:\Unity6_AI
git remote -v
```

期望看到：

```text
origin  https://github.com/YIMO691/Unity-AI-LearningDemo (fetch)
origin  https://github.com/YIMO691/Unity-AI-LearningDemo (push)
```

## 如果需要重新设置 remote

```powershell
git remote set-url origin https://github.com/YIMO691/Unity-AI-LearningDemo
```

## 如果要用 GitHub CLI

当前本机如果没有安装 GitHub CLI `gh`，可以按下面安装：

1. 安装 GitHub CLI：

```powershell
winget install --id GitHub.cli
```

2. 关闭并重新打开终端，登录 GitHub：

```powershell
gh auth login
```

3. 登录 GitHub：

```powershell
gh auth login
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
