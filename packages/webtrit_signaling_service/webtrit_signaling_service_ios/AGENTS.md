# webtrit_signaling_service_ios

iOS stub implementation of `webtrit_signaling_service`.

On iOS there is no equivalent of Android's foreground service — the OS suspends
background processes. The signaling connection therefore runs directly in the
main isolate (same as the original `WebtritSignalingClient` usage in `CallBloc`).

## Current State

Fully implemented. The plugin does **not** depend on `webtrit_signaling` directly.
`setModuleFactory()` stores the app-provided factory; `start()` calls it to create a
`SignalingModuleInterface` in the main isolate and calls `connect()`.
`attach()`, `updateMode()`, and `setIncomingCallHandler()` are no-ops — no background
process exists on iOS.

## Public API

Registered via `WebtritSignalingServiceIos.registerWith()` as `SignalingServicePlatform.instance`.

Inherits the same interface as the Android package:

```dart
Stream<SignalingModuleEvent> get events;
Future<void> setModuleFactory(SignalingModuleFactory factory);
Future<void> start(SignalingServiceConfig config, {SignalingServiceMode mode = SignalingServiceMode.persistent});
Future<void> attach();
Future<void> execute(Request request);
Future<void> updateMode(SignalingServiceMode mode);
Future<void> setIncomingCallHandler(Function callback);
Future<void> dispose();
```

## Key Classes

### `WebtritSignalingServiceIos` (plugin entry point)

| Method | Behaviour |
|--------|-----------|
| `setModuleFactory(factory)` | Stores `factory` in `_factory`. Must be called before `start()`. |
| `start(config, {mode})` | Disposes any existing module; calls `_factory!(config)` to create a `SignalingModuleInterface`; pipes its events to `_eventsController`; calls `connect()`. `mode` is accepted for API compatibility — no behavioural difference on iOS. |
| `attach()` | No-op. Logs a message. No background process exists to attach to. |
| `execute(request)` | Delegates to the module's `execute`; throws `StateError` when not connected. |
| `updateMode(mode)` | No-op. Logs a message. Mode switching has no meaning on iOS. |
| `setIncomingCallHandler(callback)` | No-op. Logs a message. Background isolate callbacks are not used on iOS. |
| `dispose()` | Cancels subscription, disposes module, closes `_eventsController`. |

## Commands

```bash
dart pub get
dart analyze
dart test
```

## Code Style

- Line width: 120 characters; single quotes; `lints/recommended.yaml`.
