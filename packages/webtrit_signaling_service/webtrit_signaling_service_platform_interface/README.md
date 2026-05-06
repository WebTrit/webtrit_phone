# webtrit_signaling_service_platform_interface

Shared foundation for the `webtrit_signaling_service` federated plugin.

Defines the abstract API contract, the shared event model, the connection config DTO, and
`WebtritSignalingServiceDirect` -- a concrete base for platforms where the WebSocket runs
directly in the calling isolate (iOS and Android pushBound mode).

---

## Key types

### `SignalingServicePlatform`

Abstract base class. Platform implementations must **extend** this class --
`PlatformInterface` token verification enforces this at runtime and prevents accidental
`implements`. Provides default no-op implementations for platform-specific methods
(`stopService`, `restoreService`, `simulateKill`, `setHandoffCallback`) so iOS does not
need to override them.

### `WebtritSignalingServiceDirect`

Concrete subclass of `SignalingServicePlatform` for direct WebSocket mode (no FGS, no
background isolate). Used as-is on iOS; subclassed on Android as
`WebtritSignalingServiceAndroidDirect` to add the push-isolate handoff hook.

Exposes two protected hooks for subclasses:
- `onBeforeStart(config)` -- called after the previous module is torn down, before the new
  one is created. Used on Android to register the `IsolateNameServer` handoff port.
- `onConnected()` -- called when the module emits `SignalingConnected`. Used on Android to
  signal the push isolate that the Activity WebSocket is live.

### `SignalingServiceConfig`

| Field | Type | Description |
|-------|------|-------------|
| `coreUrl` | `String` | Server URL (scheme normalized by the implementation) |
| `tenantId` | `String` | WebTrit tenant identifier |
| `token` | `String` | Auth token |
| `trustedCertificates` | `TrustedCertificates` | Custom CA certs; empty by default |

### `SignalingServiceMode`

| Value | Behaviour |
|-------|-----------|
| `persistent` | Android FGS survives app closure and device reboot (default) |
| `pushBound` | Direct WebSocket in the calling isolate; lifecycle tied to the calling context |

On iOS the mode parameter is ignored -- the connection always runs in the main isolate.

### `SignalingModuleEvent` (sealed)

| Event | Key fields |
|-------|------------|
| `SignalingConnecting` | -- |
| `SignalingConnected` | -- |
| `SignalingConnectionFailed` | `error`, `isRepeated`, `recommendedReconnectDelay` |
| `SignalingDisconnecting` | -- |
| `SignalingDisconnected` | `code?`, `reason?`, `knownCode`, `recommendedReconnectDelay?` |
| `SignalingHandshakeReceived` | `handshake` (`StateHandshake`) |
| `SignalingProtocolEvent` | `event` (`Event`) |

### `SignalingModule`

Internal contract for the WebSocket session unit. Implemented directly
(`SignalingModuleImpl`) for the direct path and via `SignalingHubModule` for the FGS hub
path. Not intended for direct use by app code.

---

## Source layout

```
lib/src/
  signaling_service_platform.dart   - SignalingServicePlatform abstract class
  signaling_service_direct.dart     - WebtritSignalingServiceDirect concrete base
  signaling_module_impl.dart        - default SignalingModule implementation
  signaling_event_buffer.dart       - replay buffer for late subscribers
  signaling_request_queue.dart      - request serialization during reconnect
  models/
    signaling_module.dart           - SignalingModule abstract interface
    signaling_module_event.dart     - event sealed hierarchy
    signaling_module_factory.dart   - factory typedef
    signaling_service_config.dart   - connection params DTO
    signaling_service_mode.dart     - mode enum
```

---

## Related packages

| Package | Description |
|---------|-------------|
| [`webtrit_signaling_service`](../webtrit_signaling_service/README.md) | Public API aggregator |
| [`webtrit_signaling_service_android`](../webtrit_signaling_service_android/README.md) | Android implementation |
| [`webtrit_signaling_service_ios`](../webtrit_signaling_service_ios/README.md) | iOS implementation |
