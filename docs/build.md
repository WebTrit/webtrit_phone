# Build & Development Process Overview

This documentation describes how to build and run the WebTrit Phone project.
It includes melos script usage, flavor configuration, Flutter SDK version management, and tips
for local development.

For all available melos scripts, see [Melos Commands](make_file.md).

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

The Flutter SDK version used for building the project is defined in `.github/flutter_version.yaml`.

This file provides a centralized way to define the required Flutter version and channel. It helps
ensure consistency across development machines and automated build environments.

### Format

```yaml
flutter:
  version: "3.29.0"
  channel: "stable"
```

### Purpose

By declaring the Flutter version here:

- You avoid hardcoding versions in CI workflows
- All environments (local and CI) can stay aligned
- Builds remain reproducible and predictable

The file is intended to be read by automation scripts to configure the correct SDK version before
building the project.

### When to update

Update `.github/flutter_version.yaml` when:

- You upgrade the Flutter SDK in local development
- You have tested that the project works with the new version
- You want to ensure CI uses the updated version

Always validate builds locally before changing this file.
