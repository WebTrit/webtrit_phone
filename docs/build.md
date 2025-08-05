# Build & Development Process Overview

This documentation describes how to build and run the WebTrit Phone project.  
It includes shared Makefile logic, flavor configuration, Flutter SDK version management, and tips
for local development.

For a detailed reference of the internal Makefile structure, see
the [shared_makefile_reference.md](https://github.com/WebTrit/webtrit_phone_tools/blob/main/docs/shared_makefile_reference.md)

---

## Inclusion of Shared Makefile

The shared logic is included in the local project Makefile as follows:

```makefile
# ===========================
# Include Shared Makefile Logic
# ===========================

TOOLS_MAKEFILE := makefile.shared

ifeq (,$(wildcard $(TOOLS_MAKEFILE)))
$(shell curl -sSL https://raw.githubusercontent.com/WebTrit/webtrit_phone_tools/refs/heads/main/Makefile.shared -o $(TOOLS_MAKEFILE))
endif

include $(TOOLS_MAKEFILE)
```

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

Version logic is delegated to the shared `makefile.shared`.

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

The following targets are available:

| Target                       | Description                                |
|------------------------------|--------------------------------------------|
| `make build`                 | Builds the app with default platform (APK) |
| `make build-apk`             | Builds Android APK                         |
| `make build-appbundle`       | Builds Android App Bundle                  |
| `make build-ios`             | Builds iOS app                             |
| `make build-ios-config-only` | iOS config-only build                      |

### Optional Parameters:

* `build_name` — passed as `--build-name`
* `build_number` — passed as `--build-number`
* `release=true` — adds `--release`
* `no_codesign=true` — disables iOS codesign
* `config_only=true` — used for iOS config-only

---

## Run Commands

| Target         | Description                        |
|----------------|------------------------------------|
| `make run`     | Runs the app with default platform |
| `make run-apk` | Runs on Android with APK build     |
| `make run-ios` | Runs on iOS                        |

Flavor selection is auto-applied unless legacy version.

---

## Development Workflow Notes

While the [
`makefile.shared`](https://github.com/WebTrit/webtrit_phone_tools/blob/main/Makefile.shared) handles
builds and flavor logic very well, **during development you may need to adjust your environment
manually** to work efficiently with flavors.

### Options:

* **IDE Configuration**:

  In IntelliJ IDEA or Android Studio, configure a custom **Run/Debug Configuration** to use `make`
  with your desired target (e.g., `run-apk`) and working directory set to the root project.

* **Manual Flavor Selection**:

  Alternatively, when running from the IDE without using `make`, you must manually pass the correct
  `--flavor` (e.g., `--flavor deeplinkssmsReceiverDisabled`) in your launch configuration to match
  the current `dart_define.json`.

### Tip:

For easier debugging and local development:

* Stick to a single flavor during development (e.g., the one most commonly enabled)
* Or create a helper shell script that wraps `flutter run` with computed flavors

> The Makefile works best for **CI/CD and structured builds**, but for day-to-day development,
> some manual steps are currently needed.

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
