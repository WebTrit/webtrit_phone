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