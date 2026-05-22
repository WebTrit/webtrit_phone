# webtrit_signaling_service_android

Android implementation of [`webtrit_signaling_service`](../webtrit_signaling_service/README.md).

---

## Modes

`WebtritSignalingServiceAndroid` is the orchestrator. It selects the implementation based on
the mode passed to `start()` / `updateMode()`.

### persistent

The WebSocket runs inside an Android **Foreground Service** in a dedicated background isolate.
The main isolate never opens its own WebSocket -- it connects to the FGS via `IsolateNameServer`
(hub pattern). The service survives app closure and restarts after device reboot via
`SignalingBootReceiver`.

### pushBound

No FGS. The orchestrator delegates entirely to `WebtritSignalingServiceAndroidDirect`. The
WebSocket runs directly in the calling isolate, identical to iOS. The service dies when the
user swipes the app away; the next session is started by an FCM push notification.

---

## Hub protocol (persistent mode)

The background isolate owns a `SignalingHub` -- a `ReceivePort` registered in
`IsolateNameServer`. The main isolate connects to it as a subscriber and receives encoded
events over `SendPort`. No second WebSocket is ever opened.

The `HubConnectionManager` in the main isolate manages the attach/detach cycle and calls
`onServiceDead` when the hub port disappears (e.g. OS killed the FGS). The orchestrator
uses this to trigger a restart unless the service was intentionally stopped.

---

## Push-isolate handoff (pushBound mode)

Implemented in `WebtritSignalingServiceAndroidDirect`. When an FCM push arrives, a short-lived
push isolate opens a direct WebSocket. Once the user opens the app and the Activity connects,
it signals the push isolate via `IsolateNameServer` (`kPushHandoffPortName`). The push isolate
terminates early instead of waiting for the FCM 20-second timeout.

---

## Android-specific notes

- Events never cross via Pigeon -- only lifecycle control (start/stop/credentials) does.
- `_isStopped` in `WebtritSignalingServiceAndroid` prevents `_onHubServiceDead` from
  restarting the FGS after an intentional stop (logout, dispose).
- `dispose()` intentionally does not call `stopService()` -- the persistent FGS keeps running
  across Activity restarts; only an explicit user logout should stop it.
- `messages.g.dart` / `Messages.g.kt` are Pigeon-generated -- do not edit manually.

---

## Source layout

```
lib/src/
  plugin.dart              - orchestrator (WebtritSignalingServiceAndroid)
  messages.g.dart          - Pigeon generated
  mode_mapping.dart        - mode enum conversion
  constants.dart           - shared port names
  fgs/                     - persistent mode (Foreground Service)
    hub_connection_manager.dart
    hub/                   - hub protocol (SignalingHub, client, codec)
    isolate/               - background isolate lifecycle
  direct/                  - pushBound mode (direct WebSocket)
    signaling_service_android_direct.dart
```

---

## Related packages

| Package                                                                                                     | Description                                               |
|-------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------|
| [`webtrit_signaling_service_platform_interface`](../webtrit_signaling_service_platform_interface/README.md) | Shared interface and `WebtritSignalingServiceDirect` base |
| [`webtrit_signaling_service`](../webtrit_signaling_service/README.md)                                       | Public API aggregator                                     |
| [`webtrit_signaling_service_ios`](../webtrit_signaling_service_ios/README.md)                               | iOS implementation                                        |
