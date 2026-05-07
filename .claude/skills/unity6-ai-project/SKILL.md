---
name: unity6-ai-project
description: Use when working in the Unity6_AI repository on the Unity 6 AI combat demo, including milestone planning, project structure, Claude Code + DeepSeek handoff, Unity package setup, learning-roadmap updates, and validation instructions.
---

# Unity6 AI Project

Use this skill for repository-level work on the Unity6_AI learning project.

## First Reads

Read only what is needed:

- `CLAUDE.md` for current operating rules.
- `docs/planning/milestone-m0-plan.md` for current M0 tasks.
- `docs/planning/project-brief.md` for final project scope.
- `docs/planning/learning-roadmap.md` for course progress.
- `docs/planning/architecture-decisions.md` for technical decisions.
- `docs/planning/package-manifest.md` when Unity packages are involved.
- `docs/workflows/skills-strategy.md` when changing Claude Code skills, agents, commands, hooks, or plugins.

Do not rewrite `docs/reference/manual.md`; it is the archived source manual.

## Workflow

1. Identify the active milestone.
2. State the smallest useful next step and its acceptance check.
3. Make scoped changes only.
4. Explain how to verify the result in Unity, GitHub, or the shell.
5. Update progress docs only when the user has completed or confirmed the step.

## Project Rules

- Communicate in Chinese; keep code identifiers in English.
- Unity project root is `UnityProject/`.
- Unity C# scripts go under `UnityProject/Assets/_Project/Scripts/`.
- Tests go under `UnityProject/Assets/_Project/Tests/`.
- Do not commit API keys, Unity `Library/`, training outputs, caches, or user local settings.
- Do not enable hooks, MCP servers, or monitors unless the user explicitly asks and the trust boundary is documented.
- For uncertain Unity, ML-Agents, Sentis, Claude Code, or GitHub Actions details, verify against official docs before locking versions or commands.

## Milestone Order

- M0: Unity 6 project foundation.
- M1: FSM, NavMesh, perception, enemy prototype.
- M2: Behavior tree / Unity Behavior and group AI.
- M3: ML-Agents training.
- M4: Sentis / ONNX inference.
- M5: integration, CI, docs, demo delivery.
