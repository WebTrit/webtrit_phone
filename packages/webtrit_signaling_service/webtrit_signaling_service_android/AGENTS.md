# webtrit_signaling_service_android

Android implementation of `webtrit_signaling_service`.
Runs the WebSocket connection inside an Android foreground service so it survives
when the app is backgrounded or killed, and bridges it back to the main isolate
via `IsolateNameServer` (pure Dart ports — no extra WebSocket).

The package does **not** depend on `webtrit_signaling` directly. The app provides a
`SignalingModuleFactory` via `setModuleFactory()` — the background isolate calls it
to create a `SignalingModuleInterface`.

## Architecture

```
Main isolate                         Background (service) isolate
─────────────────────────────────    ──────────────────────────────────────
WebtritSignalingServiceAndroid        signalingServiceCallbackDispatcher()
  │                                     └─ PSignalingServiceFlutterApi.setUp
  │  Pigeon (MethodChannel)          onSignalingServiceSync(status)
  ├──► PSignalingServiceHostApi ──►    └─ SignalingForegroundIsolateManager
  │    startService / stopService          ├─ SignalingModuleInterface (via factory)
  │    saveIncomingCallHandler             ├─ SignalingHub     (IsolateNameServer)
  │    saveModuleFactory                   └─ _dispatchIncomingCall()
  │                                               └─ app callback (IncomingCallEvent)
  │  IsolateNameServer (SendPort)
  └──► SignalingHubClient
         └─ SignalingHubModule
              └─ events (Stream<SignalingModuleEvent>)
```

## Key Classes

### `WebtritSignalingServiceAndroid` (plugin entry point)

Registered via `registerWith()` as `SignalingServicePlatform.instance`.

| Method | Behaviour |
|--------|-----------|
| `setModuleFactory(factory)` | Resolves the raw handle via `PluginUtilities.getCallbackHandle(factory)`, persists it via `PSignalingServiceHostApi.saveModuleFactory` → `StorageDelegate` → `SharedPreferences`. The background isolate reads `PSignalingServiceStatus.moduleFactoryHandle` at each sync and resolves the factory via `PluginUtilities.getCallbackFromHandle`. |
| `start(config, {mode})` | Obtains Dart callback handles, calls `initializeServiceCallback` + `startService(mode)` via Pigeon, removes any stale `kSignalingHubPortName` entry from `IsolateNameServer`, then polls until the hub port appears. The effective mode is taken from `_currentMode` (last explicit mode), not the parameter, so reconnect calls never revert a user-selected `updateMode` change. |
| `attach()` | Connects to an already-running hub without starting a new service; polls `IsolateNameServer` the same way as `start()`. |
| `execute(request)` | Delegates to the hub module. Throws `StateError` when not connected. |
| `updateMode(mode)` | Saves new mode to `_currentMode`, calls `_startHubMode(config, mode)`. Both modes use the hub/foreground service — only the Kotlin-side lifecycle flag changes (whether `onTaskRemoved` stops the service). The WebSocket connection is preserved across the mode switch. |
| `setIncomingCallHandler(callback)` | Resolves the raw handle via `PluginUtilities.getCallbackHandle(callback)`, persists it via `PSignalingServiceHostApi.saveIncomingCallHandler` → `StorageDelegate` → `SharedPreferences`. Logs a warning if the handle cannot be resolved (function not top-level or missing `@pragma`). The background isolate reads the handle from `PSignalingServiceStatus.incomingCallHandlerHandle` at each sync. |
| `dispose()` | Cancels hub-init loop, disposes both modules, resets `_currentMode`. Does **not** close `_eventsController` — closing it would silently terminate active subscribers (e.g. `CallBloc`) via `onDone`; leaving it open preserves subscriptions across `dispose`/`start` cycles. Does **not** call `stopService()` — the Android service lifecycle is managed by Kotlin. |

Hub init (`_hubInitLoop`) polls indefinitely with a 100 ms retry delay until the hub port appears in `IsolateNameServer` or `dispose()` cancels the loop.

### `SignalingHub`

Runs in the background isolate. Wraps `SignalingModuleInterface` (created by the app factory)
and forwards events to all subscriber `SendPort`s via `IsolateNameServer`.

Hub wire protocol (Map messages, subscriber → hub):

| Command | Fields | Description |
|---------|--------|-------------|
| `sub`   | `id`, `port` | Subscribe; hub replies with sub-ack then replays session buffer |
| `unsub` | `id` | Unsubscribe |
| `exec`  | `id`, `corr`, `req` | Execute request; hub replies with `[_kExecuteResult, corr, error?]` |

Session buffer on the hub side mirrors the one in the module — cleared on `SignalingConnecting`.

### `SignalingHubClient`

Runs in any isolate (main or push). Connects to the hub via `IsolateNameServer`.

```dart
// Correct subscription sequence:
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

`awaitAck` must be called before `start()` — NOT awaited before `start()`. Getting the
future first ensures the `Completer` is in place before the hub's sub-ack can arrive.
Awaiting the future before calling `start()` would always time out because `start()` is
what sends the `sub` command that triggers the ack.

### `SignalingHubModule`

`SignalingModuleInterface` implementation backed by a `SignalingHubClient`.
Used by the main isolate when the hub is already running in the foreground service.

- `connect()` / `disconnect()` are **no-ops** — the hub owns the connection lifecycle.
- Maintains its own `_sessionBuffer` for late subscribers to the `events` stream.
- `isConnected` tracks `SignalingConnected` / `SignalingDisconnected` / `SignalingConnectionFailed`.

### Background isolate entry points

Both functions **must** be annotated `@pragma('vm:entry-point')` to survive tree-shaking:

| Function | Role |
|----------|------|
| `signalingServiceCallbackDispatcher` | Step 1 — initialises Flutter bindings, registers `PSignalingServiceFlutterApi` handler, then calls `PSignalingServiceHostApi().notifyIsolateReady()` so Kotlin knows the isolate is ready to receive `onSynchronize` calls |
| `onSignalingServiceSync(status)` | Step 2 — if `enabled=true` and credentials changed (re-login), disposes the existing manager and creates a fresh one; otherwise creates on first call; delegates to `handleStatus` on every sync |

### `SignalingForegroundIsolateManager`

Owns `SignalingModuleInterface` (created via `moduleFactory`) + `SignalingHub` inside the background isolate.
`handleStatus(enabled: true)` → `_start()` (idempotent).
`handleStatus(enabled: false)` → `_stop()` (disposes hub then module).

**Module creation in `_start()`:**

```dart
final factory = PluginUtilities.getCallbackFromHandle(
  CallbackHandle.fromRawHandle(moduleFactoryHandle),
) as SignalingModuleFactory;
_module = factory(config);
```

**Incoming call dispatch** (`_dispatchIncomingCall`):

When a `SignalingProtocolEvent` carrying an `IncomingCallEvent` arrives and
`incomingCallHandlerHandle != 0`, the manager:

1. Resolves the registered Dart callback via `PluginUtilities.getCallbackFromHandle`.
2. Invokes it with `Function.apply(callback, [event])` — works for both sync and async callbacks.
3. Async errors are caught and logged; sync throws are caught and logged.

If `incomingCallHandlerHandle == 0` (no handler registered), a warning is logged and the
event is silently forwarded only to hub subscribers (main isolate, if connected).

## Pigeon API (`pigeons/signaling.messages.dart`)

Events never cross via Pigeon — only lifecycle control does.

```
PSignalingServiceHostApi (Dart → Kotlin)
  initializeServiceCallback(callbackDispatcher, onSync)
  saveConnectionConfig(coreUrl, tenantId, token)
  saveModuleFactory(callbackHandle)         ← persists raw SignalingModuleFactory handle
  saveIncomingCallHandler(callbackHandle)   ← persists raw incoming call handler handle
  configureService(notificationTitle, notificationDescription)
  startService(mode: PSignalingServiceMode)
  stopService()
  notifyIsolateReady()                      ← called by background isolate after setUp; Kotlin responds with synchronizeIsolate()

PSignalingServiceFlutterApi (Kotlin → Dart)
  onSynchronize(PSignalingServiceStatus)

PSignalingServiceStatus
  enabled: bool
  coreUrl: String
  tenantId: String
  token: String
  moduleFactoryHandle: int              ← 0 = factory not registered
  incomingCallHandlerHandle: int        ← 0 = no handler registered

PSignalingServiceMode (enum)
  persistent  — index 0; service survives app close and device reboot
  pushBound   — index 1; service stops on onTaskRemoved
```

`Messages.g.kt` / `messages.g.dart` are generated by Pigeon — **do not edit manually**.
Re-generate with:

```bash
dart run pigeon --input pigeons/signaling.messages.dart
```

## Android Native (`android/src/main/kotlin/`)

| File | Responsibility |
|------|---------------|
| `WebtritSignalingServicePlugin.kt` | `FlutterPlugin` entry point; hosts `PSignalingServiceHostApi`; creates/destroys `SignalingForegroundService`; saves callback handles and mode via `StorageDelegate` |
| `SignalingForegroundService.kt` | Android `Service`; starts/stops foreground notification (`remoteMessaging` type); creates `FlutterEngineHelper`; delivers `PSignalingServiceStatus` (including `moduleFactoryHandle` and `incomingCallHandlerHandle`) to the background isolate via `synchronizeIsolate()` which retries with linear backoff on failure; stops on `onTaskRemoved` when mode is `pushBound` |
| `FlutterEngineHelper.kt` | Spawns a background `FlutterEngine` (auto-registers all plugins), runs `signalingServiceCallbackDispatcher`, fires `onSynchronize` to the background isolate |
| `SignalingBootReceiver.kt` | `BroadcastReceiver` for `BOOT_COMPLETED` / `LOCKED_BOOT_COMPLETED` / `MY_PACKAGE_REPLACED` — restarts service after reboot |
| `StorageDelegate.kt` | Persists `callbackDispatcherHandle`, `onSyncHandler`, connection params, service mode, `moduleFactoryHandle`, and incoming call handler handle to `SharedPreferences` |

## AndroidManifest permissions

```
FOREGROUND_SERVICE
FOREGROUND_SERVICE_REMOTE_MESSAGING   ← required for remoteMessaging service type (Android 14+)
WAKE_LOCK
RECEIVE_BOOT_COMPLETED
POST_NOTIFICATIONS
```

`foregroundServiceType="remoteMessaging"` — correct type for persistent WebSocket connections
(replaces `dataSync` which is deprecated for WebSocket use on `targetSdk >= 35` / Android 16+).

`minSdkVersion 26` — required by `startForegroundService` API.

## Session buffer timing (important for tests)

Events emitted to a broadcast stream before a listener attaches are **lost**.
`SignalingHubModule.events` replays its session buffer synchronously when a new subscriber
calls `.listen()`, making it safe for late subscribers.

Raw `SignalingHubClient.events` does **not** replay — always wrap it in
`SignalingHubModule` or attach a listener before calling `start()`.

## Commands

```bash
dart pub get
dart analyze
dart test                                                                              # unit tests only
cd ../webtrit_signaling_service/example && flutter test integration_test --device-id <device-id>  # integration tests on device
dart run pigeon --input pigeons/signaling.messages.dart     # regenerate Pigeon bindings
```

## Code Style

- Line width: 120 characters; single quotes; `lints/recommended.yaml`.
- No `freezed`; no `build_runner`.
- Kotlin: standard Android style, JVM target 17.
