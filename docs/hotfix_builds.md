# Patching a released version

How a fix reaches a version that is already cut, without becoming a new version.

Last reviewed: 2026-09-06

For how a release pins its `webtrit_callkeep` version, see
[Release Versioning](release_versioning.md). For the build itself see [Build](build.md).

---

## The shape of a patch

A patch keeps the release's name and raises its build number. `pubspec.yaml` carries two
version fields and only one of them moves:

| Field | Value | Moves on a patch |
|---|---|---|
| `version:` | `0.0.0+0` by convention, never edited | no |
| `app_version:` | the release version, `X.Y.Z+N` | yes, `+N` only |

So `1.16.5+0` becomes `1.16.5+1`. The release is still 1.16.5; the store and the phone version
registry tell the two builds apart by the build number.

---

## The steps

On `release/X.Y.Z`:

1. Cherry-pick the fix from `develop`. Take the commit that is already merged there - a patch is
   never the first place a fix lands, because then it would be missing from the next release.
2. Raise `app_version` to `X.Y.Z+N`.
3. Open a pull request against `release/X.Y.Z` and merge it.
4. **Tag the merged commit `X.Y.Z+N` by hand**, annotated, and push the tag.

Step 4 is the one that is easy to skip and the one that everything downstream needs. See below.

---

## The tag nobody creates

Nothing creates it. `auto-tag-version` runs on pushes to `main`, reads `app_version`, and drops
the build number before looking:

```sh
VERSION_FIELD=$(awk '/^app_version:/{print $2; exit}' pubspec.yaml)
VERSION="${VERSION_FIELD%%+*}"
```

Its own comment says what follows from that: pushes "where the tag already exists, e.g. a hotfix
X.Y.Z+N reusing the same base" are no-ops. A patch therefore never produces a tag on its own, and
a merge into a release branch does not run the workflow at all.

## The reach of an untagged patch

The configurator offers a list of phone refs, and that list is tags and nothing else -
`GithubProxyService` asks GitHub for `path: 'tags'`. Both things a release needs are pointed at a
ref from that list:

- the **build**, including the one testers are given;
- the **scan** that registers what a version can parse, which is what pinning a phone version is.

So a patch commit with no tag of its own cannot be built, cannot be handed to testing, and cannot
be pinned. The fix exists on the branch and reaches nobody.

Tag names are not filtered - every tag is listed - and the sort reads the first `X.Y.Z` it finds
anywhere in the name, so `1.16.5+1` is ordered as a 1.16.5 and sits next to it.

---

## Never move a published tag

Re-pointing `X.Y.Z` at the patch would leave one entry in the picker, which is tempting, and it is
still wrong: the build already shipped under that tag stops being reachable by name, and anyone who
fetched it keeps a different commit under the same name. Tags here are immutable. A patch gets its
own.

---

## Pinning the patch afterwards

Pin the new tag in the configurator, and leave the old registration alone.

A registration is keyed by version **and** build code, so `1.16.5+0` and `1.16.5+1` are two rows
that coexist, and a read without a build code answers the newest. Devices already in the field
report their own build in `X-Phone-Version`, so forgetting the old row would leave them served the
full current shape - which is the opposite of what the registry is for.

`forget` is the repair for a scan pointed at the wrong ref, not a step in a release.

The scan reads `app_version` out of the checkout rather than the tag's name, so the two must
agree: a tag named `1.16.6` on a commit whose `app_version` says `1.16.5+1` registers as
`1.16.5+1`.

The gate on a pin is that the new shape must be additive against what that version already has.
A patch that only fixes rendering adds nothing and passes; one that removes or reshapes a config
field is refused, and naming `force` is a deliberate act, not a retry.

---

## Worked example: 1.16.5+1

The bottom bar drew a brand's colours on the icons and not on the captions.

| Step | What it was |
|---|---|
| Fix on `develop` | `b2280d3b` (#1836) |
| Cherry-picked onto `release/1.16.5` | #1841, no conflicts |
| `app_version` | `1.16.5+0` becomes `1.16.5+1` |
| Merged as | `6bc20694` |
| Tag | `1.16.5+1`, annotated, on `6bc20694` |
| Tag `1.16.5` | left where it was, on `4d282058` |
