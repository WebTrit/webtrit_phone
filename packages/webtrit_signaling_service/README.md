# webtrit_signaling_service

A Flutter plugin that runs the WebSocket signaling connection in a dedicated Android foreground
service so it survives app backgrounding, process death, and device reboot. The main isolate
receives a live event stream and can send requests without opening a second WebSocket connection.

**Android** runs `WebtritSignalingClient` inside `SignalingForegroundService`. Events are
forwarded to the main isolate through `IsolateNameServer` (pure Dart ports — no extra socket).
The service is restarted on boot by `SignalingBootReceiver`.

**iOS** runs `WebtritSignalingClient` directly in the main isolate via `SignalingModule`.
There are no persistent background services on iOS.

Both platforms expose the same Dart API: start the service, subscribe to events, send requests,
and dispose — without writing platform-specific code in your app.

---

## Package structure

This is a federated plugin. Each package has its own README.

| Package | Description |
| --- | --- |
| [`webtrit_signaling_service`](webtrit_signaling_service/README.md) | Public API — aggregates the platform implementations |
| [`webtrit_signaling_service_platform_interface`](webtrit_signaling_service_platform_interface/README.md) | Shared Dart interface and models |
| [`webtrit_signaling_service_android`](webtrit_signaling_service_android/README.md) | Android implementation (foreground service + IsolateNameServer hub) |
| [`webtrit_signaling_service_ios`](webtrit_signaling_service_ios/README.md) | iOS implementation (direct main-isolate `SignalingModule`) |

---

## Platform support

| Platform | Minimum version |
| --- | --- |
| Android | API 26 (Android 8.0) |
| iOS | iOS 12 |

---

## Installation

```yaml
dependencies:
  webtrit_signaling_service: ^<version>
```

---

## Architecture (Android)

The connection always runs in the **service isolate** inside `SignalingForegroundService`.
The main isolate (and any push isolate) connects to the hub via `IsolateNameServer` — no
second WebSocket is ever opened.

```
+-----------------------------------------------------------------------------+
|  Android OS process                                                         |
|                                                                             |
|  +------------------------------+     +----------------------------------+  |
|  |  Main isolate                |     |  Service isolate                 |  |
|  |  (Activity / Flutter UI)     |     |  (SignalingForegroundService)    |  |
|  |                              |     |                                  |  |
|  |  WebtritSignalingServiceAndroid     |  SignalingForegroundIsolateManager  |
|  |  +- SignalingHubModule       |     |  +- SignalingModule              |  |
|  |       +- events stream  <---------IsolateNameServer- WebtritSigClient |  |
|  |                              |     |                   WebSocket      |  |
|  |  start() / attach()  ------->|---->|                     |            |  |
|  |  execute()           ------->|---->|                  server          |  |
|  +------------------------------+     +----------------------------------+  |
|                                                                             |
|  +------------------------------+                                           |
|  |  Push isolate (optional)     |                                           |
|  |  +- SignalingHubModule  <---------IsolateNameServer (same port)          |
|  |     start(pushBound)  ------>|----> starts service if not running        |
|  +------------------------------+                                           |
+-----------------------------------------------------------------------------+
```

---

## Service modes

The two modes share **the same foreground service and hub architecture**. The only difference
is **how long the service lives** and **who starts it**.

### Mode comparison

```
                    +---------------------+------------------------------+
                    |   persistent        |   pushBound                  |
+-------------------+---------------------+------------------------------+
| Who starts        | app (main isolate)  | push isolate (FCM callback)  |
| service           | via start()         | via start(..., pushBound)    |
+-------------------+---------------------+------------------------------+
| App close         | service keeps       | onTaskRemoved stops service  |
| (swipe away)      | running             | automatically                |
+-------------------+---------------------+------------------------------+
| Device reboot     | SignalingBootRecv   | -- (service was already dead)|
|                   | restarts service    |                              |
+-------------------+---------------------+------------------------------+
| Incoming call     | WebSocket always    | server sends FCM push when   |
| delivery          | open -> direct event| socket is gone               |
+-------------------+---------------------+------------------------------+
| onStartCommand    | START_STICKY        | START_NOT_STICKY             |
+-------------------+---------------------+------------------------------+
| Foreground        | always visible      | visible only during call     |
| notification      |                     |                              |
+-------------------+---------------------+------------------------------+
```

---

### `persistent` mode — full lifecycle

```
 App launch
    |
    v
 start(config)                            +---------------------------------+
    |  Pigeon -> startService(persistent) |  SignalingForegroundService     |
    +------------------------------------>|  SignalingModule.connect()       |
                                          |  WebSocket -----------> server  |
 App goes to background                   |                                 |
    |                                     |  service keeps running  <-------+
    v                                     |  (START_STICKY)
 service keeps running                    |
                                          |
 Device reboots                           |
    |                                     |
    v                                     |
 SignalingBootReceiver fires              |
    +- startService(persistent) --------->|  service restarts, reconnects
                                          |
 Activity opens again                     |
    |                                     |
    v                                     |
 attach()  ---- polls IsolateNameServer --+--> hub port found
    |                                     |        |
    +- SignalingHubModule subscribes <--------------+
         session buffer replayed to events stream
         UI immediately in sync                    |
                                                   |
 Activity closes (swipe away)                      |
    |                                              |
    +- service keeps running  <--------------------+
         incoming calls still dispatched to app callback

 dispose() called
    +- modules disposed, event controller closed
       (Kotlin manages service stop)
```

---

### `pushBound` mode — full lifecycle

```
 App is closed (no service running)
    |
    v
 FCM push arrives
    |
    v
 Push isolate wakes up
    |
    v
 start(config, mode: pushBound)           +---------------------------------+
    |  Pigeon -> startService(pushBound)  |  SignalingForegroundService     |
    +------------------------------------>|  SignalingModule.connect()       |
                                          |  WebSocket -----------> server  |
                                          |                                 |
                                          |  IncomingCallEvent arrives      |
                                          |  -> _dispatchIncomingCall()     |
                                          |  -> app callback (callkeep)     |
                                          |  -> system call UI shown        |
                                          |  (START_NOT_STICKY)             |
 User opens app (Activity creates)        |                                 |
    |                                     |                                 |
    v                                     |                                 |
 attach()  ---- polls IsolateNameServer --+--> hub port found               |
    |                                     |        |                        |
    +- SignalingHubModule subscribes <-----------+-+                        |
         session buffer replayed                 |                          |
         (Connecting -> Connected -> Handshake -> call event)               |
         UI immediately in sync                                             |
                                                                            |
 User closes app (swipes away)                                              |
    |                                                                       |
    v                                                                       |
 onTaskRemoved fires                                                        |
    +- service.stopSelf() -----------------------------------------------+-+
         WebSocket closed, notification dismissed
         server sees disconnect -> sends FCM push for next call
```

---

## How Activity attaches to the service

`attach()` is the mechanism by which any isolate (main or push) connects to the already-running
hub. It does **not** start a new service and does **not** open a new WebSocket.

```
 WebtritSignalingServiceAndroid.attach()
    |
    |  polls IsolateNameServer every 100 ms
    |  waiting for hub SendPort to appear
    |
    v  port found (hub is ready)
 SignalingHubClient.tryConnect(subscriberId)
    |
    +- step 1: ackFuture = client.awaitAck()   <- register Completer FIRST
    |                                             (before ack can arrive)
    +- step 2: client.start()                  <- sends {cmd:'sub'} to hub
    |                                             hub receives 'sub'
    |                                             hub sends: sub-ack
    |                                             hub replays session buffer
    +- step 3: await ackFuture                 <- now wait; ack arrives
                    |                             because start() already fired
                    v
             SignalingHubModule wraps client
                    |
                    +- replays session buffer synchronously to events stream
                    |  (SignalingConnecting ... SignalingConnected ... HandshakeReceived)
                    |
                    +- all future events forwarded from hub in real time

 Note: awaitAck() MUST be called before start().
       Awaiting the future before start() always times out --
       start() is what sends 'sub', which triggers the ack.
```

---

## Callkeep integration

The signaling service is callkeep-agnostic — it delivers raw `SignalingModuleEvent`s and does
not know about native call UI. The app bridges the two by registering a top-level Dart callback
via `setIncomingCallHandler(callback)`. The callback receives `IncomingCallEvent` and is
responsible for triggering the system call notification via callkeep.

### persistent mode — incoming call while app is closed

```
  Server                Service isolate               App callback         Callkeep
  ------                ---------------               ------------         --------
  IncomingCallEvent
  (via WebSocket)
       |
       v
  SignalingModule
  onEvent callback
       |
       v
  SignalingForegroundIsolateManager
  _dispatchIncomingCall()
       |
       +- PluginUtilities.getCallbackFromHandle(incomingCallHandlerHandle)
       |
       v
  onSignalingBackgroundIncomingCall(event)          <- @pragma('vm:entry-point')
  [runs in service isolate]
       |
       v
  callkeep.reportNewIncomingCall(                   <- system call UI
    callId, handle, displayName, hasVideo)               |
                                                         v
                                                    system notification
                                                    ringtone + lock screen
                                                    user taps Answer
                                                         |
                                                         v
                                                    Activity creates
                                                    main isolate: attach()
                                                    CallBloc receives events
```

### pushBound mode — incoming call via FCM push

```
  Server                FCM                Push isolate              Callkeep
  ------                ---                ------------              --------
  sees WebSocket         FCM push
  disconnected           arrives
  sends push               |
                           v
                      push isolate wakes
                      start(config, pushBound)
                           |
                           v
                      SignalingForegroundService starts
                      WebSocket reconnects -> server
                           |
                      IncomingCallEvent arrives
                           |
                           v
                      _dispatchIncomingCall()
                           |
                           v
                      onSignalingBackgroundIncomingCall(event)
                           |
                           +------------------------------> callkeep.reportNewIncomingCall()
                                                                    |
                                                                    v
                                                               system notification
                                                               user taps Answer
                                                                    |
                                                                    v
                                                               Activity creates
                                                               attach()  <-- main isolate
                                                               CallBloc receives full
                                                               session buffer (call event
                                                               replayed immediately)
```

### Callback registration

```dart
// top-level function, annotated to survive tree-shaking
@pragma('vm:entry-point')
Future<void> onSignalingBackgroundIncomingCall(IncomingCallEvent event) async {
  await callkeep.reportNewIncomingCall(
    event.callId,
    CallkeepHandle.number(event.caller),
    displayName: event.callerDisplayName,
    hasVideo: JsepValue.fromOptional(event.jsep)?.hasVideo ?? false,
  );
}

// register once per session, before start()
if (Platform.isAndroid) {
  await service.setIncomingCallHandler(onSignalingBackgroundIncomingCall);
}
```

Key constraints:

- Must be a **top-level** function with `@pragma('vm:entry-point')` — class methods will not work.
- The plugin resolves the raw handle internally via `PluginUtilities.getCallbackHandle` and persists it to `SharedPreferences`; the background isolate reads it at each sync.
- On iOS `setIncomingCallHandler` is a no-op — callkeep integration uses PushKit directly.

---

## Quick start

### Persistent mode (default)

```dart
final service = WebtritSignalingService();

// Register background incoming-call handler (Android only, before start).
if (Platform.isAndroid) {
  await service.setIncomingCallHandler(onSignalingBackgroundIncomingCall);
}

// Subscribe before start() -- session buffer replays to late subscribers.
service.events.listen((event) {
  switch (event) {
    case SignalingConnected():
      print('connected');
    case SignalingHandshakeReceived(:final handshake):
      print('registered: ${handshake.registration.status}');
    case SignalingProtocolEvent(:final event):
      print('protocol event: ${event.runtimeType}');
    case SignalingDisconnected(:final code, :final knownCode):
      print('disconnected code=$code known=$knownCode');
    default:
      break;
  }
});

await service.start(SignalingServiceConfig(
  coreUrl: 'wss://demo.webtrit.com',
  tenantId: 'default',
  token: '<auth-token>',
));
```

### Push-initiated mode

```dart
// In the push isolate / background entry point:
await service.start(config, mode: SignalingServiceMode.pushBound);

// In the main Activity, when the user opens the app:
await service.attach(); // connects to the already-running hub
```

### Switch mode at runtime

```dart
// Promote from pushBound to persistent after the user explicitly opens the app:
await service.updateMode(SignalingServiceMode.persistent);
// WebSocket connection is NOT restarted -- only the onTaskRemoved behaviour changes.
```

### Send a request

```dart
await service.execute(HangupRequest(
  transaction: 'tx-1',
  line: 1,
  callId: 'call-abc',
));
```

### Stop the service

```dart
await service.dispose();
```

---

## API reference

### `WebtritSignalingService`

| Method / property | Description |
| --- | --- |
| `events` | Broadcast `Stream<SignalingModuleEvent>` |
| `start(config, {mode})` | Starts the platform service; `mode` defaults to `SignalingServiceMode.persistent` |
| `attach()` | Connects to an already-running hub without starting a new service |
| `execute(request)` | Sends a `Request` via the active connection; throws `StateError` when not connected |
| `updateMode(mode)` | Switches lifecycle mode at runtime without restarting the WebSocket |
| `setIncomingCallHandler(callback)` | Registers app-side background incoming-call callback (Android only; no-op on iOS) |
| `dispose()` | Stops the service and releases all resources |

### `SignalingServiceMode`

| Value | Behaviour |
| --- | --- |
| `persistent` | Service runs indefinitely; survives app close; restarted on boot |
| `pushBound` | Service stops when the Activity is removed (`onTaskRemoved`); suited for push-initiated calls |

### `SignalingServiceConfig`

| Field | Type | Description |
| --- | --- | --- |
| `coreUrl` | `String` | Server base URL — `https://` and `http://` are accepted and converted to `wss://` / `ws://` |
| `tenantId` | `String` | WebTrit tenant identifier |
| `token` | `String` | Auth token |
| `trustedCertificates` | `TrustedCertificates` | Custom CA certificates; defaults to system trust |

### `SignalingModuleEvent` (sealed)

| Event | Key fields | When it fires |
| --- | --- | --- |
| `SignalingConnecting` | — | WebSocket dial started |
| `SignalingConnected` | — | TCP + WebSocket handshake complete |
| `SignalingConnectionFailed` | `error`, `isRepeated`, `recommendedReconnectDelay` | Connection attempt failed |
| `SignalingDisconnecting` | — | Graceful disconnect initiated |
| `SignalingDisconnected` | `code?`, `reason?`, `knownCode`, `recommendedReconnectDelay?` | Socket closed |
| `SignalingHandshakeReceived` | `handshake` (`StateHandshake`) | Server sent initial state |
| `SignalingProtocolEvent` | `event` (`Event`) | Any protocol event (register, call, ICE, ...) |

---

## Android background service

The Android implementation runs `WebtritSignalingClient` inside `SignalingForegroundService`
(`foregroundServiceType="remoteMessaging"`), which holds a `WAKE_LOCK` and survives app
backgrounding. Events are bridged to the main isolate via `IsolateNameServer` — no second
WebSocket is opened. The service is automatically restarted after device reboot or app reinstall
via `SignalingBootReceiver` (`BOOT_COMPLETED`, `LOCKED_BOOT_COMPLETED`, `MY_PACKAGE_REPLACED`).

Required `AndroidManifest.xml` permissions (declared by the plugin, merged automatically):

```xml
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_REMOTE_MESSAGING" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

Your app manifest only needs `INTERNET`.

---

## Session buffer and late subscribers

Both `SignalingModule` (service isolate) and `SignalingHubModule` (main isolate) maintain an
internal session buffer — the ordered list of events since the last `SignalingConnecting`. Any
new subscriber receives this buffer synchronously on `.listen()`, making it safe to subscribe
after `start()` or `attach()` has already returned. The buffer is cleared on each reconnect so
stale events from a previous session are never replayed.

---

## Integration tests

Located in
[`webtrit_signaling_service_android/test/integration/`](webtrit_signaling_service_android/test/integration/).

| Test file | What it covers |
| --- | --- |
| `hub_client_integration_test.dart` | Hub registration, subscribe/ack, event broadcast, session buffer replay, execute routing |
| `bloc_flow_integration_test.dart` | Positive API flows, BLoC consumer patterns, `SignalingForegroundIsolateManager` lifecycle |
| `stress_integration_test.dart` | Event throughput (200 events, 5 clients), concurrent clients, rapid lifecycle cycles |
| `attach_pattern_integration_test.dart` | `attach()` pattern: session buffer replay, live events, execute routing, push+main coexistence, `pushBound`/`persistent` lifecycle cycles |

Run on a connected device:

```bash
cd webtrit_signaling_service_android
flutter test integration_test/<test_file>.dart --device-id <device-id>
```

---

## Example app

[`webtrit_signaling_service/example/`](webtrit_signaling_service/example/) demonstrates
start/stop, connection status, handshake info, and a live event log.

```bash
cd webtrit_signaling_service/example
flutter run -d <device-id>
```

---

## License

[MIT](LICENSE)
