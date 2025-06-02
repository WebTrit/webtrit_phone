# 🛠 WebTrit Shared Makefile Build Process

This documentation describes the structure, logic, and usage of the [
`makefile.shared`](https://github.com/WebTrit/webtrit_phone_tools/blob/main/Makefile.shared) used in WebTrit projects.  
It handles conditional build and run logic based on configuration version and Dart defines.

➡️ For a detailed reference of the internal structure, see
the [shared_makefile_reference.md](https://github.com/WebTrit/webtrit_phone_tools/blob/main/docs/shared_makefile_reference.md)

---

## 🔗 Inclusion

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

## 🧩 Version-based Flavor Selection  [Flavors](flavors.md).

The build logic dynamically adapts to the `VERSION` specified in the root-level `build.config` file:

```sh
VERSION=0.0.2
```

This versioning file is located at the root of the project and was introduced to ensure **backward compatibility** with
older versions that do not use flavors.

Depending on this version:

* `legacy`: flavors are not used
* `v0.0.1`: only deeplink flavor is applied
* `v0.0.2+`: both deeplink and SMS flavors are combined

The version logic is delegated to the included shared `makefile.shared`, allowing central control of behavior per
version.

> ℹ️ In the future, iOS flavor support may be added similarly for consistency

---

## 🧠 Dart Defines Based Flavor Computation

Values are parsed from `dart_define.json`:

* `WEBTRIT_APP_LINK_DOMAIN` → determines deeplink flavor
* `WEBTRIT_CALL_TRIGGER_MECHANISM_SMS` → determines smsReceiver flavor

### Combined:

```
--flavor deeplinkssmsReceiverDisabled
```

Flavors are used to conditionally include Android permissions, services, or receivers based on features enabled for the
client — ensuring no unnecessary permissions are requested.

---

## ⚙️ Build Commands

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

## ▶️ Run Commands

| Target         | Description                        |
|----------------|------------------------------------|
| `make run`     | Runs the app with default platform |
| `make run-apk` | Runs on Android with APK build     |
| `make run-ios` | Runs on iOS                        |

Flavor selection is auto-applied unless legacy version.

---

## 💻 Development Workflow Notes

While the [`makefile.shared`](https://github.com/WebTrit/webtrit_phone_tools/blob/main/Makefile.shared) handles builds
and flavor logic very well, **during development you may need to adjust your environment manually** to work efficiently
with flavors.

### Options:

* ⚙️ **IDE Configuration**:

  In IntelliJ IDEA or Android Studio, configure a custom **Run/Debug Configuration** to use `make` with your desired
  target (e.g., `run-apk`) and working directory set to the root project.

* 🧪 **Manual Flavor Selection**:

  Alternatively, when running from the IDE without using `make`, you must manually pass the correct `--flavor` (e.g.,
  `--flavor deeplinkssmsReceiverDisabled`) in your launch configuration to match the current `dart_define.json`.

### Tip:

For easier debugging and local development:

* Stick to a single flavor during development (e.g., the one most commonly enabled)
* Or create a helper shell script that wraps the `flutter run` with computed flavors

> 🧠 The Makefile works best for **CI/CD and structured builds**, but for day-to-day development, some manual steps are
> currently needed.

