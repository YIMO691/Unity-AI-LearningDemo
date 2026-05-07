# Unity 6 AI — Combat Demo

[![Unity](https://img.shields.io/badge/Unity-6000.4.5f1-000000?logo=unity)](https://unity.com/releases/editor/whats-new/6000.4.5)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![AI](https://img.shields.io/badge/AI-FSM%20|%20Behavior%20|%20ML--Agents%20|%20Sentis-ff6a00)](docs/planning/learning-roadmap.md)
[![Status](https://img.shields.io/badge/status-M2%20complete%20%7C%20M3%20ready-brightgreen)](docs/status/PROGRESS.md)

[**中文版本**](README.zh-CN.md)

A step-by-step learning repository for building a **3D AI combat demo** in Unity 6 — progressing from traditional game AI (FSM, NavMesh, perception) through to modern ML inference (ML-Agents, Sentis/ONNX).

---

## Table of Contents

- [Overview](#overview)
- [Current Status](#current-status)
- [Milestones](#milestones)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Remote Development](#remote-development)
- [Engineering Foundations](#engineering-foundations)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

This repository builds a complete AI combat demo in phases — one player versus multiple enemies. Each phase introduces a new AI technique, progressing from simple finite state machines to trained neural network inference at runtime.

Every milestone produces runnable, verifiable, and documented output. The project is AI-assisted via Claude Code + DeepSeek and remotely controllable via Feishu + OpenClaw.

### AI Techniques Covered

| Phase | Technology | What You'll See |
| --- | --- | --- |
| **M1** Traditional AI | FSM, NavMesh, Perception | Enemies patrol, detect, chase, and attack |
| **M2** Behavior & Swarm | Unity Behavior, Group Behavior | Coordinated squad tactics, dynamic decision trees |
| **M3** ML-Agents | PPO, TensorBoard | Self-trained agents with observable reward curves |
| **M4** Sentis Inference | ONNX, Burst CPU | Real-time neural network inference in-game |
| **M5** Integration & Delivery | CI, Demo Video | Reproducible full demo from scratch |

> Detailed roadmap: [docs/planning/learning-roadmap.md](docs/planning/learning-roadmap.md)

---

## Current Status

M0, M1, and M2 are **complete**. M3 (ML-Agents Reinforcement Learning) is ready to begin.

### M0 — Project Foundation ✅
| Item | Status |
| --- | --- |
| Unity 6 URP Project | ✅ |
| Package Installation | ✅ 5 core packages |
| Base Scene + Smoke Test | ✅ |
| Git LFS + CI + Docs | ✅ |

### M1 — Traditional AI (FSM) ✅
| Feature | Status |
| --- | --- |
| Patrol / Chase / Attack / Death | ✅ |
| Raycast occlusion | ✅ |
| Scene | `Demo1_FSM.unity` |

### M2 — Behavior Tree + Swarm ✅
| Feature | Status |
| --- | --- |
| C# Behavior Tree (Selector/Sequence) | ✅ |
| Swarm separation (Boids 3 rules) | ✅ |
| Unity Behavior evaluated → C# BT chosen | ✅ |
| Scenes | `Demo2_Behavior.unity` / `Demo2_Swarm.unity` |

> Full status: [PROGRESS.md](docs/status/PROGRESS.md) | [TODO.md](docs/status/TODO.md)

---

## Milestones

| Milestone | Status | Deliverables |
| --- | --- | --- |
| **M0** Project Foundation | ✅ Complete | Unity 6 skeleton, packages, CI, docs system |
| **M1** Traditional Game AI | ✅ Complete | FSM + NavMesh patrol/chase/attack, Demo1_FSM scene |
| **M2** Behavior Tree & Swarm | ✅ Complete | C# BT + Boids separation, Demo2 scenes |
| **M3** ML-Agents Training | 🟡 In Progress | PPO training, TensorBoard, ONNX model |
| **M4** Sentis Inference | ⏳ Pending | ONNX import, Burst CPU runtime inference |
| **M5** Final Delivery | ⏳ Pending | Full demo, CI green, video walkthrough |

## Next Steps / 下一步

### M3 — ML-Agents Reinforcement Learning

Build a training environment where an agent learns combat behavior through PPO (Proximal Policy Optimization).

| Task | Description |
| --- | --- |
| Python Setup | Install `mlagents` Python package for training |
| Training Scene | Create `TrainEnv.unity` with Agent + environment |
| Custom Agent | Define observations (player position, distance), actions (move, attack), rewards (hit=+1, miss=-0.1) |
| PPO Training | Write YAML config, run `mlagents-learn`, monitor TensorBoard |
| ONNX Export | Export trained model, verify inference in Unity |

> Prerequisite: Python 3.10+ with `mlagents` package installed.

> Detailed plan: [M0 Task Plan](docs/planning/milestone-m0-plan.md) | [Architecture Decisions](docs/planning/architecture-decisions.md)

---

## Quick Start

### Prerequisites

| Tool | Version | Purpose |
| --- | --- | --- |
| Unity Hub + Unity 6 | 6000.4.5f1+ | Editor & runtime |
| Git | 2.40+ | Version control |
| Git LFS | 3.x | Large binary storage |
| GitHub CLI (`gh`) | 2.x | PR, Issue, CI management |
| PowerShell | 5.1+ | Automation scripts |

### Clone & Setup

```powershell
git clone https://github.com/YIMO691/Unity-AI-LearningDemo.git
cd Unity_AI
git lfs install
```

### Open in Unity

1. Launch **Unity Hub**
2. Click **Open** → select `Unity_AI/UnityProject/`
3. Wait for package restoration and script compilation
4. Open `Assets/_Project/Scenes/Main.unity`
5. Press **Play** — should see gray ground with lighting, no Console errors

### Run Tests

```
Window → General → Test Runner → EditMode → Run All
```

Should show `SmokeTest.Project_CanRunEditModeTest` ✅ 1/1 passing.

### Project Status Check

```powershell
powershell -ExecutionPolicy Bypass -File ".\tools\mobile-status.ps1"
```

### AI Assistant Setup

```powershell
$env:DEEPSEEK_API_KEY="sk-your-key"
.\scripts\start-claude-deepseek.cmd
```

> ⚠️ Never commit API keys. See `.env.example` for configuration reference.

---

## Project Structure

```text
F:\Unity6_AI
├─ .claude/                  # Claude Code skills, rules, commands
├─ .github/                  # CI workflows, PR/Issue templates, CODEOWNERS
├─ .openclaw/                # OpenClaw Gateway state & agent config
├─ docs/                     # All project documentation
│  ├─ planning/              # Plans, milestones, ADR, package manifest
│  ├─ status/                # PROGRESS.md, TODO.md, AI_DEV_LOG.md
│  ├─ reference/             # Manuals, conventions, skills manifest
│  ├─ workflows/             # Setup guides (CI, GitHub, Feishu, Claude Code)
│  ├─ environment/           # Environment reports
│  └─ templates/             # Reusable file templates
├─ LearningBlog/             # Structured learning notes
├─ Logs/                     # Runtime logs (not committed)
├─ prompts/                  # AI session starter prompts
├─ scripts/                  # Claude Code + DeepSeek startup scripts
├─ tools/                    # Automation PowerShell scripts
│  ├─ claude-code-relay.ps1  # Relay: Feishu → Claude Code
│  ├─ mobile-status.ps1      # Phone-friendly project status
│  └─ cc-*.ps1              # /cc, /cc-run, /cc-status, /cc-session commands
├─ UnityProject/             # Unity 6 project root
│  └─ Assets/_Project/       # Project source code & assets
│     ├─ Art/                # Materials, models, textures
│     ├─ Prefabs/            # Reusable prefabs
│     ├─ Scenes/             # Main.unity and future scenes
│     ├─ Scripts/            # C# scripts (Core/AI/Player/Training)
│     └─ Tests/              # EditMode + PlayMode tests
├─ LICENSE                   # MIT license
├─ CLAUDE.md                 # Claude Code project instructions
├─ AGENTS.md                 # AI agent handoff notes
├─ CONTRIBUTING.md           # Contribution guide
├─ SECURITY.md               # Security policy
└─ README.md                 # This file
```

---

## Remote Development

Control this project from your phone via Feishu + OpenClaw. Check progress, dispatch coding tasks, and monitor CI — all through chat. The relay architecture enforces safety boundaries: read-only commands never modify files, write commands require explicit authorization.

```text
Feishu Mobile → OpenClaw Gateway → unity6ai Agent → Claude Code Relay → Claude Code + DeepSeek → Result → Feishu
```

| Command | Mode | Function |
| --- | --- | --- |
| `/cc` | Read-only | Project status, TODO check, log analysis |
| `/cc-run <task>` | Edit (restricted) | Execute task via relay with safety rules |
| `/cc-run-big <task>` | Edit (unrestricted) | Direct Claude Code execution for large tasks |
| `/cc-status` | Read-only | Current Claude Code task state |
| `/cc-last` | Read-only | Last execution summary |
| `/progress` | Read-only | Mobile-optimized project progress |

> Setup guide: [Feishu + OpenClaw Deployment](docs/workflows/feishu-openclaw-deployment.md)
> Relay guide: [Claude Code Relay](docs/workflows/claude-code-relay.md)

---

## Engineering Foundations

| Foundation | File | Purpose |
| --- | --- | --- |
| **Architecture Decisions** | [ADR](docs/planning/architecture-decisions.md) | 8 technical decisions with rationale |
| **File Organization** | [Convention](docs/reference/file-organization-convention.md) | Where every file type belongs |
| **Skills Manifest** | [Manifest](docs/reference/skills-manifest.md) | 20 active skills with decision flow |
| **Coding Rules** | [C# Rules](.claude/rules/unity-csharp.md) | Unity C# conventions, Inspector, validation |
| **Git LFS** | [.gitattributes](.gitattributes) | Binary file tracking (ONNX, FBX, textures, audio) |
| **CI Pipeline** | [unity-ci.yml](.github/workflows/unity-ci.yml) | GitHub Actions: compile + EditMode tests |
| **Package Versions** | [Manifest](docs/planning/package-manifest.md) | Locked versions for reproducibility |
| **Security Policy** | [SECURITY.md](SECURITY.md) | Vulnerability reporting & scope |

---

## Documentation

### Entry Points

| Document | Purpose |
| --- | --- |
| [CLAUDE.md](CLAUDE.md) | Claude Code project instructions |
| [AGENTS.md](AGENTS.md) | AI agent handoff notes |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guide & PR checklist |
| [SECURITY.md](SECURITY.md) | Security policy & reporting |
| [LICENSE](LICENSE) | MIT license |

### Planning

| Document | Purpose |
| --- | --- |
| [project-brief.md](docs/planning/project-brief.md) | Project requirements & milestone summary |
| [learning-roadmap.md](docs/planning/learning-roadmap.md) | Phased learning path |
| [milestone-m0-plan.md](docs/planning/milestone-m0-plan.md) | M0 detailed task breakdown |
| [architecture-decisions.md](docs/planning/architecture-decisions.md) | Architecture Decision Records (8 ADRs) |
| [package-manifest.md](docs/planning/package-manifest.md) | Locked Unity package versions |

### Status Tracking

| Document | Purpose |
| --- | --- |
| [PROGRESS.md](docs/status/PROGRESS.md) | Current progress & completed items |
| [TODO.md](docs/status/TODO.md) | Task backlog & acceptance criteria |
| [AI_DEV_LOG.md](docs/status/AI_DEV_LOG.md) | AI collaboration log |

### Reference

| Document | Purpose |
| --- | --- |
| [manual.md](docs/reference/manual.md) | Original learning manual (read-only archive) |
| [file-organization-convention.md](docs/reference/file-organization-convention.md) | File placement rules & root whitelist |
| [skills-manifest.md](docs/reference/skills-manifest.md) | 20 skills inventory with decision flow |

### Workflows

| Document | Purpose |
| --- | --- |
| [claude-deepseek-workflow.md](docs/workflows/claude-deepseek-workflow.md) | Claude Code + DeepSeek setup |
| [github-setup.md](docs/workflows/github-setup.md) | GitHub repository creation |
| [feishu-openclaw-deployment.md](docs/workflows/feishu-openclaw-deployment.md) | Remote development setup |
| [claude-code-relay.md](docs/workflows/claude-code-relay.md) | Claude Code relay script guide |
| [skills-strategy.md](docs/workflows/skills-strategy.md) | Skills/agents/hooks adoption strategy |
| [docs/README.md](docs/README.md) | Documentation index & audit |

### Learning Blog

| Document | Topic |
| --- | --- |
| [LearningBlog/README.md](LearningBlog/README.md) | Blog index by date & tag |
| [Toolchain Setup](LearningBlog/2026-05-06-toolchain-ssh-lfs-gh.md) | SSH Key, Git LFS, GitHub CLI deep-dive |
| [Remote Dev Chain](LearningBlog/2026-05-06-unity6-ai-openclaw-feishu-claude-code-relay.md) | OpenClaw + Feishu + Claude Code relay |

---

## Contributing

This is a personal learning project. Suggestions and discussions are welcome via GitHub Issues. Code contributions should follow the conventions in [CONTRIBUTING.md](CONTRIBUTING.md), [CLAUDE.md](CLAUDE.md), and [.claude/rules/unity-csharp.md](.claude/rules/unity-csharp.md).

### Branch Naming

```
milestone/m{N}-{slug}
# Examples: milestone/m1-fsm, milestone/m2-behavior
```

### Code Conventions

- Communication in Chinese, identifiers in English
- `[SerializeField] private` over `public` fields
- AI parameters exposed in Inspector
- After writing code, always explain: which GameObject, which components, how to verify
- Never commit: API keys, Unity Library, Temp, training artifacts, user settings

---

## License

MIT — see [LICENSE](LICENSE) for details.

---

<p align="center">
  <sub>Built with Unity 6 | AI-assisted by Claude Code + DeepSeek | Remote-controlled via Feishu + OpenClaw</sub>
</p>
