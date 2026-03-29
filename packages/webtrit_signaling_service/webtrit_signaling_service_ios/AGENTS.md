# webtrit_signaling_service_ios

iOS stub implementation of `webtrit_signaling_service`.

On iOS there is no equivalent of Android's foreground service — the OS suspends
background processes. The signaling connection therefore runs directly in the
main isolate (same as the original `WebtritSignalingClient` usage in `CallBloc`).

## Current State

Fully implemented. `start()` creates `SignalingModule` in the main isolate and
calls `connect()`. `attach()`, `updateMode()`, and `setIncomingCallHandler()` are
no-ops — no background process exists on iOS.

## Public API

Registered via `WebtritSignalingServiceIos.registerWith()` as `SignalingServicePlatform.instance`.

Inherits the same interface as the Android package:

```dart
Stream<SignalingModuleEvent> get events;
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
| `start(config, {mode})` | Disposes any existing module; creates `SignalingModule`; pipes its events to `_eventsController`; calls `connect()`. `mode` is accepted for API compatibility — no behavioural difference on iOS. |
| `attach()` | No-op. Logs a message. No background process exists to attach to. |
| `execute(request)` | Delegates to `SignalingModule.execute`; throws `StateError` when not connected. |
| `updateMode(mode)` | No-op. Logs a message. Mode switching has no meaning on iOS. |
| `setIncomingCallHandler(callback)` | No-op. Logs a message. Background isolate callbacks are not used on iOS. |
| `dispose()` | Cancels subscription, disposes module, closes `_eventsController`. |

### `SignalingModule`

Manages a single `WebtritSignalingClient` lifecycle and replays the session buffer
to every new subscriber via `events`. Similar to the Android version but without
the `signalingClient` getter (not needed — no hub on iOS).

## Commands

```bash
dart pub get
dart analyze
dart test
```

## Code Style

- Line width: 120 characters; single quotes; `lints/recommended.yaml`.
