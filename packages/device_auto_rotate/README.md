# device_auto_rotate

A lightweight Flutter plugin to check and listen to the system's auto-rotate setting.

This plugin is primarily designed for **Android**, where `SystemChrome.setPreferredOrientations` can
override the system-wide rotation lock. It allows you to check if the user has locked their screen
orientation before attempting to force landscape mode.

## Features

* **Check Status:** Get the current system auto-rotate setting (`true`/`false`).
* **Real-time Stream:** Listen for changes to the auto-rotate setting (e.g., when the user toggles
  it in the Quick Settings panel).
* **Platform Safe:** Handles iOS and other platforms gracefully by returning `true` (allowing the OS
  to manage the lock).

## Installation

Since this is a local package, add it to your project's `pubspec.yaml` using the `path` reference:

```yaml
dependencies:
  device_auto_rotate:
    path: packages/device_auto_rotate

```

## Usage

Import the package:

```dart
import 'package:device_auto_rotate/device_auto_rotate.dart';

```

### 1. Check current status (One-time)

Use `DeviceAutoRotate.isEnabled` to check the setting once.

```dart
Future<void> checkRotation() async {
  final bool isAutoRotateEnabled = await DeviceAutoRotate.isEnabled;

  if (isAutoRotateEnabled) {
    // System rotation is ON: Safe to enable landscape mode
    print("Auto-rotate is enabled");
  } else {
    // System rotation is OFF: Should probably stick to Portrait
    print("Auto-rotate is disabled (Locked)");
  }
}

```

### 2. Listen for changes (Stream)

Use `DeviceAutoRotate.stream` to react to changes in real-time without restarting the app.

```dart
StreamSubscription<bool>? _subscription;

@override
void initState() {
  super.initState();
  _subscription = DeviceAutoRotate.stream.listen(_handleRotationChange);
}

void _handleRotationChange(bool isEnabled) {
  print("System rotation changed to: $isEnabled");
  // Update your app's orientation logic here
}

@override
void dispose() {
  _subscription?.cancel();
  super.dispose();
}

```

## Platform Behavior

| Platform    | Behavior        | Details                                                                                                                                                                                 |
|-------------|-----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Android** | **Real Check**  | Checks `Settings.System.ACCELEROMETER_ROTATION`. Returns `true` if enabled, `false` if locked.                                                                                          |
| **iOS**     | **Always True** | iOS strictly enforces the Orientation Lock at the OS level. Even if you request Landscape in Flutter, iOS will ignore it if the lock is on. Therefore, manual checking is not required. |
| **Others**  | **Always True** | Fallback for web/desktop/tests is `true`.                                                                                                                                               |

```
