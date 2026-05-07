# Contributing

This is a personal Unity 6 AI learning project. Contributions are welcome but please note the following.

## Getting Started

1. Read `CLAUDE.md` and `AGENTS.md` for project context.
2. Read `docs/planning/project-brief.md` for the full milestone plan.
3. Read `docs/planning/architecture-decisions.md` for technical decisions.

## Branch Naming

```text
milestone/m{N}-{slug}
```

Examples: `milestone/m0-setup`, `milestone/m1-fsm`, `milestone/m2-behavior-tree`

## Commit Style

- Use English for commit messages.
- Prefix with milestone tag where helpful: `M0:`, `M1:`, etc.
- Describe WHY, not just WHAT.

## Before Submitting a PR

- [ ] All Unity EditMode tests pass (Window → General → Test Runner → Run All)
- [ ] No Console errors in Unity Editor
- [ ] `docs/status/PROGRESS.md` and `docs/status/TODO.md` updated
- [ ] No API Key, Token, or password in any committed file
- [ ] `.gitignore` and `.gitattributes` rules verified

## Code Conventions

See `.claude/rules/unity-csharp.md` and `.editorconfig` for detailed rules.

- C# scripts go under `UnityProject/Assets/_Project/Scripts/`
- Use `[SerializeField] private` instead of `public` fields
- Expose AI behavior parameters (radius, speed, cooldown) to Inspector
- After writing code, state: which GameObject to attach to, which components are needed, how to verify in Unity

## Code of Conduct

Be respectful. This is a learning project — questions and discussions are welcome.
