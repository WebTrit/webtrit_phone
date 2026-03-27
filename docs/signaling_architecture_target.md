# Target Signaling Architecture

## Context and Motivation

The codebase had two parallel classes performing the same role — managing `WebtritSignalingClient`:

| Class | Where used | Problem |
|---|---|---|
| `SignalingModule` | `CallBloc` (main isolate) | Tightly coupled to `CallState` and `emit` |
| `SignalingManager` | `IsolateManager` (background isolates) | Duplicated reconnect, disconnect, and event-routing logic |

**End goal:** a single `SignalingModule` — an **independent event source** with no knowledge
of `CallState`, BLoC, `Notification`, `RegistrationStatus`, or any other app-level concept.
Can live in the main isolate, a background isolate, or an integration test with no UI or
WebRTC dependency.

---

## Design Principles

### SignalingModule — pure event source

The module knows only one thing: the **WebSocket connection to the signaling server**.

**Responsible for:**

- `WebtritSignalingClient` lifecycle (connect / disconnect)
- Interpreting disconnect codes — this is **protocol knowledge** (code 4441 → fast reconnect,
  `protocolError` → no reconnect)
- Publishing typed events to a stream

**Does not know anything about:**

- `CallState`, `ActiveCall`, BLoC, `emit`
- `Notification` (app-specific)
- `RegistrationStatus`, `dispatchCompleteCall` (BLoC concerns)
- Whether the app is active or a network connection is available — this is **environmental
  knowledge**, not protocol knowledge

---

## Module API

### Event stream

```dart
sealed class SignalingModuleEvent {}

class SignalingConnecting       extends SignalingModuleEvent {}
class SignalingConnected        extends SignalingModuleEvent {}
class SignalingConnectionFailed extends SignalingModuleEvent {
  final Object error;
  final bool isRepeated;
  final Duration recommendedReconnectDelay;
}
class SignalingDisconnecting    extends SignalingModuleEvent {}

/// Connection closed by server or client.
///
/// [recommendedReconnectDelay] — protocol recommendation from the module:
///   - Duration.zero        → reconnect immediately (e.g. code 4441)
///   - Duration(seconds: 3) → slow reconnect
///   - null                 → do not reconnect (e.g. protocolError)
///
/// The consumer decides whether to act on the recommendation based on
/// network state, app lifecycle, etc.
class SignalingDisconnected extends SignalingModuleEvent {
  final int? code;
  final String? reason;
  final SignalingDisconnectCode knownCode;
  final Duration? recommendedReconnectDelay;
}

class SignalingHandshakeReceived extends SignalingModuleEvent {
  final StateHandshake handshake;
}

class SignalingProtocolEvent extends SignalingModuleEvent {
  final Event event;
}
```

### Public interface

```dart
class SignalingModule {
  SignalingModule({
    required String coreUrl,
    required String tenantId,
    required String token,
    required TrustedCertificates trustedCertificates,
    required SignalingClientFactory signalingClientFactory,
  });

  /// Broadcast stream of all module events. Multiple listeners are supported.
  Stream<SignalingModuleEvent> get events;

  /// Direct access to the client for sending requests
  /// (HangupRequest, AcceptRequest, etc.).
  WebtritSignalingClient? get signalingClient;

  /// Fire-and-forget. Result arrives via [events].
  void connect();

  Future<void> disconnect();
  Future<void> dispose();
}
```

**No delegate. No callbacks. No app dependencies.**

---

## Reconnect: responsibility split

```
Module knows:               Consumer knows:
─────────────               ──────────────
Which code arrived    →     Whether the app is active
What it means         →     Whether a network is available
How long to wait      →     Whether to reconnect at all right now
(recommendedDelay)
```

Consumer reconnect logic (example for CallBloc):

```dart
_signalingModule.events.listen((event) {
  if (event is SignalingDisconnected) {
    final delay = event.recommendedReconnectDelay;
    if (delay != null && state.isAppActive && state.hasConnectivity) {
      Future.delayed(delay, _signalingModule.connect);
    }
  }
});
```

Consumer reconnect logic (example for IsolateManager):

```dart
_signalingModule.events.listen((event) {
  if (event is SignalingDisconnected) {
    final delay = event.recommendedReconnectDelay;
    if (delay != null && !_networkNone) {
      Future.delayed(delay, _signalingModule.connect);
    }
  }
});
```

---

## CallBloc — stream consumer

`CallBloc` **does not implement any delegate**. It subscribes to `events` and maps them to
its internal events and state:

```dart
late final StreamSubscription<SignalingModuleEvent> _signalingSubscription;

// In the constructor:
_signalingSubscription = _signalingModule.events.listen((event) {
  switch (event) {
    case SignalingConnecting():
      add(const _SignalingStatusEvent.connecting());
    case SignalingConnected():
      add(const _SignalingStatusEvent.connected());
    case SignalingConnectionFailed(:final error, :final isRepeated, :final recommendedReconnectDelay):
      if (!isRepeated) submitNotification(const SignalingConnectFailedNotification());
      add(_SignalingStatusEvent.failed(error));
      _scheduleReconnect(recommendedReconnectDelay);
    case SignalingDisconnected(:final code, :final recommendedReconnectDelay):
      add(_SignalingStatusEvent.disconnected(code));
      _scheduleReconnectIfNeeded(recommendedReconnectDelay);
    case SignalingHandshakeReceived(:final handshake):
      add(_HandshakeSignalingEventState(handshake));
    case SignalingProtocolEvent(:final event):
      _onSignalingEventMapper(event);
    default:
      break;
  }
});
```

---

## IsolateManager — stream consumer

`IsolateManager` subscribes only to what it needs:

```dart
_signalingModule.events.listen((event) {
  switch (event) {
    case SignalingHandshakeReceived(:final handshake):
      _onHandshake(handshake);
    case SignalingProtocolEvent(:final event):
      _onProtocolEvent(event);
    case SignalingDisconnected(:final recommendedReconnectDelay):
      if (recommendedReconnectDelay != null && !_networkNone) {
        Future.delayed(recommendedReconnectDelay, _signalingModule.connect);
      }
    default:
      break;
  }
});
```

`IsolateManager` manages internally:

- `_lines` — populated from `SignalingHandshakeReceived` (for `declineCall` / `hangupCall`)
- `_pendingRequests` — request queue until the connection is established
- Connectivity monitoring — via `connectivity_plus`

---

## Integration tests

`SignalingModule` is tested in full isolation from BLoC and WebRTC:

```dart
test('connect → handshake → disconnect lifecycle', () async {
  final module = SignalingModule(
    coreUrl: 'https://...',
    tenantId: '...',
    token: '...',
    trustedCertificates: TrustedCertificates.empty,
    signalingClientFactory: defaultSignalingClientFactory,
  );

  final events = <SignalingModuleEvent>[];
  final sub = module.events.listen(events.add);

  module.connect();

  // Wait for handshake.
  await module.events
      .whereType<SignalingHandshakeReceived>()
      .first
      .timeout(const Duration(seconds: 15));

  await module.disconnect();
  await sub.cancel();
  await module.dispose();

  expect(events, [
    isA<SignalingConnecting>(),
    isA<SignalingConnected>(),
    isA<SignalingHandshakeReceived>(),
    isA<SignalingDisconnecting>(),
    isA<SignalingDisconnected>(),
  ]);
});
```

**No `CallState`. No `CallBloc`. No BLoC-level mocks.**

---

## Dependency diagram

```
Before:
  CallBloc ──uses──► SignalingModule  (knew about CallState, emit)
  IsolateManager ──► SignalingManager (separate class, duplicated logic)

After:
  CallBloc ──subscribes──► SignalingModule.events  (pure stream)
  IsolateManager ──────────► SignalingModule.events  (same class)
  SignalingManager ──► [deleted]
  SignalingModuleDelegate ──► [deleted]
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

---

## Decisions

| Question | Decision |
|---|---|
| `connect()` — Future or fire-and-forget? | **Fire-and-forget.** Returns immediately; `SignalingConnected` arrives via stream. Two channels for the same fact would be redundant. |
| Error deduplication | **`_lastConnectError` stays in the module.** This is protocol detail — avoid spamming the same error. The module adds `isRepeated: bool` to `SignalingConnectionFailed`; consumer decides what to do with it. |
| `recommendedReconnectDelay` in `SignalingConnectionFailed` | **Yes, added** — consistent with `SignalingDisconnected`. Consumer does not hardcode the delay; it receives it from the module. On connect failure the value is always `kSignalingClientReconnectDelay`. |
