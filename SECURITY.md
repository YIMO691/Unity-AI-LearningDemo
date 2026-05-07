# Security Policy

## Supported Versions

This is a personal learning project. Only the latest commit on `main` is considered in scope for security fixes.

| Version | Supported          |
| ------- | ------------------ |
| main    | :white_check_mark: |
| others  | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability in this project:

1. **Do NOT open a public Issue.**
2. Email the project maintainer directly with details.
3. Allow up to 7 days for initial response.

## Scope

- `.env` file exposure
- API Key / Token leakage in commits, logs, or documentation
- Hardcoded credentials in Unity scripts or CI workflows
- Insecure dependency versions in `Packages/manifest.json`

## Out of Scope

- Unity Editor security vulnerabilities (report to Unity Technologies)
- Third-party package vulnerabilities (report to package maintainers)
- Phishing or social engineering attacks
