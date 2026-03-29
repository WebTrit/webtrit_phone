# webtrit_signaling_service_platform_interface

The common platform interface for the `webtrit_signaling_service` federated plugin. Defines the
abstract API contract, the event model, the connection config DTO, and the internal module
interface that every platform implementation must satisfy.

---

## Purpose

This package exists so that:

- Platform implementations (`webtrit_signaling_service_android`, `webtrit_signaling_service_ios`)
  implement a consistent interface without depending on each other.
- The aggregator package (`webtrit_signaling_service`) programs against a single abstract type.
- Third-party platform implementations can extend `SignalingServicePlatform` without forking the
  plugin.

---

## Package structure

```text
lib/src/
├── signaling_service_platform.dart     # SignalingServicePlatform — abstract class
└── models/
    ├── signaling_module_event.dart     # SignalingModuleEvent sealed hierarchy (defined here)
    ├── signaling_module_interface.dart # SignalingModuleInterface — internal contract
    ├── signaling_service_config.dart   # SignalingServiceConfig — connection params DTO
    └── signaling_service_mode.dart     # SignalingServiceMode enum (persistent / pushBound)
lib/
└── webtrit_signaling_service_platform_interface.dart  # Barrel export
```

---

## Key types

### `SignalingServicePlatform`

Abstract base class. Platform implementations must **extend** this class — `PlatformInterface`
token verification enforces this at runtime and prevents accidental `implements`.

```dart
abstract class SignalingServicePlatform extends PlatformInterface {
  static SignalingServicePlatform get instance { ... }
  static set instance(SignalingServicePlatform instance) { ... }

  Stream<SignalingModuleEvent> get events;
  Future<void> start(SignalingServiceConfig config, {SignalingServiceMode mode = SignalingServiceMode.persistent});
  Future<void> attach();
  Future<void> execute(Request request);
  Future<void> dispose();
}
```

### `SignalingServiceConfig`

| Field | Type | Description |
| --- | --- | --- |
| `coreUrl` | `String` | Server URL (`https://` or `wss://` — scheme is normalized by the implementation) |
| `tenantId` | `String` | WebTrit tenant identifier |
| `token` | `String` | Auth token |
| `trustedCertificates` | `TrustedCertificates` | Custom CA certs; defaults to `TrustedCertificates.empty` |

### `SignalingModuleEvent` (sealed)

| Event | Key fields |
| --- | --- |
| `SignalingConnecting` | — |
| `SignalingConnected` | — |
| `SignalingConnectionFailed` | `error`, `isRepeated`, `recommendedReconnectDelay` |
| `SignalingDisconnecting` | — |
| `SignalingDisconnected` | `code?`, `reason?`, `knownCode` (`SignalingDisconnectCode`), `recommendedReconnectDelay?` |
| `SignalingHandshakeReceived` | `handshake` (`StateHandshake`) |
| `SignalingProtocolEvent` | `event` (`Event`) |

### `SignalingServiceMode`

| Value | Behaviour |
| --- | --- |
| `persistent` | Service runs indefinitely; survives app close; restarted on boot (default) |
| `pushBound` | Service stops when the Activity is removed (`onTaskRemoved`); suited for push-initiated calls |

### `SignalingModuleInterface`

Internal contract shared by `SignalingModule` (direct WebSocket) and `SignalingHubModule`
(hub proxy). Exported from this package for use by platform implementations; not intended
for direct use by app code.

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

---

## Implementing a new platform

```dart
class WebtritSignalingServiceCustom extends SignalingServicePlatform {
  static void registerWith() {
    SignalingServicePlatform.instance = WebtritSignalingServiceCustom();
  }

  @override
  Stream<SignalingModuleEvent> get events => /* ... */;

  @override
  Future<void> start(SignalingServiceConfig config, {SignalingServiceMode mode = SignalingServiceMode.persistent}) async { /* ... */ }

  @override
  Future<void> attach() async { /* ... */ }

  @override
  Future<void> execute(Request request) async { /* ... */ }

  @override
  Future<void> dispose() async { /* ... */ }
}
```

---

## Related packages

| Package | Description |
| --- | --- |
| [`webtrit_signaling_service`](../webtrit_signaling_service/README.md) | Public API aggregator |
| [`webtrit_signaling_service_android`](../webtrit_signaling_service_android/README.md) | Android implementation |
| [`webtrit_signaling_service_ios`](../webtrit_signaling_service_ios/README.md) | iOS implementation |
