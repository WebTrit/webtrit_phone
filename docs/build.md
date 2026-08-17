# Build & Development Process Overview

How to build, run, sign, and ship the WebTrit Phone project.

Last reviewed: 2026-08-11

It includes melos script usage, flavor configuration, signed release builds and store uploads via
fastlane, Flutter SDK version management, and tips for local development.

For all available melos scripts, see [Melos Commands](make_file.md).
For how a release pins its `webtrit_callkeep` version, see [Release Versioning](release_versioning.md).
For picking the cheapest check that proves a change compiles - and the flags a build fails without -
see [Verifying a Change Compiles](build_verification.md).

---

## Version-based Flavor Selection  [Flavors](flavors.md)

The build logic dynamically adapts to the `VERSION` specified in the root-level `build.config` file:

```sh
VERSION=0.0.2
```

This versioning ensures **backward compatibility** with older versions that do not use flavors.

Depending on the version:

* `legacy`: flavors are not used
* `v0.0.1`: only deeplink flavor is applied
* `v0.0.2+`: both deeplink and SMS flavors are combined

Version logic is used to determine the correct flavor flags for build and run commands.

> In the future, iOS flavor support may be added similarly

---

## Dart Defines Based Flavor Computation

Values are parsed from `dart_define.json`:

* `WEBTRIT_APP_LINK_DOMAIN` → determines deeplink flavor
* `WEBTRIT_CALL_TRIGGER_MECHANISM_SMS` → determines smsReceiver flavor

### Example combined flavor:

```
--flavor deeplinkssmsReceiverDisabled
```

This ensures only required Android permissions or receivers are included in the app build.

---

## Build Commands

Use melos scripts to build. Extra Flutter flags are passed via the `FLUTTER_FLAGS` environment
variable.

| Command                      | Description                             |
|------------------------------|-----------------------------------------|
| `melos run build:apk`        | Build Android APK                       |
| `melos run build:appbundle`  | Build Android App Bundle                |
| `melos run build:ios`        | Build iOS app                           |
| `melos run build:ios:config` | Configure Xcode project only (no build) |

### Examples

```bash
# Debug build (default)
melos run build:apk

# Release build
FLUTTER_FLAGS="--release" melos run build:apk
FLUTTER_FLAGS="--release" melos run build:appbundle
FLUTTER_FLAGS="--release --no-codesign" melos run build:ios

# Custom version
FLUTTER_FLAGS="--build-name=1.2.3 --build-number=42 --release" melos run build:apk
```

All build commands read configuration from `dart_define.json` automatically.

The `build:*` scripts produce **unsigned / debug-signed** artifacts for local use. For signed
release artifacts and store uploads, use the fastlane scripts below.

---

## Signed Builds & Store Uploads (fastlane)

Signing and store submission live in two Fastfiles - `ios/fastlane/Fastfile` and
`android/fastlane/Fastfile` - wrapped by melos scripts so they are invoked the same way from a
laptop and from CI.

| Command                             | Description                                          |
|-------------------------------------|------------------------------------------------------|
| `melos run fastlane:install`        | Install fastlane if missing (brew on macOS, gem else) |
| `melos run fastlane:ios:build`      | Build and sign the iOS ipa                           |
| `melos run fastlane:ios:upload`     | Upload the ipa to TestFlight                         |
| `melos run fastlane:android:build`  | Build the signed Android app bundle                  |
| `melos run fastlane:android:upload` | Upload the aab to Google Play                        |

Every build/upload script runs `fastlane:install` first, so a fresh machine provisions itself.
All inputs come from the environment, prefixed per platform (`IOS_` / `ANDROID_`) so the two
platforms can define same-named values side by side without collisions.

### iOS

`melos run fastlane:ios:build` creates a throwaway keychain, imports the certificate and
provisioning profile, stamps the version into `Runner.xcodeproj`, disables automatic signing,
builds via `build_app`, then deletes the keychain.

| Variable                                    | Purpose                                            |
|---------------------------------------------|----------------------------------------------------|
| `IOS_CERTIFICATE_PATH`                      | Signing certificate to import                      |
| `IOS_PROVISIONING_PROFILE_PATH`             | Provisioning profile to install and apply          |
| `IOS_CODE_SIGNING_IDENTITY`                 | Identity for signing and `signingCertificate`      |
| `IOS_TEAM_ID`                               | Development team / export team                     |
| `IOS_BUILD_NAME`                             | Marketing version (`CFBundleShortVersionString`)   |
| `IOS_BUILD_NUMBER`                          | Build number (`CFBundleVersion`)                   |
| `IOS_BUILD_FILE_NAME`                       | Output ipa name, also the upload input             |
| `IOS_BUILD_SDK`                             | Optional `sdk` override for `build_app`            |
| `IOS_APP_STORE_CONNECT_API_KEY_ID`          | App Store Connect API key id (upload)              |
| `IOS_APP_STORE_CONNECT_API_KEY_ISSUER_ID`   | App Store Connect issuer id (upload)               |
| `IOS_APP_STORE_CONNECT_API_KEY_P8_PATH`     | Path to the `.p8` private key (upload)             |

The upload lane authenticates with an App Store Connect API key - no Apple ID password or 2FA
session - and skips waiting for build processing.

> The `.p8` path variable is deliberately prefixed. Unprefixed, pilot would pick
> `APP_STORE_CONNECT_API_KEY_PATH` up as its own `api_key_path` option, which expects a **JSON**
> key file, and fail while parsing the PEM.

### Android

`melos run fastlane:android:build` drives the flutter tool
(`flutter build appbundle --dart-define-from-file=dart_define.json --no-tree-shake-icons`) so
dart-defines, flavor selection, and version stamping behave exactly as in the `build:*` scripts.

| Variable                              | Default                | Purpose                                |
|---------------------------------------|------------------------|----------------------------------------|
| `ANDROID_BUILD_TARGET`                | `appbundle`            | `appbundle` or `apk`                   |
| `ANDROID_FLAVOR`                      | `deeplinkssmsReceiver` | Flavor combinator (see [Flavors](flavors.md)) |
| `ANDROID_BUILD_NAME`                  | -                      | Marketing version                      |
| `ANDROID_BUILD_NUMBER`                | -                      | Version code                           |
| `ANDROID_AAB_PATH`                    | -                      | Bundle to upload                       |
| `ANDROID_PLAY_STORE_JSON_KEY_PATH`    | -                      | Play service account JSON              |
| `ANDROID_PLAY_STORE_PACKAGE_NAME`     | -                      | Application id to publish under        |
| `ANDROID_PLAY_STORE_TRACK`            | `internal`             | Play track                             |
| `ANDROID_PLAY_STORE_RELEASE_STATUS`   | `draft`                | Play release status                    |

Release signing needs no fastlane input: `android/app/build.gradle` builds the release
`signingConfig` from `upload-keystore-metadata.json` in the keystore directory pointed at by the
`WEBTRIT_ANDROID_RELEASE_UPLOAD_KEYSTORE_PATH` dart-define. Watch the build log for
`Release signing NOT configured` if that path is wrong.

The upload lane pushes the bundle only - metadata, images, screenshots, and changelogs are skipped.

### Examples

```bash
# Keep the values in the gitignored .env and export them all at once
source .env
melos run fastlane:ios:build

# Or pass them inline
IOS_TEAM_ID=ABCDE12345 \
IOS_CERTIFICATE_PATH=certs/dist.p12 \
IOS_PROVISIONING_PROFILE_PATH=certs/app.mobileprovision \
IOS_CODE_SIGNING_IDENTITY="Apple Distribution" \
IOS_BUILD_NAME=1.2.3 IOS_BUILD_NUMBER=42 IOS_BUILD_FILE_NAME=build.ipa \
  melos run fastlane:ios:build

ANDROID_BUILD_NAME=1.2.3 ANDROID_BUILD_NUMBER=42 \
  melos run fastlane:android:build
```

The lanes can also be invoked directly from the platform directory - `cd ios && fastlane ios build`
- which is what the melos scripts do. Both platform directories carry a `Gemfile`, so prefer
`bundle exec fastlane ...` when running by hand to pin the fastlane version.

---

## Run Commands

| Command                   | Description                            |
|---------------------------|----------------------------------------|
| `melos run start:android` | Run on Android with `dart_define.json` |
| `melos run start:ios`     | Run on iOS device/simulator            |

### Examples

```bash
# Run on Android
melos run start:android

# Run on specific Android device
FLUTTER_FLAGS="-d emulator-5554" melos run start:android

# Run on iOS
melos run start:ios
```

---

## Development Workflow Notes

During development you may need to adjust your environment manually to work efficiently with
flavors.

### Options:

* **Terminal (recommended)**:

  Use melos scripts from the project root:

  ```bash
  melos run start
  melos run start:ios
  ```

* **IDE Configuration**:

  In IntelliJ IDEA or Android Studio, sync run configurations via `melos run ide:sync`,
  then use the generated run configurations from `.idea/runConfigurations/`.

* **Manual Flavor Selection**:

  When running directly from the IDE without melos, manually pass the correct
  `--flavor` (e.g., `--flavor deeplinkssmsReceiverDisabled`) in your launch configuration
  to match the current `dart_define.json`.

### Tip:

* Stick to a single flavor during development (e.g., the one most commonly enabled)
* Run `melos run ide:sync` after updating run configurations in `tool/run/`

> Melos scripts work best for **CI/CD and structured builds**. For day-to-day IDE development,
> use the synced run configurations or pass flags manually.

---

## Flutter Version Configuration

The Flutter SDK version used for building the project is pinned in `.fvmrc` — the single source of
truth, read by [`fvm`](https://fvm.app) locally and by the `webtrit_phone_builder` CI.

### Format

```json
{
  "flutter": "3.44.0"
}
```

### Purpose

By declaring the Flutter version here:

- One file drives both local development (`fvm flutter ...`) and CI — no drift between them
- You avoid hardcoding versions in CI workflows
- Builds remain reproducible and predictable

Install the pinned SDK once per machine with `fvm install`. The downloaded `.fvm/` cache is
gitignored.

> The channel is implied by the pinned version (we ship exact `stable` releases). The CI defaults
> the channel to `stable`.

### When to update

Update `.fvmrc` when:

- You upgrade the Flutter SDK in local development
- You have tested that the project works with the new version
- You want to ensure CI uses the updated version

Keep the version noted in `AGENTS.md` in sync, and always validate builds locally before changing
this file.

> **Legacy note:** `.github/flutter_version.yaml` was the previous source. It was removed once
> `.fvmrc` became the single source and `webtrit_phone_builder` was updated to read it. Older
> release branches may still carry the yaml; the builder falls back to it there.
