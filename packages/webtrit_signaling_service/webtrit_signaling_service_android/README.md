# webtrit_signaling_service_android

Android implementation of [`webtrit_signaling_service`](../webtrit_signaling_service/README.md).
Runs the WebSocket signaling connection inside an Android foreground service and bridges events
back to the main isolate via `IsolateNameServer` — without opening a second WebSocket.

---

## Architecture

The implementation spans **two Dart isolates** within the same OS process:

| Isolate | Key component | Role |
| --- | --- | --- |
| Main | `WebtritSignalingServiceAndroid` | Plugin entry point; polls hub port; exposes `events` stream |
| Background (service) | `SignalingForegroundIsolateManager` | Owns `SignalingModule` + `SignalingHub`; runs in `SignalingForegroundService` |

```
Main isolate                              Background (service) isolate
──────────────────────────────────────    ──────────────────────────────────────────
WebtritSignalingServiceAndroid
  │  Pigeon (MethodChannel)               signalingServiceCallbackDispatcher()  ← @pragma('vm:entry-point')
  ├──► PSignalingServiceHostApi ──────►     └─ PSignalingServiceFlutterApi.setUp
  │    startService / stopService
  │                                        onSignalingServiceSync(status)  ← @pragma('vm:entry-point')
  │                                          └─ SignalingForegroundIsolateManager
  │                                               ├─ SignalingModule  (WebtritSignalingClient)
  │                                               └─ SignalingHub     (IsolateNameServer port)
  │
  │  IsolateNameServer (SendPort)
  └──► SignalingHubClient.tryConnect()
         └─ SignalingHubModule
              └─ events  Stream<SignalingModuleEvent>
```

---

## Key classes

### `WebtritSignalingServiceAndroid` (plugin entry point)

Registered via `WebtritSignalingServiceAndroid.registerWith()` as `SignalingServicePlatform.instance`.

| Method | Behaviour |
| --- | --- |
| `start(config, {mode})` | Obtains Dart callback handles via `PluginUtilities`, calls `initializeServiceCallback` + `startService(mode)` via Pigeon, then polls `IsolateNameServer` until the hub port appears (up to 200 × 50 ms ≈ 10 s) |
| `attach()` | Connects to an already-running hub without starting a new service; polls `IsolateNameServer` the same way as `start()` |
| `execute(request)` | Delegates to `SignalingHubModule.execute`; throws `StateError` when not connected |
| `dispose()` | Disposes hub module, calls `stopService`, closes events controller |

### `SignalingModule`

Manages a single `WebtritSignalingClient` WebSocket lifecycle and emits typed `SignalingModuleEvent`s.

- `connect()` fires `unawaited(_connectAsync())` — non-blocking.
- `events` getter replays the current session buffer synchronously to each new subscriber.
- Session buffer cleared on each `connect()` so reconnects deliver only the new session's events.
- Repeated identical connect errors set `isRepeated = true` on `SignalingConnectionFailed`.
- `coreUrl` scheme (`https`/`http`) is transparently converted to `wss`/`ws`.

### `SignalingHub`

Runs in the background isolate. Wraps `SignalingModule` and forwards encoded events to all
subscriber `SendPort`s registered via `IsolateNameServer`.

Hub wire protocol (Map messages, subscriber → hub):

| Command | Required fields | Description |
| --- | --- | --- |
| `sub` | `id`, `port` | Subscribe; hub replies with sub-ack, then replays session buffer |
| `unsub` | `id` | Unsubscribe |
| `exec` | `id`, `corr`, `req` | Execute request; hub replies with `[kExecuteResult, corr, error?]` |

Session buffer on the hub mirrors the one in `SignalingModule` — cleared on `SignalingConnecting`.

### `SignalingHubClient`

Runs in any isolate (main or push). Connects to the hub via `IsolateNameServer`.

```dart
// Correct sequence:
//   1. awaitAck()  — registers the internal Completer BEFORE the ack can arrive
//   2. start()     — sends 'sub' to the hub, which triggers the sub-ack reply
//   3. await       — now wait; the ack arrives because start() was already called
final client = SignalingHubClient.tryConnect('my_consumer');
if (client != null) {
  final ackFuture = client.awaitAck(timeout: Duration(milliseconds: 500));
  client.start(); // sends 'sub' → hub replies with sub-ack
  if (await ackFuture) {
    // use client
  } else {
    await client.dispose(); // stale port — hub did not respond
  }
}
```

`awaitAck` must be called to obtain the Future BEFORE `start()` is called. `start()` sends
the `sub` command that triggers the hub's sub-ack. Awaiting the future before calling
`start()` would always time out because no `sub` has been sent yet.

### `SignalingHubModule`

`SignalingModule` implementation backed by a `SignalingHubClient`. Used by the main
isolate when the hub is already running in the foreground service.

- `connect()` and `disconnect()` are **no-ops** — the hub owns the connection lifecycle.
- Maintains its own session buffer for late subscribers to `events`.
- Tracks `isConnected` via `SignalingConnected` / `SignalingDisconnected` / `SignalingConnectionFailed`.

### Background isolate entry points

Both functions must be annotated `@pragma('vm:entry-point')` to survive tree-shaking:

| Function | Role |
| --- | --- |
| `signalingServiceCallbackDispatcher` | Step 1 — initialises Flutter bindings; registers `PSignalingServiceFlutterApi` handler |
| `onSignalingServiceSync(status)` | Step 2 — creates `SignalingForegroundIsolateManager` on first `enabled=true`; calls `handleStatus` on every sync |

### `SignalingForegroundIsolateManager`

Owns `SignalingModule` + `SignalingHub` inside the background isolate.
`handleStatus(enabled: true)` → `_start()` (idempotent).
`handleStatus(enabled: false)` → `_stop()` (disposes hub then module in order).

---

## Pigeon API (`pigeons/signaling.messages.dart`)

Events never cross via Pigeon — only lifecycle control does.

```
PSignalingServiceHostApi  (Dart → Kotlin)
  initializeServiceCallback(dispatcherHandle, onSyncHandle)
  saveConnectionConfig(coreUrl, tenantId, token)
  saveIncomingCallHandler(callbackHandle)   ← persists raw Dart callback handle
  configureService(notificationTitle, notificationDescription)
  startService(mode: PSignalingServiceMode)
  stopService()
  notifyIsolateReady()                      ← called by background isolate; Kotlin responds with synchronizeIsolate()

PSignalingServiceFlutterApi  (Kotlin → Dart)
  onSynchronize(PSignalingServiceStatus)

PSignalingServiceStatus
  enabled:                  bool
  coreUrl:                  String
  tenantId:                 String
  token:                    String
  incomingCallHandlerHandle: int   ← 0 = no handler registered

PSignalingServiceMode  (enum)
  persistent   — index 0; service survives app close and device reboot
  pushBound    — index 1; service stops on onTaskRemoved
```

`Messages.g.kt` and `messages.g.dart` are generated by Pigeon — **do not edit manually**.
Regenerate with:

```bash
dart run pigeon --input pigeons/signaling.messages.dart
```

Commit both the input file and all generated outputs together.

---

## Android native (`android/src/main/kotlin/`)

| File | Responsibility |
| --- | --- |
| `WebtritSignalingServicePlugin.kt` | `FlutterPlugin` entry point; hosts `PSignalingServiceHostApi`; manages service lifecycle; saves mode via `StorageDelegate` |
| `SignalingForegroundService.kt` | Android `Service`; manages foreground notification; creates `FlutterEngineHelper`; stops on `onTaskRemoved` when mode is `pushBound` |
| `FlutterEngineHelper.kt` | Spawns background `FlutterEngine`; calls `signalingServiceCallbackDispatcher`; fires `onSynchronize` |
| `SignalingBootReceiver.kt` | `BroadcastReceiver` — restarts service after `BOOT_COMPLETED`, `LOCKED_BOOT_COMPLETED`, `MY_PACKAGE_REPLACED` |
| `StorageDelegate.kt` | Persists `callbackDispatcherHandle`, connection params, and service mode to `SharedPreferences` |

---

## Integration tests

Located in [`test/integration/`](test/integration/). Run on a physical device or emulator.

| Test file | What it covers |
| --- | --- |
| `hub_client_integration_test.dart` | Hub registration, subscribe/ack handshake, event broadcast, session buffer replay, execute routing, pending execute on dispose |
| `bloc_flow_integration_test.dart` | Positive API flows, BLoC consumer patterns (`_BlocSimulator`), `SignalingForegroundIsolateManager` start/stop/reconnect |
| `stress_integration_test.dart` | 200-event throughput, 5-client fan-out, concurrent client subscribe, rapid lifecycle cycles, concurrent execute |
| `attach_pattern_integration_test.dart` | `attach()` pattern: session buffer replay, live events, execute routing, push+main coexistence, `pushBound`/`persistent` lifecycle cycles |

```bash
flutter test test/integration/<test_file>.dart --device-id <device-id>
```

---

## Build & lint

```bash
flutter pub get
flutter analyze lib test
dart format --line-length 120 --set-exit-if-changed lib test
```

---

## Key invariants

- `signalingServiceCallbackDispatcher` and `onSignalingServiceSync` **must** carry
  `@pragma('vm:entry-point')` — remove either annotation and the background isolate will not start.
- `awaitAck()` must be called before `start()` on `SignalingHubClient`.
- Never call `SignalingHubModule.connect()` / `disconnect()` — they are no-ops by design; the hub
  owns the WebSocket lifecycle.
- Do not edit `messages.g.dart` or `Messages.g.kt` — regenerate via Pigeon.
- `attach()` does not start a new service — it only connects to an already-running hub. Call it
  only after a push notification has started the service in `pushBound` mode.
- In `pushBound` mode the service stops automatically on `onTaskRemoved`; in `persistent` mode it
  runs until `dispose()` is called explicitly.

---

## Related packages

| Package | Description |
| --- | --- |
| [`webtrit_signaling_service_platform_interface`](../webtrit_signaling_service_platform_interface/README.md) | Shared interface and models |
| [`webtrit_signaling_service`](../webtrit_signaling_service/README.md) | Public API aggregator |
| [`webtrit_signaling_service_ios`](../webtrit_signaling_service_ios/README.md) | iOS implementation |
