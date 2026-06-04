# Release Versioning — Phone ↔ Callkeep

This document defines how a WebTrit Phone release is pinned to an exact
[`webtrit_callkeep`](https://github.com/WebTrit/webtrit_callkeep) version, so that
`git checkout release/A.B.C` plus `flutter pub get` always reproduces the same build.

> Scope: this is about **which callkeep a phone release is built against**. For the Flutter SDK
> version see [build.md](build.md).

---

## Why this exists

A given phone release is compatible with exactly **one** callkeep version. Historically that
mapping lived only in people's heads (and a ticket comment), and the CI let the operator pick the
callkeep branch by hand at build time — so a release could silently be built against the wrong
callkeep. This scheme removes the manual choice: **the phone repo is the single source of truth**,
and the build trusts it.

---

## The invariant

```
phone pubspec.yaml  ref:  X.Y.Z
        │  (git tag)
        ▼
callkeep git tag    X.Y.Z   ==   callkeep pubspec.yaml  version: X.Y.Z+N
```

One number everywhere:

- The phone declares the callkeep dependency by **git tag** (`ref: X.Y.Z`).
- The callkeep git tag `X.Y.Z` points to the commit whose `version:` field is `X.Y.Z+N`
  (the tag name equals the `X.Y.Z` part of the version, ignoring the `+N` build metadata).

CI enforces both halves (see [Enforcement](#enforcement)).

---

## How the callkeep dependency is declared

### Release branches — pinned by tag

On every `release/*` branch, the umbrella dependency is pinned to a git tag:

```yaml
dependencies:
  webtrit_callkeep:
    git:
      url: https://github.com/WebTrit/webtrit_callkeep.git
      ref: X.Y.Z            # the callkeep release tag
      path: webtrit_callkeep
```

`flutter pub get` resolves the tag to an exact commit and records it in `pubspec.lock`, so the
build is fully deterministic.

### develop — local path

On `develop` the dependency stays a relative path, because callkeep is usually co-developed
alongside the phone:

```yaml
dependencies:
  webtrit_callkeep:
    # develop tracks the local working copy of callkeep for co-development.
    # On release branches this is pinned to a git tag (see docs/release_versioning.md).
    # Never back-merge a git ref onto develop — keep this a path here.
    path: ../webtrit_callkeep/webtrit_callkeep
```

**Back-merge rule:** on `develop` this dependency is **always** `path:`. When merging a release
branch back into develop the `webtrit_callkeep` line will conflict (`git:` ref vs `path:`) —
always resolve in favor of develop's `path:`. A CI guard fails the build if `develop` ever ends up
with a non-path callkeep dependency, so a bad merge is caught automatically.

---

## Release procedure

### 1. Cut the callkeep release

On the callkeep `release/X.Y.Z` branch:

1. Bump `version: X.Y.Z+N` in the umbrella package **and** all sub-packages
   (`webtrit_callkeep_android`, `_ios`, `_platform_interface`, …) — this is the version-bump commit.
2. Tag **that** commit (not an earlier one):
   ```bash
   git tag -a X.Y.Z -m "release X.Y.Z"
   git push origin X.Y.Z
   ```
3. CI verifies the tag (version == tag); a mismatch fails the push/check.

> Common past mistake: tagging **before** the version-bump commit, so the tag pointed at a commit
> whose `version:` field was stale. The tag must sit on the commit where `version:` already reads
> `X.Y.Z+N`.

### 2. Cut the phone release

On the phone `release/A.B.C` branch:

1. Set the phone version (`A.B.C`).
2. Pin callkeep in `pubspec.yaml` to the callkeep tag: `ref: X.Y.Z`.
3. `flutter pub get` (lock records the exact commit).
4. Commit `pubspec.yaml` **and** `pubspec.lock`.

`develop` is left untouched (still `path:`).

---

## CI / build behaviour

The `webtrit_phone_builder` pipeline trusts `pubspec.yaml`:

- **Release builds** — `pubspec.yaml` carries a `git:` ref, so `flutter pub get` fetches the pinned
  callkeep commit. There is no manual callkeep branch selection.
- **develop builds** — `pubspec.yaml` carries `path:`, so the builder checks out callkeep at its
  default integration branch (`main`) into the sibling directory the path resolves to.

(callkeep is a public repository, so the git dependency needs no extra credentials in CI.)

---

## Enforcement

So this is reliable by construction, not by memory:

| Check | Where | Fails when |
|-------|-------|------------|
| `version == tag` | callkeep CI, on tag push | the tag points at a commit whose `version:` doesn't match the tag |
| callkeep is `path:` on develop | phone CI, on `develop` PRs | a git ref was merged onto develop (e.g. a bad back-merge) |
| callkeep is pinned on release | phone CI, on `release/*` (optional) | a release branch still uses `path:` instead of a `git:` ref |

---

## Quick reference

| Branch type | callkeep in `pubspec.yaml` | Source of the version |
|-------------|----------------------------|-----------------------|
| `develop`   | `path: ../webtrit_callkeep/webtrit_callkeep` | callkeep `main` (integration) |
| `release/*` | `git: { ref: X.Y.Z }` | the callkeep release tag, pinned in `pubspec.lock` |
