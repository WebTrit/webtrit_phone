# Signaling Refactor — Phase 1 Requirements

Related: [#1017](https://github.com/WebTrit/webtrit_phone/issues/1017),
[#1019](https://github.com/WebTrit/webtrit_phone/issues/1019)
Branch: `refactor/signaling-module-stream`

---

## Goal

Extract signaling transport management from `CallBloc` and `IsolateManager` into a single,
reusable, transport-agnostic `SignalingModule`. The module is a **pure stream-based event
source** — it knows only the WebSocket protocol, nothing about call state, BLoC, or
notifications.

This is a prerequisite for Phase S3 of issue #1019 (SignalingHub): once `CallBloc` depends on
`SignalingModule.events` instead of owning `WebtritSignalingClient` directly, swapping the
underlying transport (own WS → hub subscription) becomes a one-file change inside the module.

---

## Current State (what exists today)

### `CallBloc` — owns transport directly

`lib/features/call/bloc/call_bloc.dart` holds:

| Field / method | Role |
|---|---|
| `WebtritSignalingClient? _signalingClient` | raw WS client, nullable |
| `SignalingClientFactory _signalingClientFactory` | factory injected via constructor |
| `Timer? _signalingClientReconnectTimer` | reconnect timer with lifecycle guards |
| `__onSignalingClientEventConnectInitiated` | connect: create client, call `.listen()`, emit state |
| `__onSignalingClientEventDisconnectInitiated` | disconnect: call `.disconnect()`, emit state |
| `__onSignalingClientEventDisconnected` | decode disconnect code, decide reconnect delay |
| `_reconnectInitiated(delay, force)` | cancel old timer, create new timer with guards |
| `_onSignalingStateHandshake` | handshake callback → `_HandshakeSignalingEventState` |
| `_onSignalingEvent` | event callback → `_CallSignalingEvent` |
| `_onSignalingError` | error callback → `_reconnectInitiated(force: true)` |
| `_onSignalingDisconnect` | disconnect callback → `_SignalingClientEvent.disconnected` |

Reconnect guards inside timer callback:

- `isClosed` — BLoC is disposed
- `appActive` — `AppLifecycleState` is resumed/inactive
- `connectionActive` — network is not none
- `signalingRemains` — `_signalingClient != null` (already reconnected)

`_signalingClient` is also used directly in 20+ places across `CallBloc` to send requests
(`execute(HangupRequest(...))`, `execute(OutgoingCallRequest(...))`, etc.).

### `SignalingManager` — standalone component for isolates

`lib/common/signaling_manager.dart` manages signaling for background isolates:

| Feature | Detail |
|---|---|
| Constructor callbacks | `onError`, `onHangupCall`, `onUnregistered`, `onNoActiveLines`, `onIncomingCall`, `onDisconnect` |
| Lifecycle | `launch()` → `_connectClient()` + `_monitorConnectivity()` |
| Pending requests | `_pendingRequests` queue flushed after connect |
| Lines | `_lines` populated from handshake, used by `declineCall` / `hangupCall` |
| Reconnect | `_reconnect()` — no timer, no delay, no lifecycle guards; triggered only from connectivity restore |
| Public methods | `declineCall`, `hangupCall`, `acceptCall`, `hasNetworkConnection`, `dispose` |

Used by:

- `PushNotificationIsolateManager` — `enableReconnect: false`, one-shot
- `SignalingForegroundIsolateManager` — `enableReconnect: true`, persistent

### Problems

1. `CallBloc` is 2966 lines partly because it owns WS lifecycle, reconnect timer, and all
   protocol decode logic inline.
2. `SignalingManager` duplicates connect/disconnect/event-routing logic that already exists in
   `CallBloc`.
3. Reconnect strategies are incompatible: `CallBloc` has a sophisticated timer with four guards;
   `SignalingManager` has a primitive immediate retry. Neither can reuse the other.
4. `WebtritSignalingClient` is created directly inside both — no shared abstraction to swap later.

---

## Target State

### `SignalingModule` — new class

Location: `lib/features/call/services/signaling_module.dart`

Single responsibility: manage one `WebtritSignalingClient` lifecycle and publish its events as
a broadcast stream. No knowledge of call state, BLoC, or notifications.

#### Sealed events

```dart
sealed class SignalingModuleEvent {}

class SignalingConnecting extends SignalingModuleEvent {}

class SignalingConnected extends SignalingModuleEvent {}

/// Connect failed (SocketException, TlsException, etc.).
///
/// [isRepeated] — true when this is the same error as the previous connect attempt.
/// Consumer may suppress notifications when [isRepeated] is true.
///
/// [recommendedReconnectDelay] — always [kSignalingClientReconnectDelay].
/// Consumer decides whether to act on it.
class SignalingConnectionFailed extends SignalingModuleEvent {
  final Object error;
  final bool isRepeated;
  final Duration recommendedReconnectDelay;
}

class SignalingDisconnecting extends SignalingModuleEvent {}

/// Connection closed (by server or client).
///
/// [recommendedReconnectDelay]:
///   - Duration.zero                   → reconnect immediately (e.g. code 4441)
///   - Duration(seconds: 6)            → slow reconnect
///   - null                            → do not reconnect (e.g. protocolError)
///
/// Consumer decides whether to act based on app state, network availability, etc.
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

#### Public API

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
  /// (HangupRequest, AcceptRequest, OutgoingCallRequest, etc.).
  /// Null when not connected.
  WebtritSignalingClient? get signalingClient;

  /// Fire-and-forget. Result arrives via [events].
  void connect();

  Future<void> disconnect();
  Future<void> dispose();
}
```

#### Internal behavior

| Concern | Implementation |
|---|---|
| Connect sequence | `connect()` returns immediately; emits `SignalingConnecting` → calls factory → emits `SignalingConnected` or `SignalingConnectionFailed` |
| Duplicate connect guard | If `_signalingClient != null` on `connect()`, disconnect first |
| Error deduplication | `Object? _lastConnectError` stores `toString()` of last error; `isRepeated` set when match |
| Disconnect code decode | `SignalingDisconnectCode.values.byCode(code)` — module maps code → `recommendedReconnectDelay` |
| `recommendedReconnectDelay` mapping | `controllerForceAttachClose` → `Duration.zero`; `protocolError` → `null`; all others → `kSignalingClientReconnectDelay` |
| Stream | `StreamController<SignalingModuleEvent>.broadcast()` |
| `dispose()` | Disconnects client, closes stream controller |

The module does **not** own a reconnect timer. It does **not** check app lifecycle or network
state. It does **not** call `submitNotification`.

---

### `CallBloc` — consumer of stream

Remove all of the following from `CallBloc`:

| Remove | Replace with |
|---|---|
| `WebtritSignalingClient? _signalingClient` field | `_signalingModule.signalingClient` |
| `SignalingClientFactory _signalingClientFactory` field | passed to `SignalingModule` constructor |
| `Timer? _signalingClientReconnectTimer` | `_scheduleReconnect(Duration)` private method |
| `__onSignalingClientEventConnectInitiated` | `_signalingModule.connect()` |
| `__onSignalingClientEventDisconnectInitiated` | `_signalingModule.disconnect()` |
| `__onSignalingClientEventDisconnected` | handled via `events` stream subscription |
| `_onSignalingStateHandshake` callback | `SignalingHandshakeReceived` from stream |
| `_onSignalingEvent` callback | `SignalingProtocolEvent` from stream |
| `_onSignalingError` callback | `SignalingConnectionFailed` from stream |
| `_onSignalingDisconnect` callback | `SignalingDisconnected` from stream |

New field in `CallBloc`:

```dart
late final SignalingModule _signalingModule;
late final StreamSubscription<SignalingModuleEvent> _signalingSubscription;
```

Stream subscription (in constructor, after `_signalingModule` init):

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
    case SignalingDisconnected(:final code, :final reason, :final knownCode, :final recommendedReconnectDelay):
      _handleDisconnectNotification(code, reason, knownCode);
      add(_SignalingClientEvent.disconnected(code));
      _scheduleReconnectIfNeeded(recommendedReconnectDelay);
    case SignalingHandshakeReceived(:final handshake):
      add(_HandshakeSignalingEventState(handshake));
    case SignalingProtocolEvent(:final event):
      _onSignalingEventMapper(event);
  }
});
```

Reconnect method (replaces `_reconnectInitiated`):

```dart
void _scheduleReconnectIfNeeded(Duration? delay) {
  if (delay == null) return;
  _scheduleReconnect(delay);
}

void _scheduleReconnect(Duration delay, {bool force = false}) {
  _signalingClientReconnectTimer?.cancel();
  _signalingClientReconnectTimer = Timer(delay, () {
    if (isClosed) return;
    if (!force && !state.callServiceState.appActive) return;
    if (!state.callServiceState.connectionActive) return;
    if (_signalingModule.signalingClient != null) return; // already connected
    _signalingModule.connect();
  });
}
```

All 20+ `_signalingClient?.execute(...)` calls remain unchanged — they move to
`_signalingModule.signalingClient?.execute(...)`.

`CallBloc` constructor receives `SignalingModule` instead of `SignalingClientFactory`:

```dart
CallBloc({
  ...
  required SignalingModule signalingModule,
  ...
})
```

---

### `IsolateManager` — consumer of stream

Remove `SignalingManager signalingManager` field. Add `SignalingModule _signalingModule`.

`initSignaling` becomes:

```dart
void initSignaling({required bool enableReconnect}) {
  _signalingModule = SignalingModule(
    coreUrl: storage.readCoreUrl() ?? '',
    tenantId: storage.readTenantId() ?? '',
    token: storage.readToken() ?? '',
    trustedCertificates: certificates,
    signalingClientFactory: defaultSignalingClientFactory,
  );

  _signalingSubscription = _signalingModule.events.listen((event) {
    switch (event) {
      case SignalingHandshakeReceived(:final handshake):
        _onHandshake(handshake);
      case SignalingProtocolEvent(:final event):
        _onProtocolEvent(event);
      case SignalingDisconnected(:final recommendedReconnectDelay):
        if (enableReconnect && recommendedReconnectDelay != null && !_networkNone) {
          Future.delayed(recommendedReconnectDelay, _signalingModule.connect);
        }
      case SignalingConnectionFailed(:final recommendedReconnectDelay):
        if (enableReconnect && !_networkNone) {
          Future.delayed(recommendedReconnectDelay, _signalingModule.connect);
        }
      default:
        break;
    }
  });
}
```

Connectivity monitoring (previously inside `SignalingManager._monitorConnectivity`) moves into
`IsolateManager` directly using `connectivity_plus`.

`_lines` (populated from `StateHandshake`) and `_pendingRequests` move from `SignalingManager`
into `IsolateManager`.

`performEndCall` becomes:

```dart
@override
void performEndCall(String callId) async {
  final line = _lines[callId];
  if (line == null) return;
  try {
    await _signalingModule.signalingClient?.execute(
      DeclineRequest(
        line: line,
        callId: callId,
        transaction: WebtritSignalingClient.generateTransactionId(),
      ),
    );
  } catch (e) {
    logger.severe(e);
  }
}
```

---

### Delete

| File / symbol | Action |
|---|---|
| `lib/common/signaling_manager.dart` | Delete file |
| `export 'signaling_manager.dart'` in `lib/common/common.dart` | Remove line |

---

## Acceptance Criteria

1. `SignalingModule` has no imports from `package:webtrit_phone/features/` or
   `package:flutter_bloc/flutter_bloc.dart`.
2. `SignalingModule` has no reference to `CallState`, `ActiveCall`, `emit`, `Notification`,
   `RegistrationStatus`.
3. `CallBloc` has no `WebtritSignalingClient? _signalingClient` field — access is only via
   `_signalingModule.signalingClient`.
4. `CallBloc` has no `.listen(onStateHandshake:, onEvent:, onError:, onDisconnect:)` call.
5. `SignalingManager` is deleted — zero references across the project.
6. `melos run analyze` passes with zero errors.
7. `flutter test` passes — all existing tests green.
8. Integration test (manual or automated): connect → handshake → incoming call → hangup →
   disconnect lifecycle produces correct event sequence in `SignalingModule.events`.

---

## Out of Scope (Phase 1)

- `SignalingHub` — cross-isolate shared connection (issue #1019 Phase S2–S5)
- `IsolateNameServer` integration
- `webtrit_callkeep` plugin changes
- `CallBloc` decomposition (issue #1017)
- iOS-specific changes (not affected)

---

## Implementation Order

1. Create `lib/features/call/services/signaling_module.dart` — sealed events + module class.
2. Add unit tests for `SignalingModule` disconnect-code → `recommendedReconnectDelay` mapping.
3. Migrate `CallBloc` — replace `_signalingClient` / `_signalingClientFactory` / timer / callbacks
   with `_signalingModule` subscription.
4. Migrate `IsolateManager` subclasses — replace `SignalingManager` with `SignalingModule`,
   port `_lines` / `_pendingRequests` / connectivity monitoring.
5. Delete `signaling_manager.dart`, remove export from `common.dart`.
6. Run `melos run analyze` + `flutter test`.
