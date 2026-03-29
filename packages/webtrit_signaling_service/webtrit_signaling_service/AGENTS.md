# webtrit_signaling_service

Public umbrella package for the standalone signaling service plugin.
Provides a single `WebtritSignalingService` façade; delegates everything to
`SignalingServicePlatform.instance` which is set by the platform package at startup.

## Entry Point

```dart
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

final service = WebtritSignalingService();

// 0. (Android only) Register the background incoming-call handler BEFORE start().
//    The plugin resolves the callback handle internally via PluginUtilities.
if (Platform.isAndroid) {
  await service.setIncomingCallHandler(onSignalingBackgroundIncomingCall);
}

// 1. Subscribe before starting
service.events.listen((event) {
  switch (event) {
    case SignalingConnected():      /* update UI */ break;
    case SignalingHandshakeReceived(:final handshake): /* ... */ break;
    case SignalingProtocolEvent(:final event): /* ... */ break;
    default: break;
  }
});

// 2a. Start in persistent mode (default)
await service.start(SignalingServiceConfig(
  coreUrl: 'wss://demo.webtrit.com',
  tenantId: 'default',
  token: '<auth-token>',
));

// 2b. Or start in push-bound mode (service stops when app is closed)
await service.start(config, mode: SignalingServiceMode.pushBound);

// 2c. Or attach to an already-running hub (push-initiated scenario)
await service.attach();

// 3. Send a request (while connected)
await service.execute(HangupRequest(transaction: 'tx-1', line: 1, callId: 'call-1'));

// 4. Switch mode at runtime without restarting the WebSocket connection
await service.updateMode(SignalingServiceMode.pushBound);

// 5. Stop
await service.dispose();
```

## Public API

### `WebtritSignalingService`

| Member | Description |
|--------|-------------|
| `events` | Broadcast `Stream<SignalingModuleEvent>` — safe to subscribe before `start()` |
| `start(config, {mode})` | Starts the platform service; `mode` defaults to `SignalingServiceMode.persistent` |
| `attach()` | Connects to an already-running hub without starting a new service |
| `execute(request)` | Sends a `Request` via the active connection; throws when not connected |
| `updateMode(mode)` | Switches service lifecycle mode at runtime without restarting the WebSocket |
| `setIncomingCallHandler(callback)` | Registers the app-side incoming call callback for background handling (Android); no-op on iOS |
| `dispose()` | Stops the service and releases all resources |

### `SignalingServiceMode`

Both modes run the WebSocket inside the Android foreground service (background isolate + hub).
The only difference is the **service lifecycle**:

| Value | Lifecycle | How incoming calls arrive |
|-------|-----------|--------------------------|
| `persistent` | Service survives app close and device reboot. `onTaskRemoved` does **not** stop the service. Server always has an active connection — no FCM push needed. `IncomingCallEvent` arrives directly via the running WebSocket and is dispatched to the app callback (`onSignalingBackgroundIncomingCall`). | WebSocket → `SignalingForegroundIsolateManager` → app callback → callkeep |
| `pushBound` | Service is tied to the Activity lifecycle. `onTaskRemoved` stops the service. After the app closes the WebSocket dies — the server sees the client disconnected and sends an FCM push for the next call. The push-notification isolate (callkeep) calls `start(config, pushBound)` to bring the service back up, then `attach()` when the Activity opens. | FCM push → callkeep isolate → `start(pushBound)` → hub → `attach()` from main isolate |

**Shared hub architecture (both modes):**

```
Push/callkeep isolate   ──attach──►  SignalingHub (background isolate, foreground service)
Main isolate            ──attach──►       │
                                          └─ SignalingModule (single WebSocket)
```

The WebSocket always lives in the foreground-service background isolate.
Push and main isolates only connect to the hub — they never open their own WebSocket.

### `SignalingServiceConfig`

| Field | Type | Description |
|-------|------|-------------|
| `coreUrl` | `String` | Base URL, e.g. `wss://demo.webtrit.com` (scheme auto-converted) |
| `tenantId` | `String` | WebTrit tenant identifier |
| `token` | `String` | Auth token |
| `trustedCertificates` | `TrustedCertificates` | Custom CA certs; defaults to empty (system trust) |

### `SignalingModuleEvent` (sealed, from platform_interface)

```
SignalingConnecting
SignalingConnected
SignalingConnectionFailed  — error, isRepeated, recommendedReconnectDelay
SignalingDisconnecting
SignalingDisconnected      — code?, reason?, knownCode, recommendedReconnectDelay?
SignalingHandshakeReceived — handshake (StateHandshake)
SignalingProtocolEvent     — event (Event)
```

## Background Incoming Call Handler (Android)

When the app is closed and the service runs in `persistent` mode, incoming calls arrive
in the background foreground-service isolate. The plugin dispatches them to a registered
app-side Dart callback so the app can trigger callkeep independently.

### App-side callback

```dart
// lib/features/call/services/services_isolate.dart (or similar)
@pragma('vm:entry-point')
Future<void> onSignalingBackgroundIncomingCall(IncomingCallEvent event) async {
  if (!Platform.isAndroid) return;
  await AndroidCallkeepServices.backgroundPushNotificationBootstrapService
      .reportNewIncomingCall(
        event.callId,
        CallkeepHandle.number(event.caller),
        displayName: event.callerDisplayName,
        hasVideo: JsepValue.fromOptional(event.jsep)?.hasVideo ?? false,
      );
}
```

### Registration (once per session, before `start()`)

```dart
if (Platform.isAndroid) {
  unawaited(WebtritSignalingService().setIncomingCallHandler(onSignalingBackgroundIncomingCall));
}
```

Key constraints:

- The function must be a **top-level** function annotated `@pragma('vm:entry-point')` to survive tree-shaking.
- The plugin resolves the raw handle internally via `PluginUtilities.getCallbackHandle` and persists it to `SharedPreferences`; the background isolate reads it at each sync.
- On iOS `setIncomingCallHandler` is a no-op.

## Platform Packages

| Platform | Package | Notes |
|----------|---------|-------|
| Android | `webtrit_signaling_service_android` | Foreground service + IsolateNameServer hub |
| iOS | `webtrit_signaling_service_ios` | Direct main-isolate `SignalingModule`; fully implemented |

## Example App

`example/` — runnable Flutter app demonstrating start/stop, connection status,
handshake info, and a live event log. Requires a real WebTrit Core server.

```bash
cd example
flutter run -d <device-id>
```

## Dependencies

- `webtrit_signaling` — `Request` hierarchy, `Event`, `StateHandshake`
- `webtrit_signaling_service_platform_interface` — `SignalingServicePlatform`, `SignalingModuleEvent`, `SignalingServiceConfig`
- `webtrit_signaling_service_android` / `webtrit_signaling_service_ios` — platform implementations (resolved at build time)

## Commands

```bash
dart pub get
dart analyze
flutter test
```

## Code Style

- Line width: 120 characters; single quotes; `lints/recommended.yaml`.
- No code generation.
