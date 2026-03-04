# Contributing to WebTrit Phone

## Branch Naming

Branches must follow the pattern `<type>/<description>`, where `<description>` uses kebab-case.

**Accepted prefixes:**

| Prefix                | When to use                               |
|-----------------------|-------------------------------------------|
| `feature/` or `feat/` | New feature or enhancement                |
| `fix/`                | Bug fix                                   |
| `refactor/`           | Code refactoring without behaviour change |
| `chore/`              | Maintenance, dependency updates, tooling  |
| `docs/`               | Documentation only                        |
| `style/`              | Code style / formatting changes           |
| `build/`              | Build system or CI changes                |
| `release/`            | Release preparation                       |

> Both `feature/` and `feat/` are accepted as equivalent aliases for feature branches.

Examples:

```
feature/add-login-form
feat/add-login-form
fix/null-pointer-crash
release/1.2.0
```

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>[(scope)]: <lowercase description>
```

Accepted types: `feat`, `fix`, `chore`, `refactor`, `test`, `docs`, `style`, `ci`, `perf`, `build`,
`revert`.

- Description must start with a **lowercase** letter.
- No Cyrillic characters anywhere in commit messages.

Examples:

```
feat: add biometric login
fix(api): handle null response from signaling
chore: upgrade flutter to 3.32.4
```

## Git Hooks

Hooks are managed with [Lefthook](https://github.com/evilmartians/lefthook).

```bash
brew install lefthook
lefthook install
```

Hooks run automatically:

- **pre-commit** — `dart format` on staged Dart files (generated files excluded)
- **commit-msg** — validates commit message format
- **pre-push** — validates branch name, runs `flutter analyze` and `flutter test`
