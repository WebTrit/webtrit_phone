# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Package Overview

`device_auto_rotate` is a Flutter plugin that checks and monitors the Android system auto-rotate setting. Android-only — iOS and other platforms always return `true` (safe default that avoids locking orientation).

## Commands

```bash
# Run unit tests
flutter test test/device_auto_rotate_test.dart

# Run integration tests (from example/)
cd example && flutter test integration_test/plugin_integration_test.dart

# Run example app
cd example && flutter run
```

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

**Public API** (`DeviceAutoRotate`):
- `static Future<bool> get isEnabled` — one-time check via MethodChannel
- `static Stream<bool> get stream` — real-time updates via EventChannel + ContentObserver

**Error handling contract**: any exception or unsupported platform returns `true` (allow rotation), never locks the user into portrait mode silently.

## Key Design Rules

- The native plugin class is `DeviceAutoRotatePlugin` (Kotlin). It implements `FlutterPlugin`, `MethodChannel.MethodCallHandler`, and `EventChannel.StreamHandler`.
- ContentObserver is registered in `onListen()` and unregistered in `onCancel()` — do not break this lifecycle.
- The single monitored setting is `Settings.System.ACCELEROMETER_ROTATION` (1 = enabled, 0 = disabled).
- Android is the only supported platform. Do not add iOS native code — the Dart layer already handles it.
