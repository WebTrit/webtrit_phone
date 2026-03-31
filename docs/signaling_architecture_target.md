# Signaling Architecture

## Layer Overview

The signaling stack has three layers. Each layer knows only the one below it — never above.

```
┌─────────────────────────────────────────────────────────────┐
│  Consumers  CallBloc · PushNotificationIsolateManager       │
│             SignalingForegroundIsolateManager                │
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

**Public API:**

```dart
SignalingModule({
  required String coreUrl,
  required String tenantId,
  required String token,
  required TrustedCertificates trustedCertificates,
  required SignalingClientFactory signalingClientFactory,
})

// Per-subscriber stream. Replays all buffered events from the current
// session, then continues with live events.
Stream<SignalingModuleEvent> get events;

// null when not connected. Used by consumers to send requests
// (HangupRequest, AcceptRequest, OutgoingCallRequest, etc.)
WebtritSignalingClient? get signalingClient;

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

`connect()` clears the buffer. Each `_emit()` adds to the buffer AND the broadcast
controller. The `events` getter subscribes to the live stream first (so no future
events are missed), then synchronously replays buffered events:

```
connect() called
  → buffer.clear()
  → _connectAsync() fires

events fired: Connecting, Connected, HandshakeReceived
  → stored in _sessionBuffer
  → forwarded to _controller (live broadcast)

Late subscriber calls module.events
  → subscribes to live stream (no gap)
  → receives replay: Connecting, Connected, HandshakeReceived
  → then receives future live events normally
```

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
                                  Whether the BLoC is still alive
```

**CallBloc** — full guard chain:

```dart
void _scheduleReconnect(Duration delay, {bool force = false}) {
  _signalingClientReconnectTimer?.cancel();
  _signalingClientReconnectTimer = Timer(delay, () {
    if (isClosed)                     return; // BLoC was closed during delay
    if (!appActive && !force)         return; // app is backgrounded
    if (!connectionActive && !force)  return; // no network
    if (signalingRemains && !force)   return; // already connected (wifi→mobile)
    _signalingModule.connect();
  });
}
```

**IsolateManager** — simpler:

```dart
case SignalingDisconnected(:final recommendedReconnectDelay):
  if (enableReconnect && recommendedReconnectDelay != null && !_networkNone) {
    _signalingReconnectTimer?.cancel();
    _signalingReconnectTimer = Timer(recommendedReconnectDelay, () {
      if (_signalingModule.signalingClient == null) _signalingModule.connect();
    });
  }
```

`PushNotificationIsolateManager` uses `enableReconnect: false` — never reconnects.
`SignalingForegroundIsolateManager` uses `enableReconnect: true`.

---

## Consumers

### CallBloc (main isolate)

Subscribes in constructor. Maps `SignalingModuleEvent` to internal BLoC events:

```dart
_signalingSubscription = _signalingModule.events.listen((event) {
  switch (event) {
    case SignalingConnecting():
      add(const _SignalingClientEvent.connecting());
    case SignalingConnected():
      add(const _SignalingClientEvent.connected());
    case SignalingConnectionFailed(:final error, :final isRepeated, :final recommendedReconnectDelay):
      if (!isRepeated) submitNotification(const SignalingConnectFailedNotification());
      add(_SignalingClientEvent.failed(error));
      _scheduleReconnect(recommendedReconnectDelay);
    case SignalingDisconnecting():
      add(const _SignalingClientEvent.disconnecting());
    case SignalingDisconnected(:final code, :final reason, :final recommendedReconnectDelay):
      add(_SignalingClientEvent.disconnected(code, reason));
      if (recommendedReconnectDelay != null) _scheduleReconnect(recommendedReconnectDelay);
    case SignalingHandshakeReceived(:final handshake):
      _handleHandshakeReceived(handshake);
    case SignalingProtocolEvent(:final event):
      _handleSignalingEvent(event);
  }
});
```

### IsolateManager (background isolates)

Subscribes in `initSignaling()`. Handles only what background isolates need:

```dart
_signalingSubscription = _signalingModule.events.listen((event) {
  switch (event) {
    case SignalingHandshakeReceived(:final handshake):
      _onHandshake(handshake);       // populates _lines, _incomingCallEvents
    case SignalingProtocolEvent(:final event):
      _onProtocolEvent(event);       // IncomingCallEvent, HangupEvent, UnregisteredEvent
    case SignalingConnectionFailed(:final error, :final recommendedReconnectDelay):
      _onSignalingError(error);
      // reconnect if enabled and network is available
    case SignalingDisconnected(:final recommendedReconnectDelay):
      // reconnect if enabled, delay != null, and network is available
  }
});
```

---

## Dependency diagram

```
MainShellState.initState()
  └── SignalingModule.connect()        ← WebSocket starts here, in parallel
                                          with widget tree construction
         │
         │  Stream<SignalingModuleEvent>  (replay buffer → live events)
         │
         ├──► CallBloc                  (main isolate)
         │      subscribes in constructor
         │      commands: connect() / disconnect() / signalingClient.execute()
         │
         ├──► PushNotificationIsolateManager   (background, no reconnect)
         │      subscribes in initSignaling()
         │      commands: connect() via launchSignaling()
         │
         └──► SignalingForegroundIsolateManager (background, reconnect enabled)
                subscribes in initSignaling()
                commands: connect() via handleLifecycleStatus()


WebtritSignalingClient  ←  owned by SignalingModule  (1 instance at a time)
  callbacks: onStateHandshake · onEvent · onError · onDisconnect
  commands:  execute(Request) · disconnect()
```

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

---

## Decisions

| Question | Decision |
|---|---|
| `connect()` — Future or fire-and-forget? | **Fire-and-forget.** Returns immediately; result arrives via stream. Two channels for the same fact would be redundant. |
| Error deduplication | **`_lastConnectErrorString` in the module.** Protocol detail — avoids spamming the same error. `isRepeated: bool` added to `SignalingConnectionFailed`; consumer decides what to show. |
| `recommendedReconnectDelay` in `SignalingConnectionFailed` | **Yes.** Consistent with `SignalingDisconnected`. Consumer never hardcodes delays. |
| Replay buffer | **Manual `List` + `connect()` clear.** `rxdart` is in the project but `ReplaySubject` has no `clear()` in v0.28. A manual buffer gives full control with no external dependency. |
| Early connect (before CallBloc) | **`initState()` in `MainShellState`.** Module connects while the widget tree is built. Late subscribers get the full session history via the replay buffer. |
