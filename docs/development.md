# Development

## Git Hooks

We use [Lefthook](https://github.com/evilmartians/lefthook) to manage Git hooks for this project.

### What Are Git Hooks?

Git hooks are scripts that run automatically at certain points in your Git workflow. They're used in
this project to:

- Enforce [Conventional Commits](https://www.conventionalcommits.org/)
- Check branch naming conventions (e.g., `feature/`, `fix/`)
- Run `flutter analyze` before committing or pushing
- Run unit and widget tests before pushing

### Installation

Install [Lefthook](https://github.com/evilmartians/lefthook):

```bash
brew install lefthook
```

Install Git hooks for this repo:

```bash
lefthook install
```

### Hook Overview

| Hook         | Purpose                                                                                      |
|--------------|----------------------------------------------------------------------------------------------|
| `pre-commit` | Runs `flutter analyze` before committing                                                     |
| `pre-push`   | Runs `flutter analyze`, `flutter test`, and checks branch name                               |
| `commit-msg` | Validates commit messages using [Conventional Commits](https://www.conventionalcommits.org/) |

The hook logic is defined in `.lefthook.yml` and shell scripts under `tool/scripts/`.

### Skipping Hooks

To bypass hooks temporarily (not recommended):

```bash
git commit --no-verify
```

### Manual Execution

To run hooks manually:

```bash
lefthook run pre-commit
lefthook run commit-msg
lefthook run pre-push
```

Or run specific scripts directly:

```bash
bash tool/scripts/branch-name-check.sh
bash tool/scripts/commit-msg-check.sh
```

### Example Output

```
╭───────────────────────────────────────╮
│ 🥊 lefthook v1.12.2  hook: commit-msg │
╰───────────────────────────────────────╯
✅ Commit message OK.
```

## Claude Code Settings

We use [Claude Code](https://docs.anthropic.com/en/docs/claude-code) settings to enforce consistent AI-assisted development rules across the team.

### Settings Levels

Claude Code supports multiple settings levels with different scopes:

| Level | File | Scope | Committed to repo |
|-------|------|-------|--------------------|
| **Team** | `.claude/settings.json` | Shared across all team members | Yes |
| **Local** | `.claude/settings.local.json` | Personal per-developer overrides | No (gitignored) |
| **User** | `~/.claude/settings.json` | Global per-machine settings | N/A |

Settings are merged at runtime: **User < Team < Local** (local overrides team, team overrides user).

### Team Settings (`.claude/settings.json`)

The team settings file defines shared `deny` rules that prevent Claude Code from accessing sensitive files:

- **Keystores** — `.jks`, `.keystore`, `.p12` files and `webtrit_phone_keystores/` directory
- **Signing keys** — `.pem`, `.key`, `.p8` files
- **Environment files** — `.env*` files

These rules ensure that no team member accidentally exposes secrets or signing credentials through AI-assisted workflows.

### Local Settings (`.claude/settings.local.json`)

This file is gitignored and used for personal `allow` rules (e.g., auto-approving `flutter test`, `dart format`). Each developer can configure their own convenience permissions without affecting the team.