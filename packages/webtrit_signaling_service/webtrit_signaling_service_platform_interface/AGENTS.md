# webtrit_signaling_service_platform_interface

Shared contract package for the `webtrit_signaling_service` plugin.
Defines the abstract platform interface, event model, and config DTO.
No Flutter platform channels here — platform-specific packages implement the abstract class.

## Public API

### `SignalingServicePlatform` (abstract)

```dart
abstract class SignalingServicePlatform extends PlatformInterface {
  static SignalingServicePlatform get instance { ... }
  static set instance(SignalingServicePlatform instance) { ... }

  Stream<SignalingModuleEvent> get events;
  Future<void> start(SignalingServiceConfig config, {SignalingServiceMode mode = SignalingServiceMode.persistent});
  Future<void> attach();
  Future<void> execute(Request request);
  Future<void> updateMode(SignalingServiceMode mode);
  Future<void> setIncomingCallHandler(Function callback);
  Future<void> dispose();
}
```

Platform implementations must **extend** this class (not implement it) — `PlatformInterface` token verification enforces this at runtime.

### `SignalingServiceMode`

| Value | Behaviour |
|-------|-----------|
| `persistent` | Service runs indefinitely; survives app close; restarted on boot (default) |
| `pushBound` | Service stops when the Activity is removed (`onTaskRemoved`); suited for push-initiated calls |

### `SignalingServiceConfig`

```dart
class SignalingServiceConfig {
  const SignalingServiceConfig({
    required String coreUrl,        // e.g. 'wss://demo.webtrit.com'
    required String tenantId,
    required String token,
    TrustedCertificates trustedCertificates = TrustedCertificates.empty,
  });
}
```

### `SignalingModuleEvent` (sealed)

Defined in `lib/src/models/signaling_module_event.dart` and exported by this package.
All events are typed and exhaustively matchable:

| Event | Meaning |
|-------|---------|
| `SignalingConnecting` | WebSocket dial started |
| `SignalingConnected` | TCP + WebSocket handshake complete |
| `SignalingConnectionFailed` | Connect attempt failed; carries `error`, `isRepeated`, `recommendedReconnectDelay` |
| `SignalingDisconnecting` | Graceful disconnect initiated (local) |
| `SignalingDisconnected` | Socket closed; carries `code`, `reason`, `knownCode`, `recommendedReconnectDelay?` |
| `SignalingHandshakeReceived` | Server sent `StateHandshake`; carries `handshake` |
| `SignalingProtocolEvent` | Any other protocol `Event` (register, call, ICE, …) |

### `SignalingModuleInterface` (abstract)

Internal contract shared by `SignalingModule` and `SignalingHubModule`:

```dart
abstract class SignalingModuleInterface {
  Stream<SignalingModuleEvent> get events;
  bool get isConnected;
  void connect();
  Future<void> disconnect();
  Future<void>? execute(Request request);
  Future<void> dispose();
}
```

## Method Notes

### `updateMode(SignalingServiceMode mode)`

Switches the service lifecycle mode at runtime without tearing down the current WebSocket
connection when not necessary.

- On Android: updates the mode flag via Pigeon (`startService(mode)`), which changes whether `onTaskRemoved` stops the service. The hub/foreground service keeps running — only the lifecycle behaviour changes.
- On iOS this is a no-op.

### `setIncomingCallHandler(Function callback)`

Registers the app-side incoming call callback for background handling.

`callback` must be a top-level function annotated with `@pragma('vm:entry-point')`. It receives
an `IncomingCallEvent` and is responsible for triggering callkeep. The Android implementation
resolves the raw handle internally via `PluginUtilities.getCallbackHandle` and persists it to
`SharedPreferences`; the background isolate reads it at each sync.

On iOS this is a no-op.

## Barrel Export

`lib/webtrit_signaling_service_platform_interface.dart` — re-exports the 5 local source files listed above. Does **not** re-export `webtrit_signaling` directly; consumers that need `Request`, `Event`, or `StateHandshake` must add `webtrit_signaling` as a direct dependency.

## Dependencies

- `plugin_platform_interface` — `PlatformInterface` token verification
- `webtrit_signaling` — `Request`, `Event`, sealed event hierarchy, `StateHandshake`
- `ssl_certificates` — `TrustedCertificates`

## Commands

```bash
dart pub get
dart analyze
dart test
```

## Code Style

- No code generation; all classes hand-written.
- Line width: 120 characters; single quotes; `lints/recommended.yaml`.
