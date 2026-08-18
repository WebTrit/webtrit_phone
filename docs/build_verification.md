# Verifying a Change Compiles

Which check to run for a given change, what each one costs, and the flags a build fails without.
Written to stop the common waste pattern: launching a multi-minute build, having it fail on a
known-mandatory flag, and launching it again.

Last reviewed: 2026-08-18

For build/run commands, flavors, signing and SDK pinning see [Build & Development](build.md).
For what works on web and the web-specific dart-defines see [Flutter web support](web.md).

---

## Cost-ordered checks

Run in this order, stop at the first failure. Only the last step costs minutes.

| Step | Command                                                          | Cost         | Catches                                                            |
|------|------------------------------------------------------------------|--------------|--------------------------------------------------------------------|
| 1    | `dart format <changed files>`                                    | seconds      | Formatting (lefthook `pre-commit` enforces it)                     |
| 2    | `flutter analyze <changed dirs>` or `melos run analyze`          | seconds/min  | Type and API errors, lint, dead code                               |
| 3    | `flutter test <changed test files>` / `melos run test`           | seconds/min  | Behavior regressions (lefthook `pre-push` runs analyze + test)     |
| 4    | `melos run build:apk` / `flutter build web ...`                  | minutes      | Release-only failures: asset pipeline, icon tree-shaker, JS/AOT compile |

Steps 1-3 cover the vast majority of changes, including reviews. Step 4 earns its cost only when
the change touches assets, icons, entrypoint/bootstrap, dart-defines, native config, conditional
imports, or a platform the analyzer does not exercise (web).

`patrol_test/**` is excluded from analysis, so a green `analyze` says nothing about it - grep it
after renaming anything in `lib/app/keys.dart`.

## Mandatory flags

Every build of this project needs both of these; there is no build configuration where they are
optional:

```bash
--dart-define-from-file=dart_define.json
--no-tree-shake-icons
```

`--no-tree-shake-icons` is required because `String.toIconData()`
(`lib/extensions/string.dart`) constructs `IconData` from a hex string at runtime. The Flutter
icon tree-shaker only accepts const invocations and aborts the build:

```
Target web_release_bundle failed: Error: Avoid non-constant invocations of IconData
or try to build again with --no-tree-shake-icons.
```

What makes this expensive:

- Tree-shaking runs in **release** mode only. `flutter run` never hits it, so nothing warns you
  during development.
- `flutter build web` (and `build apk` / `appbundle` / `ios`) defaults to release, so the flag is
  needed even when you never type `--release`.
- The check runs in the asset-bundling step, **after** the whole Dart compile. Measured:
  256 s of compile before the error surfaced. A forgotten flag costs a full build cycle, not a
  fast failure.

The `melos run build:*` and `fastlane:*` scripts already pass both flags (`pubspec.yaml`,
`tool/scripts/browserstack_upload.sh`). A hand-written `flutter build ...` command is the only
place they go missing - prefer the melos script.

Android builds need one more flag on top of these - see the next section.

## Android builds and flavors

Android declares two flavor dimensions (`deeplinks` x `smsReceiver`,
`android/app/build.gradle`), so every `flutter build apk` / `appbundle` needs a combined
`--flavor` - one value per dimension, concatenated:

| Dart define (`dart_define.json`)     | Value           | Flavor part           |
|--------------------------------------|-----------------|-----------------------|
| `WEBTRIT_APP_LINK_DOMAIN`            | non-empty       | `deeplinks`           |
|                                      | empty/missing   | `deeplinksDisabled`   |
| `WEBTRIT_CALL_TRIGGER_MECHANISM_SMS` | `"true"`        | `smsReceiver`         |
|                                      | anything else   | `smsReceiverDisabled` |

`melos run build:apk` / `build:appbundle` resolve the flavor automatically from
`dart_define.json` (`tool/scripts/android_flavor.sh`, same rule as `makefile.shared`) - prefer
them. A hand-typed command must pass the flag itself:

```bash
flutter build apk --debug --flavor deeplinkssmsReceiverDisabled \
  --dart-define-from-file=dart_define.json --no-tree-shake-icons
```

What a missing `--flavor` costs: Gradle assembles ALL four flavor combinations (measured 569 s
for a debug build) and the Flutter tool then fails with the misleading

```
Gradle build failed to produce an .apk file. It's likely that this file was generated
under .../build, but the tool couldn't find it.
```

The build actually succeeded - all four APKs are in `build/app/outputs/flutter-apk/` under
flavor-suffixed names (e.g. `app-deeplinkssmsreceiver-debug.apk`). Take the one you need from
there instead of re-running the build.

The "flavor is selected automatically" note in the `WEBTRIT_APP_LINK_DOMAIN` dart-define
description refers to the `makefile.shared` build path (Makefile/fastlane), not to a plain
`flutter build`. Flavor background: [flavors.md](flavors.md).

## Web builds

There is no melos script for web yet, so the full command has to be typed:

```bash
# compile verification (release, defaults from dart_define.json)
flutter build web --dart-define-from-file=dart_define.json --no-tree-shake-icons

# dev run - debug, no icon tree-shaking, no flag needed
flutter run -d chrome --dart-define-from-file=dart_define.json
```

Measured cost of the release web build on an Apple silicon laptop: 381 s of Dart-to-JS compile
(over six minutes wall clock). Treat it as the last resort, not a smoke test.

For a build that actually talks to a backend, `WEBTRIT_APP_WEB_BUNDLE_ID` must be a bundle_id
registered server-side for the `web` app type - see [web.md](web.md). Compile verification does
not need it.

## Driving long builds from a terminal

- Redirect to a log file and grep it; do not pipe to `tail`. The tail of a failed build is a
  `flutter_tools` Dart stack trace and the actual cause is above it:

  ```bash
  flutter build web --dart-define-from-file=dart_define.json --no-tree-shake-icons > /tmp/webbuild.log 2>&1
  grep -nE '^(Error|Target .* failed)|\.dart:[0-9]+:' /tmp/webbuild.log | head -40
  ```

- Never re-run a failed build to see the error again - it is in the log.
- `timeout` does not exist on macOS. Use `gtimeout` (`brew install coreutils`) or run the build in
  the background and poll the log. Wrapping the command in `timeout` fails immediately with
  `command not found` and buys nothing.
- Get every mandatory flag right before the first attempt. Each retry is minutes.

## Related repositories

`webtrit_phone_configurator` compiles this repo as a path dependency (`webtrit_phone`,
`screenshots`, `webtrit_appearance_theme`), so a break here breaks its web build too - with the
error pointing into `lib/` of this repo. Its own run/build guide, including the same
`--no-tree-shake-icons` requirement, lives in that repo under `docs/run-and-build.md`.
