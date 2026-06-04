# Pinning the Callkeep Version

This document describes how WebTrit Phone pins its
[`webtrit_callkeep`](https://github.com/WebTrit/webtrit_callkeep) dependency, so that
`git checkout release/A.B.C` plus `flutter pub get` always reproduces the same build.

> Scope: the phone side only — how a phone branch *consumes* a callkeep release. How callkeep cuts
> and tags its own releases is documented in the callkeep repository; here we simply rely on the
> fact that callkeep publishes immutable version tags (`X.Y.Z`).
>
> For the Flutter SDK version see [build.md](build.md).

---

## Why this exists

A given phone release is compatible with exactly **one** callkeep version. Historically that
mapping lived only in people's heads, and CI let the operator pick the callkeep branch by hand at
build time — so a release could silently be built against the wrong callkeep. This removes the
manual choice: the callkeep version is declared in `pubspec.yaml`, and the build trusts it.

---

## How the dependency is declared

### Release branches — pinned by tag

On every `release/*` branch the umbrella dependency is pinned to a callkeep release tag:

```yaml
dependencies:
  webtrit_callkeep:
    git:
      url: https://github.com/WebTrit/webtrit_callkeep.git
      ref: X.Y.Z            # a published callkeep release tag
      path: webtrit_callkeep
```

`flutter pub get` resolves the tag to an exact commit and records it in `pubspec.lock`, so the
build is fully deterministic. callkeep is a public repository, so this needs no extra credentials.

### develop — local path

On `develop` the dependency stays a relative path, because callkeep is usually co-developed
alongside the phone:

```yaml
dependencies:
  webtrit_callkeep:
    # develop tracks the local working copy of callkeep for co-development.
    # On release branches this is pinned to a tag (see docs/release_versioning.md).
    # Never back-merge a git ref onto develop — keep this a path here.
    path: ../webtrit_callkeep/webtrit_callkeep
```

**Back-merge rule:** on `develop` this dependency is **always** `path:`. When merging a release
branch back into develop the `webtrit_callkeep` line will conflict (`git:` ref vs `path:`) —
always resolve in favor of develop's `path:`. A CI guard fails the build if `develop` ever ends up
with a non-path callkeep dependency, so a bad merge is caught automatically.

---

## Cutting a phone release

On the phone `release/A.B.C` branch:

1. Set the phone version (`A.B.C`).
2. Pin callkeep in `pubspec.yaml` to the chosen callkeep release tag: `ref: X.Y.Z`.
3. `flutter pub get` (the lock records the exact commit).
4. Commit `pubspec.yaml` **and** `pubspec.lock`.

`develop` is left untouched (still `path:`).

---

## CI / build behaviour

The `webtrit_phone_builder` pipeline trusts `pubspec.yaml`:

- **Release builds** — `pubspec.yaml` carries a `git:` ref, so `flutter pub get` fetches the pinned
  callkeep commit. There is no manual callkeep branch selection.
- **develop builds** — `pubspec.yaml` carries `path:`, so the builder checks out callkeep at its
  default integration branch (`main`) into the sibling directory the path resolves to.

---

## Enforcement

So this is reliable by construction, not by memory:

| Check | Where | Fails when |
|-------|-------|------------|
| callkeep is `path:` on develop | phone CI, on `develop` PRs | a git ref was merged onto develop (e.g. a bad back-merge) |
| callkeep is pinned on release | phone CI, on `release/*` (optional) | a release branch still uses `path:` instead of a `git:` ref |

---

## Quick reference

| Branch type | callkeep in `pubspec.yaml` | Resolves to |
|-------------|----------------------------|-------------|
| `develop`   | `path: ../webtrit_callkeep/webtrit_callkeep` | local working copy / callkeep `main` in CI |
| `release/*` | `git: { ref: X.Y.Z }` | the callkeep release tag, pinned in `pubspec.lock` |
