# device_auto_rotate

Flutter plugin that checks and monitors the Android system auto-rotate setting.
Android-only — iOS and other platforms always return `true` (safe default).

## Public API

- `static Future<bool> get DeviceAutoRotate.isEnabled` — one-time check via MethodChannel
- `static Stream<bool> get DeviceAutoRotate.stream` — real-time updates via EventChannel + ContentObserver

Error handling contract: any exception or unsupported platform returns `true` (never locks into portrait silently).

## Architecture

```
DeviceAutoRotate (lib/device_auto_rotate.dart)
    ├── MethodChannel "device_auto_rotate"        → one-time query
    └── EventChannel "device_auto_rotate_stream"  → real-time stream
              ↓
    DeviceAutoRotatePlugin.kt (android/)
        ├── onMethodCall() → Settings.System.ACCELEROMETER_ROTATION
        └── ContentObserver → emits on every settings change
```

## Key Rules

- Native class `DeviceAutoRotatePlugin` (Kotlin) implements `FlutterPlugin`, `MethodChannel.MethodCallHandler`, `EventChannel.StreamHandler`.
- ContentObserver: registered in `onListen()`, unregistered in `onCancel()` — do not break this lifecycle.
- Monitored setting: `Settings.System.ACCELEROMETER_ROTATION` (1 = enabled, 0 = disabled).
- Do not add iOS native code — the Dart layer already handles it.

## Commands

```bash
flutter test test/device_auto_rotate_test.dart
cd example && flutter test integration_test/plugin_integration_test.dart
cd example && flutter run
```
