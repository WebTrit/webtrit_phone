# webtrit_signaling_service_android

Android implementation of [`webtrit_signaling_service`](../webtrit_signaling_service/README.md).

---

## Modes

### persistent

The WebSocket runs inside an Android **Foreground Service** in a dedicated background isolate.
The main isolate never opens its own WebSocket - it connects to the FGS via
`IsolateNameServer` (hub pattern). The service survives app closure and is restarted after
device reboot via `SignalingBootReceiver`.

### pushBound

No FGS. The WebSocket runs **directly in the calling isolate**, identical to the iOS
implementation (`WebtritSignalingServiceDirect`). The service stops when the user swipes the
app away. The next session is started by an FCM push notification.

---

## How the hub works (persistent mode)

The background isolate owns a `SignalingHub` - a `ReceivePort` registered in
`IsolateNameServer`. The main isolate (and optionally a push isolate) connect to it as
subscribers and receive encoded events over `SendPort`. No second WebSocket is ever opened.

---

## Push-isolate handoff (pushBound mode)

When an FCM push arrives, a short-lived push isolate opens a direct WebSocket. Once the
user opens the app and the Activity isolate connects its own WebSocket, it signals the push
isolate via `IsolateNameServer` (`kPushHandoffPortName`). The push isolate then terminates
early instead of waiting for a 20-second FCM timeout.

---

## Android-specific notes

- Events never cross via Pigeon - only lifecycle control (start/stop/mode) does.
- `_isStopped` guard in `WebtritSignalingServiceAndroid` prevents the hub-dead callback from
  restarting the FGS after an intentional stop (logout, dispose).
- `dispose()` intentionally does **not** call `stopService()` - the Kotlin side manages the
  service lifecycle (`onTaskRemoved` for pushBound, explicit stop for persistent).
- `messages.g.dart` / `Messages.g.kt` are Pigeon-generated - do not edit manually.

---

## Source layout

```
lib/src/
  plugin.dart              - entry point, orchestrates both modes
  messages.g.dart          - Pigeon generated
  mode_mapping.dart        - mode enum conversion
  constants.dart           - shared port names and timeouts
  fgs/                     - persistent / Foreground Service
    hub_connection_manager.dart
    hub/                   - hub protocol (SignalingHub, client, codec)
    isolate/               - background isolate lifecycle
  direct/                  - pushBound / direct WebSocket
    signaling_service_android_direct.dart
```

---

## Related packages

| Package                                                                                                     | Description                                               |
|-------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------|
| [`webtrit_signaling_service_platform_interface`](../webtrit_signaling_service_platform_interface/README.md) | Shared interface and `WebtritSignalingServiceDirect` base |
| [`webtrit_signaling_service`](../webtrit_signaling_service/README.md)                                       | Public API aggregator                                     |
| [`webtrit_signaling_service_ios`](../webtrit_signaling_service_ios/README.md)                               | iOS implementation                                        |
