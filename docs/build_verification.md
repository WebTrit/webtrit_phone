# Verifying a Change Compiles

Which check to run for a given change, what each one costs, and the flags a build fails without.
Written to stop the common waste pattern: launching a multi-minute build, having it fail on a
known-mandatory flag, and launching it again.

Last reviewed: 2026-08-18

For build/run commands, optional features, signing and SDK pinning see [Build & Development](build.md).
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

## Optional Android features

Android has no build flavors, so an APK/AAB build needs no `--flavor` and there is only one
variant per build type. Two features are decided at build time because their permission and
components must be absent when they are off - deep links and the SMS call trigger. Both follow
`dart_define.json`:

| Dart define (`dart_define.json`)     | Value           | Effect                                       |
|--------------------------------------|-----------------|----------------------------------------------|
| `WEBTRIT_APP_LINK_DOMAIN`            | non-empty       | deep-link intent filter is merged in         |
|                                      | empty/missing   | no intent filter                             |
| `WEBTRIT_CALL_TRIGGER_MECHANISM_SMS` | `"true"`        | `RECEIVE_SMS` and the receiver are merged in |
|                                      | anything else   | neither is declared                          |

Every build prints what it resolved (`Deep links: enabled, SMS call trigger: disabled`), so a
build log is enough to tell which features the artifact carries.

Checking the result does not need a full build - the merged manifest is one Gradle task. It wants
the dart-defines the way Flutter passes them, a comma-separated list of base64-encoded `KEY=VALUE`
pairs, and it does NOT fail when they are missing: it succeeds with both features off, which looks
the same as a fragment that never merged.

```bash
cd android
defines="$(printf '%s' 'WEBTRIT_APP_LINK_DOMAIN=app.webtrit.com' | base64 | tr -d '\n'),$(printf '%s' 'WEBTRIT_CALL_TRIGGER_MECHANISM_SMS=true' | base64 | tr -d '\n')"
./gradlew :app:processReleaseManifest -Pdart-defines="$defines"
cat ../build/app/intermediates/merged_manifests/release/processReleaseManifest/AndroidManifest.xml
```

Background: [optional_features.md](optional_features.md).

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
`webtrit_appearance_theme`), so a break here breaks its web build too - with the error pointing
into `lib/` of this repo. Its `screenshots` package - the phone's screens, mocked, that its preview
draws - used to live here and now lives there. Its own run/build guide, including the same
`--no-tree-shake-icons` requirement, lives in that repo under `docs/run-and-build.md`.
