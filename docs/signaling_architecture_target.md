# Signaling Architecture

## Layer Overview

The signaling stack has three layers. Each layer knows only the one below it — never above.

```
┌─────────────────────────────────────────────────────────────┐
│  Consumers  CallBloc · PushNotificationIsolateManager       │
│  What they know: app lifecycle, network, active calls        │
│  What they do:   decide WHEN to reconnect, handle state      │
├─────────────────────────────────────────────────────────────┤
│  SignalingModule                                             │
│  What it knows: WebSocket protocol, disconnect codes        │
│  What it does:  owns client lifecycle, emits typed events,  │
│                 recommends reconnect delay                   │
├─────────────────────────────────────────────────────────────┤
│  WebtritSignalingClient                                      │
│  What it knows: raw WebSocket frames, JSON protocol         │
│  What it does:  connects, sends requests, fires callbacks   │
└─────────────────────────────────────────────────────────────┘
```

---

## WebtritSignalingClient — raw WebSocket adapter

Single-use object. Created via `connect()`, unusable after disconnect.

**Public API:**

```dart
// Create
static Future<WebtritSignalingClient> connect(baseUrl, tenantId, token, force)

// Register callbacks (single-use — throws if called twice)
void listen({
  required onStateHandshake,   // server sent line state snapshot
  required onEvent,            // IncomingCallEvent, HangupEvent, etc.
  required onError,            // socket / protocol error
  required onDisconnect,       // socket closed
})

// Send a request and await server acknowledgement
Future<void> execute(Request request)

// Graceful close
Future<void> disconnect([int? code, String? reason])
```

**Internals:**

- Subscribes to `WebSocketChannel.stream` internally — not exposed outside
- Routes inbound JSON to the appropriate callback
- Keepalive timer starts after `StateHandshake`; sends `KeepaliveHandshake` on each tick
- Transaction map: each `execute()` registers a `Completer` keyed by transaction ID; resolved when matching response arrives

```
WebSocket frame → _wscStreamOnData(rawJson)
                    ├── "handshake":"state"      → onStateHandshake()
                    ├── "handshake":"keepalive"  → resolves keepalive transaction
                    ├── "event":...              → onEvent()
                    ├── "response":...           → resolves request transaction
                    └── unknown                 → onError()
```

---

## SignalingModule — protocol event source

Wraps `WebtritSignalingClient` lifecycle and converts the callback API into a
broadcast stream. Knows the WebSocket protocol — nothing about the app.

**What it owns:**

- `WebtritSignalingClient` lifecycle (`connect` / `disconnect` / `dispose`)
- Disconnect code interpretation — protocol knowledge:
  - code 4441 → `Duration.zero` (fast reconnect, server evicted a duplicate session)
  - `protocolError` → `null` (do not reconnect)
  - everything else → `kSignalingClientReconnectDelay`
- Session replay buffer — late subscribers receive all events from the current session

**What it does NOT know:**

- App lifecycle (`AppLifecycleState`)
- Network availability
- Active calls or call state
- Whether reconnect should happen at all — it only provides `recommendedReconnectDelay`

**Public API (`SignalingModuleImpl` from `webtrit_signaling_service_platform_interface`):**

```dart
SignalingModuleImpl({
  required String coreUrl,
  required String tenantId,
  required String token,
  required TrustedCertificates trustedCertificates,
})

// Per-subscriber stream. Replays buffered lifecycle and handshake events
// from the current session (SignalingProtocolEvent is NOT replayed),
// then continues with live events.
Stream<SignalingModuleEvent> get events;

bool get isConnected;

// Send a request. Returns null when not connected.
Future<void>? execute(Request request);

// Fire-and-forget. Clears the session buffer. Result arrives via events.
void connect();

Future<void> disconnect();
Future<void> dispose();
```

**Event stream:**

```dart
sealed class SignalingModuleEvent {}

class SignalingConnecting       extends SignalingModuleEvent {}
class SignalingConnected        extends SignalingModuleEvent {}

class SignalingConnectionFailed extends SignalingModuleEvent {
  final Object error;
  final bool isRepeated;            // true if same error as previous attempt
  final Duration recommendedReconnectDelay;
}

class SignalingDisconnecting    extends SignalingModuleEvent {}

class SignalingDisconnected extends SignalingModuleEvent {
  final int? code;
  final String? reason;
  final SignalingDisconnectCode knownCode;
  final Duration? recommendedReconnectDelay;
  // null  → do not reconnect (protocolError)
  // zero  → reconnect immediately (code 4441)
  // 3s    → standard slow reconnect
}

class SignalingHandshakeReceived extends SignalingModuleEvent {
  final StateHandshake handshake;   // full line state snapshot from server
}

class SignalingProtocolEvent extends SignalingModuleEvent {
  final Event event;                // IncomingCallEvent, HangupEvent, etc.
}
```

**Session replay buffer:**

`connect()` clears the buffer. Each `_emit()` delegates to `SignalingEventBuffer.onEvent()`
which adds lifecycle/handshake events to the buffer and broadcasts all events live.
The `events` getter subscribes to the live stream first (so no future events are missed),
then synchronously replays buffered events:

```
connect() called
  → buffer.clear()
  → _connectAsync() fires

events fired: Connecting, Connected, HandshakeReceived → stored in buffer + live broadcast
events fired: SignalingProtocolEvent (ICE, call events) → live broadcast only, NOT buffered

Late subscriber calls module.events
  → subscribes to live stream (no gap)
  → receives replay: Connecting, Connected, HandshakeReceived
  → then receives future live events normally
```

`SignalingProtocolEvent` is intentionally excluded from the buffer — protocol events
are transient and replaying them to a late subscriber produces incorrect behaviour.

This allows `SignalingModule` to be created and connected in `initState()`,
before `CallBloc` is built. `CallBloc` receives the full session history when
it eventually subscribes.

---

## Reconnect — responsibility split

The module emits `recommendedReconnectDelay` as a protocol hint.
The consumer owns the reconnect decision because only it knows the full context.

```
Module knows:                     Consumer knows:
─────────────                     ──────────────
Which disconnect code arrived  →  Whether the app is in the foreground
What it means for the protocol →  Whether a network connection is available
How long to wait (delay hint)  →  Whether there are active calls
                                  Whether the controller is still alive
```

**`CallBloc`** delegates all reconnect scheduling and failure-notification to
`SignalingReconnectController`. The subscription only maps events to state — no reconnect
logic inline.

**`SignalingForegroundIsolateManager`** manages its own lightweight timer directly:

```dart
case SignalingConnectionFailed(:final error, :final recommendedReconnectDelay):
  _scheduleReconnect(recommendedReconnectDelay);
case SignalingDisconnected(:final recommendedReconnectDelay):
  if (recommendedReconnectDelay != null) _scheduleReconnect(recommendedReconnectDelay);
```

**`PushNotificationIsolateManager`** never reconnects — the isolate is short-lived by design.
On `SignalingConnectionFailed` it calls `_onSignalingError(error)` which releases the call and
completes the run future with an error.

---

## SignalingReconnectController

Centralises all reconnect logic and connection-failure notification decisions for `CallBloc`.
Lives in `lib/features/call/services/signaling_reconnect_controller.dart`.

**Constructor:**

```dart
SignalingReconnectController({
  required SignalingModule signalingModule,
  void Function()? onConnectionFailed,
  void Function(bool isAvailable)? onConnectionPresenceChanged,
  int notifyAfterConsecutiveFailures = 2,  // notify after this many consecutive failures
  bool reconnectEnabled = true,
})
```

**Lifecycle / connectivity notification API:**

| Method | Effect |
|--------|--------|
| `notifyAppResumed()` | `_appActive = true`, schedule fast reconnect |
| `notifyAppPaused({hasActiveCalls})` | if no active calls: `_appActive = false`, disconnect |
| `notifyForceReconnect()` | schedule fast reconnect with `force = true` |
| `notifyHasActiveCalls({hasActiveCalls})` | update `_hasActiveCalls`; disconnect if empty + backgrounded |
| `notifyNetworkAvailable()` | `_networkActive = true`, schedule fast reconnect |
| `notifyNetworkUnavailable()` | `_networkActive = false`, disconnect, emit `presence = false` |
| `dispose()` | cancel timer + cancel subscription |

**Guard chain in `_scheduleReconnect`:**

```dart
void _scheduleReconnect(Duration delay, {bool force = false}) {
  if (!_reconnectEnabled) return;
  _reconnectTimer = Timer(delay, () {
    if (_disposed)                                 return;
    if (!force && !_appActive && !_hasActiveCalls) return; // backgrounded and no active calls
    if (!force && !_networkActive)                 return; // no network
    if (!force && _module.isConnected)             return; // already connected (e.g. wifi→mobile)
    _module.connect();
  });
}
```

**Failure notification logic (`_onEvent`):**

- `SignalingConnected` → reset `_consecutiveFailures`, `_wasConnected = true`, emit `presence = true`
- `SignalingConnectionFailed` when `_wasConnected` was true → notify immediately (established session dropped), schedule reconnect
- `SignalingConnectionFailed` otherwise → increment counter; notify only when counter reaches `_notifyThreshold` (default 2), schedule reconnect
- `SignalingDisconnected` with `recommendedReconnectDelay != null` → notify immediately (unexpected drop), schedule reconnect
- `SignalingDisconnected` with `recommendedReconnectDelay == null` (intentional) → no action

---

## Consumers

### CallBloc (main isolate)

Creates `SignalingReconnectController` in the constructor and subscribes separately to map
`SignalingModuleEvent` to internal BLoC events. Reconnect scheduling and failure notifications
are fully handled by `_reconnectController`.

```dart
_reconnectController = SignalingReconnectController(
  signalingModule: signalingModule,
  onConnectionFailed: () => submitNotification(const SignalingConnectFailedNotification()),
  onConnectionPresenceChanged: (isAvailable) =>
      _logger.info('signaling presence changed: isAvailable=$isAvailable'),
);

// Translates SignalingModule events into BLoC state-transition events.
// Reconnect scheduling and notification decisions are fully handled by
// [_reconnectController] — this listener only drives [CallState] changes.
_signalingSubscription = _signalingModule.events.listen((event) {
  switch (event) {
    case SignalingConnecting():
      add(const _SignalingClientEvent.connecting());
    case SignalingConnected():
      add(const _SignalingClientEvent.connected());
    case SignalingConnectionFailed(:final error):
      add(_SignalingClientEvent.failed(error));
    case SignalingDisconnecting():
      add(const _SignalingClientEvent.disconnecting());
    case SignalingDisconnected(:final code, :final reason):
      add(_SignalingClientEvent.disconnected(code, reason));
    case SignalingHandshakeReceived(:final handshake):
      _handleHandshakeReceived(handshake);
    case SignalingProtocolEvent(:final event):
      _handleSignalingEvent(event);
  }
});
```

CallBloc-side reconnect edges (`onChange` background call-active notify, and the `onError`
catch-all / where call finalization actually happens) are documented with the rest of the
CallBloc internals in
[`features/call_arch.md`](features/call_arch.md) ->
"Signaling edges (`onChange` / `onError`)".

### IsolateManager (background isolates)

**`PushNotificationIsolateManager`** — never reconnects. Opened once per incoming push
notification, connects to signaling, handles the call, then releases.

Public API: `run(CallkeepIncomingCallMetadata? metadata) → Future<void>` / `close() → Future<void>`.

```dart
_signalingSubscription = _signalingModule.events.listen((event) {
  switch (event) {
    case SignalingConnecting():
      logger.info('Signaling: connecting');
    case SignalingConnected():
      logger.info('Signaling: connected');
    case SignalingHandshakeReceived(:final handshake):
      _onHandshake(handshake);       // populates _lines, _incomingCallEvents
    case SignalingProtocolEvent(:final event):
      _onProtocolEvent(event);       // IncomingCallEvent, HangupEvent, UnregisteredEvent
    case SignalingConnectionFailed(:final error):
      _onSignalingError(error);      // logs and releases call — never reconnects
    case SignalingDisconnected():
      logger.info('Signaling: disconnected');
  }
});
```

**`SignalingForegroundIsolateManager`** (Android background service) — manages its own
lightweight reconnect timer. Reconnects after `SignalingConnectionFailed` and unexpected
`SignalingDisconnected` while `_started == true`.

---

## Dependency diagram

```
bootstrap.dart
  └── WebtritSignalingService().setModuleFactory(createSignalingModule)
  └── WebtritSignalingService().setIncomingCallHandler(onSignalingBackgroundIncomingCall)

MainShellState.initState()
  └── WebtritSignalingService(config, mode)
         │  implements SignalingModule directly
         │  delegates events/execute/connect to platform instance
         │
         │  Stream<SignalingModuleEvent>  (replay buffer → live events)
         │
         ├──► SignalingReconnectController  (owns reconnect timer + failure notifications)
         │      fed by: CallBloc lifecycle/network event handlers
         │      drives: onConnectionFailed → submitNotification(SignalingConnectFailedNotification)
         │               onConnectionPresenceChanged → persistent UI indicator
         │
         ├──► CallBloc                  (main isolate)
         │      subscribes in constructor — pure state mapping, no reconnect logic
         │      commands: connect() / disconnect() / module.execute(request)
         │
         └──► background isolates
               PushNotificationIsolateManager — direct WebSocket (no FGS), no reconnect, run()/close() API
               SignalingForegroundIsolateManager — FGS (persistent mode only), own timer, reconnects while started


WebtritSignalingClient  ←  owned by SignalingModuleImpl  (1 instance at a time)
  callbacks: onStateHandshake · onEvent · onError · onDisconnect
  commands:  execute(Request) · disconnect()
```

---

## Push-bound handoff mechanism (Android)

When the app is in push-bound mode, two isolates may open a direct WebSocket
for the same incoming call. The plugin uses `IsolateNameServer` (process-scoped
C++ runtime, shared across all Dart VMs in the process) to let the later isolate
signal the earlier one to shut down.

**Role detection — `_handoffCallback != null`:**

The plugin does not know about "Activity" or "push isolate" as concepts.
It detects the role of each isolate purely by whether `setHandoffCallback()` was
called before `_startDirect()`:

| `_handoffCallback` | Role | Behaviour in `_startDirect()` |
|--------------------|------|-------------------------------|
| set | Push isolate | Registers `ReceivePort` under `kPushHandoffPortName` in `IsolateNameServer`; waits for a signal |
| null | Non-push isolate | On `SignalingConnected`, looks up `kPushHandoffPortName`; sends null if found |

In practice the non-push isolate is always the Activity, but the mechanism is
agnostic — any isolate that omits `setHandoffCallback()` will act as the signaller.

**Sequence:**

```
Push isolate
  setHandoffCallback(callback)        ← registers _handoffCallback
  _startDirect()
    isPushIsolate = true
    ReceivePort registered as kPushHandoffPortName in IsolateNameServer
    WebSocket opens, push isolate handles incoming call

Non-push isolate (Activity)
  _startDirect()
    isPushIsolate = false
    WebSocket opens
    SignalingConnected →
      lookupPortByName(kPushHandoffPortName) → found
      port.send(null)                 ← signals push isolate

Push isolate receives signal
  _handoffCallback()                  ← notifyActivityTookOver()
  IsolateManager completes early, push WebSocket closes
```

**Parallel path — code 4441:**

The server also sends `controllerForceAttachClose` (code 4441) to the push
isolate when it detects a duplicate session. This produces
`SignalingDisconnected(recommendedReconnectDelay: Duration.zero)`, which the
`IsolateManager` treats as an early-exit signal. Whichever path fires first
(handoff port or 4441) closes the push session.

---

## What was deleted

| What | Where |
|---|---|
| `SignalingModuleDelegate` | `signaling_module.dart` |
| `performConnect(emit, isCancelled)` | `signaling_module.dart` |
| `performDisconnect(emit, isCancelled)` | `signaling_module.dart` |
| `handleDisconnected(code, reason, emit, isCancelled)` | `signaling_module.dart` |
| `SignalingManager` | `lib/common/signaling_manager.dart` |
| `export 'signaling_manager.dart'` | `lib/common/common.dart` |
| `coreUrl`, `tenantId`, `token`, `trustedCertificates` fields | `CallBloc` |
| `_scheduleReconnect(Duration, {bool force})` inline method | `CallBloc` — extracted to `SignalingReconnectController` |
| `_signalingClientReconnectTimer` field | `CallBloc` — moved to `SignalingReconnectController` |

---

## Decisions

| Question | Decision |
|---|---|
| `connect()` — Future or fire-and-forget? | **Fire-and-forget.** Returns immediately; result arrives via stream. Two channels for the same fact would be redundant. |
| Error deduplication | **`_lastConnectErrorString` in the module.** Protocol detail — avoids spamming the same error. `isRepeated: bool` added to `SignalingConnectionFailed`; consumer decides what to show. |
| `recommendedReconnectDelay` in `SignalingConnectionFailed` | **Yes.** Consistent with `SignalingDisconnected`. Consumer never hardcodes delays. |
| Replay buffer | **Manual `List` + `connect()` clear.** `rxdart` is in the project but `ReplaySubject` has no `clear()` in v0.28. A manual buffer gives full control with no external dependency. |
| Early connect (before CallBloc) | **`initState()` in `MainShellState`.** Module connects while the widget tree is built. Late subscribers get the full session history via the replay buffer. |
| Reconnect extraction | **`SignalingReconnectController`.** All reconnect scheduling, failure counting, and connection-presence tracking extracted from `CallBloc` into a dedicated class. `CallBloc` subscription is pure state mapping with no reconnect logic inline. |
