# CallBloc Decomposition Report

## Executive Summary

`CallBloc` (`lib/features/call/bloc/call_bloc.dart`) currently stands at **2,932 lines** with
**27 constructor dependencies**, **85 private methods**, and operates simultaneously across four
abstraction levels (infrastructure → protocol rules → coordination → UI state). Its sibling
`SignalingManager` (`lib/common/signaling_manager.dart`, 316 lines) used by background isolates
duplicates a significant portion of its signaling logic.

This report provides:

- A detailed analysis of the proposed decomposition into layered modules
- Full interface sketches (Dart) for each module
- Per-method extraction tables mapping every method in `CallBloc` to its destination
- An objective assessment of benefits and risks
- A complete, phase-by-phase migration path with actionable tasks

---

## Table of Contents

1. [Terminology](#1-terminology)
2. [Current Architecture: Deep Dive](#2-current-architecture-deep-dive)
3. [Proposed Module Interfaces](#3-proposed-module-interfaces)
   - 3.1 [SignalingModule](#31-signalingmodule)
   - 3.2 [CallSession](#32-callsession)
   - 3.3 [PlatformBridge](#33-platformbridge)
   - 3.4 [TransferCoordinator](#34-transfercoordinator)
   - 3.5 [PresenceSyncService](#35-presencesyncservice)
   - 3.6 [CallHistoryRecorder](#36-callhistoryrecorder)
4. [Per-Method Extraction Tables](#4-per-method-extraction-tables)
5. [Benefits of the Proposed Architecture](#5-benefits-of-the-proposed-architecture)
6. [Potential Problems and Risks](#6-potential-problems-and-risks)
7. [Complete Migration Path](#7-complete-migration-path)
8. [Open Questions Resolution](#8-open-questions-resolution)

---

## 1. Terminology

| Term | Meaning |
|------|---------|
| `_signalingClient` | `WebtritSignalingClient` WebSocket connection to the server |
| `_kUndefinedLine` | Sentinel value (`-1`) for a call with no SIP line yet assigned |
| `CallSession` | One-per-call object that owns WebRTC + call flow state machine |
| `SignalingModule` | Pure-Dart class owning WS lifecycle, reconnect, handshake, event conversion |
| `PlatformBridge` | `CallkeepDelegate` adapter + audio device management |
| `_CallPerformEvent` | Internal BLoC events carrying a `Completer<bool>` resolved by native Callkeep |
| `_perform(...)` | Helper that `add()`s a `_CallPerformEvent` and returns its `future` |

---

## 2. Current Architecture: Deep Dive

### 2.1 File Statistics

| File | Lines | Role |
|------|-------|------|
| `call_bloc.dart` | 2,932 | Main orchestrator — all levels |
| `call_event.dart` | 1,058 | All event types (public + private) |
| `call_state.dart` | 317 | State model |
| `signaling_manager.dart` | 316 | Duplicate signaling for isolates |

### 2.2 Constructor Dependencies (27 total)

```
Signaling credentials:  coreUrl, tenantId, token, trustedCertificates
Repositories (6):       callLogsRepository, callPullRepository, userRepository,
                        linesStateRepository, presenceInfoRepository, presenceSettingsRepository
Notifications:          submitNotification
Lifecycle callbacks:    onSessionInvalidated, onCallEnded, onDiagnosticReportRequested
Callkeep:               callkeep, callkeepConnections
WebRTC (6):             sdpMunger, sdpSanitizer, webRtcOptionsBuilder, iceFilter,
                        userMediaBuilder, peerConnectionPolicyApplier
Other utilities:        contactNameResolver, callErrorReporter
Flags:                  sipPresenceEnabled
Infrastructure:         signalingClientFactory, peerConnectionManager
```

### 2.3 The Four Abstraction Levels Mixed in One File

```
Level 4 — UI State:
  emit(state.copyWith(activeCalls: ...))
  emit(state.copyWithMappedActiveCall(callId, ...))

Level 3 — Coordination:
  __onCallPerformEventStarted: wait signaling → get media → offer → request
  __onCallPerformEventAnswered: wait offer → media → answer → accept

Level 2 — Protocol Rules:
  __onSignalingClientEventDisconnected: "code 4441 = reconnect silently"
  _reconnectInitiated: guard clauses, timer management
  SignalingDisconnectCode.sessionMissedError → call onSessionInvalidated()

Level 1 — Infrastructure:
  peerConnection.addIceCandidate()
  _signalingClient?.execute(IceTrickleRequest(...))
  Helper.setSpeakerphoneOn(false)
```

The method `__onCallPerformEventStarted` (lines 1698–1853, 155 lines) crosses all four levels.

### 2.4 Duplication Between CallBloc and SignalingManager

| Concern | CallBloc | SignalingManager |
|---------|---------|-----------------|
| WS connect | `__onSignalingClientEventConnectInitiated` | `_connectClient` |
| WS reconnect timer | `_reconnectInitiated` / `_signalingClientReconnectTimer` | `_reconnect` |
| Connectivity monitoring | `_onConnectivityResultChanged` | `_monitorConnectivity` |
| Handshake processing | `_onSignalingStateHandshake` | `_handleHandshake` |
| Event routing | `_onSignalingEvent` (110 lines) | `_handleEvent` |
| Pending request queue | Implicit (event queue) | `_pendingRequests` list |
| Disconnect handling | `__onSignalingClientEventDisconnected` | `_handleDisconnect` |

---

## 3. Proposed Module Interfaces

### 3.1 `SignalingModule`

**Location:** `lib/common/signaling/`

**Purpose:** Encapsulates the entire WebSocket lifecycle for both the main engine and background
isolates. Replaces `SignalingManager` entirely.

```dart
// lib/common/signaling/reconnect_policy.dart

/// Configures reconnect behaviour for a SignalingModule instance.
abstract interface class ReconnectPolicy {
  /// Whether to automatically reconnect when connectivity is restored.
  bool get enableAutoReconnect;

  /// Delay before the first reconnect attempt after a disconnect.
  Duration get initialReconnectDelay;

  /// Maximum delay between reconnect attempts.
  Duration get maxReconnectDelay;
}

/// Policy for the main engine: auto-reconnect enabled with standard delays.
class MainEngineReconnectPolicy implements ReconnectPolicy {
  const MainEngineReconnectPolicy();

  @override
  bool get enableAutoReconnect => true;

  @override
  Duration get initialReconnectDelay => kSignalingClientReconnectDelay;

  @override
  Duration get maxReconnectDelay => const Duration(seconds: 30);
}

/// Policy for push-service isolates: reconnect disabled (one-shot).
class IsolateDisabledReconnectPolicy implements ReconnectPolicy {
  const IsolateDisabledReconnectPolicy();

  @override
  bool get enableAutoReconnect => false;

  @override
  Duration get initialReconnectDelay => Duration.zero;

  @override
  Duration get maxReconnectDelay => Duration.zero;
}
```

```dart
// lib/common/signaling/signaling_module_event.dart

/// Domain events emitted by SignalingModule — no raw close codes exposed.
sealed class SignalingModuleEvent {
  const SignalingModuleEvent();
}

/// WebSocket connected and handshake received from server.
final class SignalingHandshakeReceived extends SignalingModuleEvent {
  final StateHandshake handshake;
  const SignalingHandshakeReceived(this.handshake);
}

/// A call-domain Event arrived from the server.
final class SignalingEventReceived extends SignalingModuleEvent {
  final Event event;
  const SignalingEventReceived(this.event);
}

/// WebSocket disconnected. Reconnect decision already made by ReconnectPolicy.
final class SignalingDisconnected extends SignalingModuleEvent {
  /// null if close was intentional (goingAway).
  final SignalingDisconnectCode? knownCode;
  final int? rawCode;
  final String? reason;
  const SignalingDisconnected({this.knownCode, this.rawCode, this.reason});
}

/// Transient status change (connecting → connect → disconnecting → disconnect).
final class SignalingStatusChanged extends SignalingModuleEvent {
  final SignalingClientStatus status;
  const SignalingStatusChanged(this.status);
}

/// Reconnect scheduled (informational, for UI feedback).
final class SignalingReconnectScheduled extends SignalingModuleEvent {
  final Duration delay;
  const SignalingReconnectScheduled(this.delay);
}

/// A transient error occurred (will trigger reconnect if policy allows).
final class SignalingErrorOccurred extends SignalingModuleEvent {
  final Object error;
  final StackTrace? stackTrace;
  const SignalingErrorOccurred(this.error, [this.stackTrace]);
}
```

```dart
// lib/common/signaling/signaling_module.dart

/// Pure-Dart, platform-independent signaling lifecycle manager.
///
/// Owns:
/// - WebSocket connection creation and teardown
/// - Reconnect timer (governed by [ReconnectPolicy])
/// - Connectivity monitoring
/// - Handshake processing (including pending-request flushing)
/// - Event conversion (raw [WebtritSignaling] events → [SignalingModuleEvent])
/// - Per-callId request queuing while disconnected
///
/// Does NOT own:
/// - Any BLoC emit() call
/// - RTCPeerConnection
/// - Callkeep
class SignalingModule {
  SignalingModule({
    required String coreUrl,
    required String tenantId,
    required String token,
    required TrustedCertificates certificates,
    required ReconnectPolicy reconnectPolicy,
    SignalingClientFactory signalingClientFactory = defaultSignalingClientFactory,
  });

  /// Stream of domain events. Subscribers should use a sequential listener.
  Stream<SignalingModuleEvent> get events;

  /// Current connection status.
  SignalingClientStatus get status;

  // ── Lifecycle ───────────────────────────────────────────────────────────

  /// Connect and start monitoring connectivity.
  Future<void> start();

  /// Gracefully disconnect; cancels reconnect timers.
  Future<void> stop();

  // ── Imperative triggers (used by CallBloc event handlers) ───────────────

  /// Force an immediate reconnect attempt (e.g. on app resume).
  void triggerReconnect([Duration delay = Duration.zero]);

  /// Force a graceful disconnect (e.g. when app goes to background).
  void triggerDisconnect();

  // ── Request execution ────────────────────────────────────────────────────

  /// Execute a signaling [Request].
  ///
  /// If currently disconnected, queues the request and executes it after
  /// the next successful reconnection (subject to a 10s timeout).
  Future<void> execute(Request request);

  /// Returns a filtered stream for a specific [callId].
  ///
  /// Used by [CallSession] to receive only its own events.
  Stream<SignalingModuleEvent> channelFor(String callId);

  @override
  Future<void> dispose();
}
```

**Key internal implementation notes:**

- `_pendingQueue` replaces the `_pendingRequests` list from `SignalingManager` but generalises to any
  `Request` (not just the three hard-coded methods in the existing `SignalingManager`).
- `_reconnectTimer` replaces `_signalingClientReconnectTimer` in `CallBloc`.
- All `SignalingDisconnectCode` parsing moves here; `CallBloc` only observes `SignalingDisconnected`
  with an already-typed `knownCode`.
- Connectivity monitoring via `Connectivity().onConnectivityChanged` is encapsulated here, removing
  `_connectivityChangedSubscription` from `CallBloc`.

---

### 3.2 `CallSession`

**Location:** `lib/features/call/session/`

**Purpose:** Owns the per-call state machine for both outgoing and incoming flows. Contains
`WebRtcSession` (ICE, SDP, renegotiation, tracks) and drives the call through its lifecycle.

```dart
// lib/features/call/session/call_session_event.dart

/// Events emitted by [CallSession] to drive CallBloc state transitions.
sealed class CallSessionEvent {
  final String callId;
  const CallSessionEvent(this.callId);
}

final class CallSessionStatusChanged extends CallSessionEvent {
  final CallProcessingStatus status;
  const CallSessionStatusChanged(super.callId, this.status);
}

final class CallSessionLocalStreamReady extends CallSessionEvent {
  final MediaStream stream;
  const CallSessionLocalStreamReady(super.callId, this.stream);
}

final class CallSessionRemoteStreamAdded extends CallSessionEvent {
  final MediaStream stream;
  const CallSessionRemoteStreamAdded(super.callId, this.stream);
}

final class CallSessionRemoteStreamRemoved extends CallSessionEvent {
  final String streamId;
  const CallSessionRemoteStreamRemoved(super.callId, this.streamId);
}

final class CallSessionFailed extends CallSessionEvent {
  final Object error;
  final StackTrace stackTrace;
  const CallSessionFailed(super.callId, this.error, this.stackTrace);
}

final class CallSessionEnded extends CallSessionEvent {
  final int? hangupCode;
  final String? hangupReason;
  const CallSessionEnded(super.callId, {this.hangupCode, this.hangupReason});
}

final class CallSessionHoldChanged extends CallSessionEvent {
  final bool held;
  const CallSessionHoldChanged(super.callId, this.held);
}

final class CallSessionMuteChanged extends CallSessionEvent {
  final bool muted;
  const CallSessionMuteChanged(super.callId, this.muted);
}

final class CallSessionRingbackStarted extends CallSessionEvent {
  const CallSessionRingbackStarted(super.callId);
}

final class CallSessionRingbackStopped extends CallSessionEvent {
  const CallSessionRingbackStopped(super.callId);
}
```

```dart
// lib/features/call/session/web_rtc_session.dart

/// Owns an [RTCPeerConnection] for one call.
///
/// Handles ICE trickle, SDP creation/munging, renegotiation, and track management.
/// Sends ICE/Update requests via the provided [SignalingModule.channelFor] execute closure.
class WebRtcSession {
  WebRtcSession({
    required String callId,
    required int? line,
    required PeerConnectionManager peerConnectionManager,
    required Future<void> Function(Request) signalingExecute,
    required SDPMunger? sdpMunger,
    required SdpSanitizer? sdpSanitizer,
    required IceFilter? iceFilter,
    required CallErrorReporter callErrorReporter,
  });

  Stream<CallSessionEvent> get events;

  Future<RTCSessionDescription> prepareOffer(MediaStream localStream);
  Future<RTCSessionDescription> prepareAnswer(RTCSessionDescription remoteOffer, MediaStream localStream);
  Future<void> acceptAnswer(RTCSessionDescription answer);
  Future<void> setHold(bool onHold);
  Future<void> sendDTMF(String key);
  Future<void> dispose();
}
```

```dart
// lib/features/call/session/outgoing_call_flow.dart

/// Runs the outgoing call state machine:
/// [outgoingConnectingToSignaling] → [outgoingInitializingMedia] →
/// [outgoingOfferPreparing] → [outgoingOfferSent] → (ringing) → accepted
///
/// Uses [WebRtcSession] for SDP and [SignalingModule] for protocol requests.
class OutgoingCallFlow {
  OutgoingCallFlow({
    required String callId,
    required int line,
    required bool video,
    required CallkeepHandle handle,
    required WebRtcSession webRtcSession,
    required UserMediaBuilder userMediaBuilder,
    required Future<void> Function(Request) signalingExecute,
    required Stream<SignalingModuleEvent> signalingChannel,
    required Callkeep callkeep,
    required CallErrorReporter callErrorReporter,
    required Stream<CallState> blocStateStream,
  });

  Stream<CallSessionEvent> get events;
  Future<void> start();
  Future<void> dispose();
}
```

```dart
// lib/features/call/session/incoming_call_flow.dart

/// Runs the incoming call state machine:
/// [incomingFromPush/Offer] → [incomingPerformingStarted] →
/// [incomingInitializingMedia] → [incomingAnswering] → accepted
class IncomingCallFlow {
  IncomingCallFlow({
    required String callId,
    required int line,
    required JsepValue? initialOffer,
    required WebRtcSession webRtcSession,
    required UserMediaBuilder userMediaBuilder,
    required Future<void> Function(Request) signalingExecute,
    required Stream<SignalingModuleEvent> signalingChannel,
    required Callkeep callkeep,
    required CallErrorReporter callErrorReporter,
  });

  Stream<CallSessionEvent> get events;

  /// Provide or update the remote offer (may arrive after the call object).
  void supplyOffer(JsepValue offer);

  Future<void> answer();
  Future<void> dispose();
}
```

```dart
// lib/features/call/session/call_session.dart

/// One instance per active call. Owns [OutgoingCallFlow] or [IncomingCallFlow]
/// and [WebRtcSession]. Emits [CallSessionEvent] for [CallBloc] to consume.
class CallSession {
  CallSession.outgoing({
    required String callId,
    required int line,
    required bool video,
    required CallkeepHandle handle,
    required SignalingModule signalingModule,
    required PeerConnectionManager peerConnectionManager,
    required UserMediaBuilder userMediaBuilder,
    required SDPMunger? sdpMunger,
    required SdpSanitizer? sdpSanitizer,
    required IceFilter? iceFilter,
    required Callkeep callkeep,
    required CallErrorReporter callErrorReporter,
    required Stream<CallState> blocStateStream,
  });

  CallSession.incoming({
    required String callId,
    required int line,
    required JsepValue? initialOffer,
    required SignalingModule signalingModule,
    required PeerConnectionManager peerConnectionManager,
    required UserMediaBuilder userMediaBuilder,
    required SDPMunger? sdpMunger,
    required SdpSanitizer? sdpSanitizer,
    required IceFilter? iceFilter,
    required Callkeep callkeep,
    required CallErrorReporter callErrorReporter,
  });

  String get callId;
  Stream<CallSessionEvent> get events;

  void supplyOffer(JsepValue offer);
  Future<void> answer();
  Future<void> end();
  Future<void> setHold(bool onHold);
  Future<void> setMuted(bool muted);
  Future<void> sendDTMF(String key);
  Future<void> dispose();
}
```

---

### 3.3 `PlatformBridge`

**Location:** `lib/features/call/platform/`

**Purpose:** Implements `CallkeepDelegate` by translating every `performX()` callback into a typed
event on a stream. Each event carries a `Completer<bool>` that `CallBloc` resolves.

```dart
// lib/features/call/platform/callkeep_delegate_event.dart

/// Events emitted when Callkeep native code triggers a delegate method.
/// Each carries a Completer so CallBloc can resolve the bool result.
sealed class CallkeepDelegateEvent {
  const CallkeepDelegateEvent();
}

final class CallkeepStartRequested extends CallkeepDelegateEvent {
  final String callId;
  final CallkeepHandle handle;
  final String? displayName;
  final bool video;
  final Completer<bool> completer;
  const CallkeepStartRequested({
    required this.callId,
    required this.handle,
    this.displayName,
    required this.video,
    required this.completer,
  });
}

final class CallkeepAnswerRequested extends CallkeepDelegateEvent {
  final String callId;
  final Completer<bool> completer;
  const CallkeepAnswerRequested({required this.callId, required this.completer});
}

final class CallkeepEndRequested extends CallkeepDelegateEvent {
  final String callId;
  final Completer<bool> completer;
  const CallkeepEndRequested({required this.callId, required this.completer});
}

final class CallkeepHoldRequested extends CallkeepDelegateEvent {
  final String callId;
  final bool onHold;
  final Completer<bool> completer;
  const CallkeepHoldRequested({required this.callId, required this.onHold, required this.completer});
}

final class CallkeepMuteRequested extends CallkeepDelegateEvent {
  final String callId;
  final bool muted;
  final Completer<bool> completer;
  const CallkeepMuteRequested({required this.callId, required this.muted, required this.completer});
}

final class CallkeepDTMFRequested extends CallkeepDelegateEvent {
  final String callId;
  final String key;
  final Completer<bool> completer;
  const CallkeepDTMFRequested({required this.callId, required this.key, required this.completer});
}

final class CallkeepAudioDeviceSetRequested extends CallkeepDelegateEvent {
  final String callId;
  final CallAudioDevice device;
  final Completer<bool> completer;
  const CallkeepAudioDeviceSetRequested({
    required this.callId,
    required this.device,
    required this.completer,
  });
}

final class CallkeepAudioDevicesUpdateRequested extends CallkeepDelegateEvent {
  final String callId;
  final List<CallAudioDevice> devices;
  final Completer<bool> completer;
  const CallkeepAudioDevicesUpdateRequested({
    required this.callId,
    required this.devices,
    required this.completer,
  });
}

final class CallkeepIncomingCallPushed extends CallkeepDelegateEvent {
  final String callId;
  final CallkeepHandle handle;
  final String? displayName;
  final bool video;
  final CallkeepIncomingCallError? error;
  const CallkeepIncomingCallPushed({
    required this.callId,
    required this.handle,
    this.displayName,
    required this.video,
    this.error,
  });
}

final class CallkeepStartIntentContinued extends CallkeepDelegateEvent {
  final CallkeepHandle handle;
  final String? displayName;
  final bool video;
  const CallkeepStartIntentContinued({required this.handle, this.displayName, required this.video});
}

final class CallkeepAudioSessionActivated extends CallkeepDelegateEvent {
  const CallkeepAudioSessionActivated();
}

final class CallkeepAudioSessionDeactivated extends CallkeepDelegateEvent {
  const CallkeepAudioSessionDeactivated();
}

final class CallkeepDidReset extends CallkeepDelegateEvent {
  const CallkeepDidReset();
}
```

```dart
// lib/features/call/platform/audio_device_manager.dart

/// Manages audio routing and device enumeration.
///
/// - On iOS: wraps [Helper.setSpeakerphoneOn] and [navigator.mediaDevices.enumerateDevices]
/// - On Android: wraps [Helper.selectAudioOutput]
///
/// Emits [CallAudioDeviceState] updates on [stream].
class AudioDeviceManager {
  Stream<CallAudioDeviceState> get stream;

  /// Called when the first call begins (0 → 1). Resets speaker to earpiece on iOS.
  void onFirstCallStarted();

  /// Called when the last call ends (N → 0). Resets to earpiece on iOS.
  void onLastCallEnded();

  /// Called when navigator.mediaDevices.ondevicechange fires.
  Future<void> onDeviceChange(bool hasCalls);

  /// Explicitly set the active audio output device.
  Future<void> setDevice(CallAudioDevice device);
}

class CallAudioDeviceState {
  final List<CallAudioDevice> available;
  final CallAudioDevice? current;
  const CallAudioDeviceState({required this.available, this.current});
}
```

```dart
// lib/features/call/platform/platform_bridge.dart

/// Implements [CallkeepDelegate], owns [AudioDeviceManager].
///
/// Every performX() call from native code becomes a [CallkeepDelegateEvent]
/// emitted on [events]. The event's [Completer<bool>] must be resolved by
/// CallBloc (true = success, false = failure).
class PlatformBridge implements CallkeepDelegate {
  PlatformBridge({
    required Callkeep callkeep,
  });

  Stream<CallkeepDelegateEvent> get events;
  AudioDeviceManager get audioDeviceManager;

  // CallkeepDelegate implementation forwards all 11 callbacks to [events].

  @override
  void continueStartCallIntent(CallkeepHandle handle, String? displayName, bool video);
  @override
  void didPushIncomingCall(
    CallkeepHandle handle, String? displayName, bool video, String callId, CallkeepIncomingCallError? error,
  );
  @override
  Future<bool> performStartCall(String callId, CallkeepHandle handle, String? displayName, bool video);
  @override
  Future<bool> performAnswerCall(String callId);
  @override
  Future<bool> performEndCall(String callId);
  @override
  Future<bool> performSetHeld(String callId, bool onHold);
  @override
  Future<bool> performSetMuted(String callId, bool muted);
  @override
  Future<bool> performSendDTMF(String callId, String key);
  @override
  Future<bool> performAudioDeviceSet(String callId, CallkeepAudioDevice device);
  @override
  Future<bool> performAudioDevicesUpdate(String callId, List<CallkeepAudioDevice> devices);
  @override
  void didActivateAudioSession();
  @override
  void didDeactivateAudioSession();
  @override
  void didReset();

  void dispose();
}
```

---

### 3.4 `TransferCoordinator`

**Location:** `lib/features/call/transfer/`

**Purpose:** Owns both the blind-transfer (3-step) and attended-transfer (5-step) state machines.
Receives `Map<String, CallSession>` access via a closure and coordinates hold state.

```dart
// lib/features/call/transfer/transfer_coordinator.dart

/// Coordinates blind and attended call transfers.
///
/// Operates on [CallSession] objects via the provided [sessionsAccessor].
/// All state changes are communicated back via [CallControlEvent]s or
/// directly through [CallSession] hold APIs.
class TransferCoordinator {
  TransferCoordinator({
    required Future<void> Function(Request) signalingExecute,
    required Callkeep callkeep,
    required CallErrorReporter callErrorReporter,
    required CallState Function() currentState,
    required void Function(CallControlEvent) addEvent,
    required void Function(Notification) submitNotification,
  });

  // ── Blind Transfer ──────────────────────────────────────────────────────

  /// Step 1: Put active call on hold; mark it as transfer-initiated.
  Future<void> initiateBlindTransfer(String callId, {required bool speakerOn});

  /// Step 2: Send REFER request to server.
  Future<void> submitBlindTransfer(String callId, String toNumber);

  // ── Attended Transfer ───────────────────────────────────────────────────

  /// Step 1: Put active call on hold; start a new outgoing call.
  Future<void> initiateAttendedTransfer(String callId, {required bool speakerOn});

  /// Step 2: Send REFER+Replaces request to server.
  Future<void> submitAttendedTransfer({
    required ActiveCall referorCall,
    required ActiveCall replaceCall,
  });

  /// Step 3a: Accept incoming attended transfer REFER request.
  Future<void> approveAttendedRequest(String callId, String referTo, String referId);

  /// Step 3b: Decline incoming attended transfer REFER request.
  Future<void> declineAttendedRequest(String callId, String referId);
}
```

---

### 3.5 `PresenceSyncService`

**Location:** `lib/features/call/services/` (or `lib/common/presence/`)

**Purpose:** Owns the 5-second presence-info sync timer and presence settings push.

```dart
// lib/features/call/services/presence_sync_service.dart

/// Periodically synchronises SIP presence settings with the server.
///
/// Construction is guarded by [sipPresenceEnabled]; if the feature is disabled,
/// pass [PresenceSyncService.disabled] (a no-op singleton) instead.
abstract interface class PresenceSyncService {
  /// A no-op implementation for when presence is disabled.
  static const PresenceSyncService disabled = _NoOpPresenceSyncService();

  void start();
  void stop();
  Future<void> syncNow();
}

class _NoOpPresenceSyncService implements PresenceSyncService {
  const _NoOpPresenceSyncService();
  @override void start() {}
  @override void stop() {}
  @override Future<void> syncNow() async {}
}

class LivePresenceSyncService implements PresenceSyncService {
  LivePresenceSyncService({
    required PresenceSettingsRepository presenceSettingsRepository,
    required PresenceInfoRepository presenceInfoRepository,
    required Future<void> Function(Request) signalingExecute,
    required SignalingClientStatus Function() statusGetter,
    required Logger logger,
  });

  @override void start();   // starts Timer.periodic(5s)
  @override void stop();    // cancels timer
  @override Future<void> syncNow();
}
```

---

### 3.6 `CallHistoryRecorder`

**Location:** `lib/features/call/services/`

**Purpose:** Encapsulates the `_addToRecents` logic (ActiveCall → NewCall → `callLogsRepository`).

```dart
// lib/features/call/services/call_history_recorder.dart

/// Records completed calls to the call-log repository.
class CallHistoryRecorder {
  const CallHistoryRecorder({
    required CallLogsRepository callLogsRepository,
    required Logger logger,
  });

  /// Convert [activeCall] to a [NewCall] record and persist it.
  void record(ActiveCall activeCall);
}
```

---

## 4. Per-Method Extraction Tables

### 4.1 `SignalingModule` Destination

| Method in `CallBloc` | Destination | Notes |
|---------------------|-------------|-------|
| `_reconnectInitiated` | `SignalingModule.triggerReconnect()` | Timer + guard clauses move inside |
| `_disconnectInitiated` | `SignalingModule.triggerDisconnect()` | Cancels timer internally |
| `__onSignalingClientEventConnectInitiated` | `SignalingModule._connectInternal()` | Private; emits `SignalingStatusChanged` |
| `__onSignalingClientEventDisconnectInitiated` | `SignalingModule._disconnectInternal()` | Private |
| `__onSignalingClientEventDisconnected` | `SignalingModule._handleDisconnect()` | Parses close codes; emits `SignalingDisconnected` |
| `_onSignalingStateHandshake` | `SignalingModule._handleHandshake()` | Emits `SignalingHandshakeReceived` |
| `_onSignalingEvent` | `SignalingModule._convertEvent()` | Emits `SignalingEventReceived` |
| `_onSignalingError` | `SignalingModule._handleError()` | Emits `SignalingErrorOccurred` |
| `_onSignalingDisconnect` | `SignalingModule._handleDisconnect()` | Already unified |
| `_onConnectivityResultChanged` (signaling part) | `SignalingModule._onConnectivityChanged()` | Only the reconnect/disconnect calls |
| `_onCallStarted` (subscribe connectivity) | `SignalingModule.start()` | Starts connectivity subscription |
| All `_signalingClient?.execute(...)` calls | `SignalingModule.execute(request)` | Uniform API |

### 4.2 `CallSession` Destination

| Method in `CallBloc` | Destination | Notes |
|---------------------|-------------|-------|
| `__onCallPerformEventStarted` | `OutgoingCallFlow.start()` | 155 lines → ~60 in OutgoingCallFlow |
| `__onCallPerformEventAnswered` | `IncomingCallFlow.answer()` | Wait-for-offer logic stays here |
| `_createPeerConnection` | `WebRtcSession._createPeerConnection()` | Observer wiring moves here |
| `_handleRenegotiationNeeded` | `WebRtcSession._onRenegotiationNeeded()` | |
| `__onPeerConnectionEventIceCandidateIdentified` | `WebRtcSession._onIceCandidate()` | |
| `__onPeerConnectionEventIceGatheringStateChanged` | `WebRtcSession._onIceGatheringState()` | |
| `__onPeerConnectionEventIceConnectionStateChanged` | `WebRtcSession._onIceConnectionState()` | |
| `__onPeerConnectionEventStreamAdded` | `WebRtcSession._onStreamAdded()` | Emits `CallSessionRemoteStreamAdded` |
| `__onPeerConnectionEventStreamRemoved` | `WebRtcSession._onStreamRemoved()` | |
| `__onPeerConnectionEventSignalingStateChanged` | `WebRtcSession._onSignalingStateChanged()` | (currently no-op) |
| `__onPeerConnectionEventConnectionStateChanged` | `WebRtcSession._onConnectionStateChanged()` | (currently no-op) |
| `__onCallPerformEventSetHeld` | `CallSession.setHold()` | Delegates to `WebRtcSession.setHold()` |
| `__onCallPerformEventSetMuted` | `CallSession.setMuted()` | |
| `__onCallPerformEventSentDTMF` | `CallSession.sendDTMF()` | |
| `_playRingbackSound` / `_stopRingbackSound` | `OutgoingCallFlow` | `_callkeepSound` passed in |

### 4.3 `PlatformBridge` Destination

| Method in `CallBloc` | Destination | Notes |
|---------------------|-------------|-------|
| `continueStartCallIntent` | `PlatformBridge` → emits `CallkeepStartIntentContinued` | |
| `didPushIncomingCall` | `PlatformBridge` → emits `CallkeepIncomingCallPushed` | |
| `performStartCall` | `PlatformBridge` → emits `CallkeepStartRequested` with completer | |
| `performAnswerCall` | `PlatformBridge` → emits `CallkeepAnswerRequested` | |
| `performEndCall` | `PlatformBridge` → emits `CallkeepEndRequested` | |
| `performSetHeld` | `PlatformBridge` → emits `CallkeepHoldRequested` | |
| `performSetMuted` | `PlatformBridge` → emits `CallkeepMuteRequested` | |
| `performSendDTMF` | `PlatformBridge` → emits `CallkeepDTMFRequested` | |
| `performAudioDeviceSet` | `PlatformBridge` → emits `CallkeepAudioDeviceSetRequested` | |
| `performAudioDevicesUpdate` | `PlatformBridge` → emits `CallkeepAudioDevicesUpdateRequested` | |
| `didActivateAudioSession` | `PlatformBridge` → `AudioDeviceManager` | |
| `didDeactivateAudioSession` | `PlatformBridge` → `AudioDeviceManager` | |
| `didReset` | `PlatformBridge` → emits `CallkeepDidReset` | |
| `_onNavigatorMediaDevicesChange` | `AudioDeviceManager.onDeviceChange()` | |
| `_onFirstCallStarted` | `AudioDeviceManager.onFirstCallStarted()` | |
| `_onLastCallEnded` | `AudioDeviceManager.onLastCallEnded()` | |
| `__onCallPerformEventAudioDeviceSet` | `AudioDeviceManager.setDevice()` | |
| `__onCallPerformEventAudioDevicesUpdate` | `AudioDeviceManager._updateList()` | |
| `_perform()` | Remains in `CallBloc` | Creates completer, adds event |

### 4.4 `TransferCoordinator` Destination

| Method in `CallBloc` | Destination | Notes |
|---------------------|-------------|-------|
| `_onCallControlEventBlindTransferInitiated` | `TransferCoordinator.initiateBlindTransfer()` | |
| `_onCallControlEventBlindTransferSubmitted` | `TransferCoordinator.submitBlindTransfer()` | |
| `_onCallControlEventAttendedTransferInitiated` | `TransferCoordinator.initiateAttendedTransfer()` | |
| `_onCallControlEventAttendedTransferSubmitted` | `TransferCoordinator.submitAttendedTransfer()` | |
| `_onCallControlEventAttendedRequestApproved` | `TransferCoordinator.approveAttendedRequest()` | |
| `_onCallControlEventAttendedRequestDeclined` | `TransferCoordinator.declineAttendedRequest()` | |

### 4.5 `PresenceSyncService` Destination

| Method in `CallBloc` | Destination | Notes |
|---------------------|-------------|-------|
| `syncPresenceSettings` | `LivePresenceSyncService.syncNow()` | |
| `_assingNumberPresence` (typo; rename to `_assignNumberPresence`) | `LivePresenceSyncService._applyPresenceUpdate()` | Called from handshake handler |
| `Timer.periodic` in constructor | `LivePresenceSyncService.start()` | |
| `_presenceInfoSyncTimer?.cancel()` in `close()` | `LivePresenceSyncService.stop()` | |

### 4.6 `CallHistoryRecorder` Destination

| Method in `CallBloc` | Destination | Notes |
|---------------------|-------------|-------|
| `_addToRecents` | `CallHistoryRecorder.record()` | |

### 4.7 Remaining in `CallBloc` After Decomposition (~600 lines)

| Method | Stays because… |
|--------|---------------|
| `_onCallStarted` | BLoC bootstrap; init lifecycle + call `signalingModule.start()` |
| `_onAppLifecycleStateChanged` | Emit + call `signalingModule.trigger*()` |
| `_onConnectivityResultChanged` | Emit state only; signaling triggers delegated |
| `_onRegistrationChange` | State emit |
| `_onResetStateEvent` / subs | Orchestrates Callkeep + state removal |
| `_onHandshakeSignalingEventState` | Dispatches handshake → state |
| `_onCallSignalingEvent` / subs | Routes signaling events; creates/destroys `CallSession`s |
| `_onCallControlEvent` / subs | Routes UI intents to sessions or transfer coordinator |
| `_onCallPerformEvent` | Routes `_CallPerformEvent` to `CallSession` + resolves completers |
| `_onCallScreenEvent` / subs | Screen push/pop side effects |
| `_onConfigEvent` | Config forwarding |
| `onChange` | Side-effect: `PeerConnectionManager`, `linesStateRepository`, session detection |
| `_handleSignalingSessionError` | Critical: logout on session-missed |
| `_handleCallLifecycleTransitions` | Calls `audioDeviceManager.onFirst/LastCall*()` |
| `_notifyAccountErrorSafely` | Network call; stays near the error handling |
| `_assingUserActiveCalls` (typo; rename to `_assignUserActiveCalls`) | Handshake side-effect (pull-calls sync) |
| `_perform` | `Completer<bool>` mechanism for `_CallPerformEvent`s |
| `close` | Orchestrated cleanup |

---

## 5. Benefits of the Proposed Architecture

### 5.1 Testability

**Before:** Every unit test for a single behaviour (e.g., "outgoing call handles signaling timeout")
must mock 27 constructor dependencies, set up a `WebtritSignalingClient` stub, wire a fake
`CallkeepDelegate`, configure a `PeerConnectionManager`, etc.

**After:**

| Module under test | Minimum mock count |
|-------------------|--------------------|
| `SignalingModule` | 1 (`WebtritSignalingClient` via factory) |
| `OutgoingCallFlow` | 2–3 (`signalingExecute`, `userMediaBuilder`, `callkeep`) |
| `IncomingCallFlow` | 2–3 |
| `WebRtcSession` | 2 (`signalingExecute`, `peerConnectionManager`) |
| `TransferCoordinator` | 2 (`signalingExecute`, state snapshot) |
| `PlatformBridge` | 1 (`callkeep`) |
| `CallHistoryRecorder` | 1 (`callLogsRepository`) |
| `PresenceSyncService` | 2 (`presenceSettingsRepository`, `signalingExecute`) |
| `CallBloc` (slim) | 4–5 (`signalingModule`, `platformBridge`, `peerConnectionManager`, `callkeep`) |

### 5.2 Bug Isolation

- An ICE restart failure is in `WebRtcSession`, not somewhere in 2,932 lines.
- A reconnect-loop bug is in `SignalingModule._reconnectTimer`, not scattered across four methods.
- A transfer race condition is in `TransferCoordinator`, isolated from audio device logic.

### 5.3 Code Reuse (Eliminates Duplication)

`SignalingManager` (316 lines, used by background isolates) is replaced entirely by `SignalingModule`
with `IsolateDisabledReconnectPolicy`. The same code path, same event model, different policy.

### 5.4 Cognitive Load

The `__onCallPerformEventStarted` method (155 lines, 4 levels) becomes:
- `OutgoingCallFlow.start()` (~60 lines, Level 3 only)
- `WebRtcSession.prepareOffer()` (~25 lines, Level 1 only)

Each file has a single stated responsibility that fits in a developer's mental model.

### 5.5 Feature Flag Simplification

`sipPresenceEnabled` currently scatters `if (sipPresenceEnabled)` guards throughout `CallBloc`.
With the `PresenceSyncService.disabled` no-op pattern, the flag becomes a single construction
decision; `CallBloc` never checks it again.

### 5.6 Gradual Extractability

Each phase can be merged independently with `CallBloc` remaining functional and in production
throughout. No "big bang" migration is required.

---

## 6. Potential Problems and Risks

### 6.1 `_CallPerformEvent` Completer Contract (HIGH RISK)

**Problem:** The `performStartCall()` / `performAnswerCall()` / `performEndCall()` chain depends on
a `Completer<bool>` being resolved within the BLoC's `sequential()` transformer. If `CallSession`
becomes an independent object running outside the `Emitter` scope, the completer must still be
resolved even if the bloc has transitioned state or been closed.

**Mitigation:**
- Keep `_perform()` and all completer resolution logic inside `CallBloc`.
- `CallSession` emits `CallSessionFailed` / `CallSessionEnded` events; `CallBloc` resolves the
  completer when it processes those events.
- Add a `onDispose` callback to `CallSession` that auto-fails any pending completer.

### 6.2 `stream.firstWhere(...)` Await Pattern (HIGH RISK)

**Problem:** `__onCallPerformEventStarted` and `_continueStartCallIntent` call
`stream.firstWhere(...)` to wait for a signaling status change. If `OutgoingCallFlow` moves this
wait inside itself but receives only a `Stream<SignalingModuleEvent>` channel, it can no longer
observe `CallState`.

**Options:**
1. Pass `Stream<SignalingClientStatus>` derived from `signalingModule.events` to the flow.
2. Keep the signaling-wait step in `CallBloc` before constructing `OutgoingCallFlow` (simpler,
   slightly delays extraction).
3. Expose a `Future<void> waitUntilConnected()` method on `SignalingModule`.

**Recommendation:** Option 3 — `SignalingModule.waitUntilConnected(timeout)` is the cleanest API.

### 6.3 `emit.isDone` Guards in `__onSignalingClientEventConnectInitiated` (MEDIUM RISK)

**Problem:** The current `emit.isDone` check prevents state updates after the BLoC event handler
completes. Once signaling logic moves to `SignalingModule` running outside an `Emitter`, it loses
access to `emit.isDone`.

**Mitigation:** `SignalingModule` is not BLoC-aware. It emits domain events on its stream.
`CallBloc` re-checks `isClosed` after awaiting `SignalingModule` futures, as it already does in
`_continueStartCallIntent`.

### 6.4 Renegotiation Race (MEDIUM RISK)

**Problem:** `_handleRenegotiationNeeded` has an existing known bug (see TODO comment at line 2787):
it can fire in `have-remote-offer` state. Extracting to `WebRtcSession` must not worsen this.

**Mitigation:** Document the known bug explicitly in `WebRtcSession._onRenegotiationNeeded()` and
add a guard clause checking `signalingState == 'stable'` before proceeding.

### 6.5 `PlatformBridge` Completer Lifetime (MEDIUM RISK)

**Problem:** A `performStartCall()` completer might never be resolved if `CallBloc` processes the
event too slowly or is closed before resolution.

**Mitigation:**
- `PlatformBridge` adds a per-completer timeout (e.g. 30 s) that auto-resolves to `false`.
- `CallBloc.close()` drains the `PlatformBridge.events` stream and resolves all pending completers
  to `false` before returning.

### 6.6 `onChange` Side Effects Complexity (MEDIUM RISK)

**Problem:** `onChange` (lines 199–318) contains a mix of: `PeerConnectionManager` lifecycle
management, `linesStateRepository` updates, notification submissions, call lifecycle transitions
(`_handleCallLifecycleTransitions`), and signaling session error detection. This logic is tightly
coupled to state transitions and difficult to move without breaking subtle ordering guarantees.

**Mitigation:** Leave `onChange` in `CallBloc` (it references `emit`-adjacent state). However,
extract `_handleCallLifecycleTransitions` to call `audioDeviceManager.onFirst/LastCallStarted/Ended`
making the audio device management fully encapsulated.

### 6.7 `TransferCoordinator` + `CallSession` Shared State (LOW-MEDIUM RISK)

**Problem:** `TransferCoordinator.initiateBlindTransfer` calls `__onCallControlEventSetHeld` which
itself goes through the BLoC event loop. If `TransferCoordinator` is extracted, it needs to
either re-dispatch a `CallControlEvent` or call `CallSession.setHold()` directly.

**Mitigation:** `TransferCoordinator` dispatches `CallControlEvent.setHeld` back to `CallBloc`
(via the injected `addEvent` closure). This keeps hold-state authoritative in `CallBloc`.

### 6.8 Background Isolate Integration (LOW RISK)

**Problem:** `SignalingManager` is currently constructed in background isolates by
`lib/features/call/services/` (isolate managers). Replacing it with `SignalingModule` requires
these call sites to be updated.

**Mitigation:** Phase 3 explicitly includes updating all isolate constructors. The `ReconnectPolicy`
injection makes the switch straightforward.

### 6.9 `_assingUserActiveCalls` is not Pure (LOW RISK)

> Note: `_assingUserActiveCalls` and `_assingNumberPresence` are the actual method names in the
> current codebase (the `assign` prefix is a pre-existing typo). They should be renamed to
> `_assignUserActiveCalls` / `_assignNumberPresence` when extracted.

**Problem:** `_assingUserActiveCalls` (line 2860) reads `state.activeCalls` from the BLoC to skip
already-active calls. Moving it to `PresenceSyncService` or a standalone helper requires passing
the active-call set as a parameter.

**Mitigation:** Rename to `_assignUserActiveCalls` during extraction. Signature becomes
`_assignUserActiveCalls(userActiveCalls, currentActiveCallIds: Set<String>)`.

### 6.10 Testing Infrastructure Does Not Exist Yet (PROCESS RISK)

**Problem:** The repository currently has no unit tests for `CallBloc`, `SignalingManager`, or any
of the proposed modules.

**Mitigation:** Phase 1 includes creating the test scaffolding for the first extracted modules
(`CallHistoryRecorder`, `PresenceSyncService`) to establish patterns used in subsequent phases.

---

## 7. Complete Migration Path

### Phase 1 — Lowest-risk extractions (no behaviour change, ~1 week)

**Goal:** Extract three stateless helpers; establish testing patterns; no API changes.

**Tasks:**

1. **`CallHistoryRecorder`** (`lib/features/call/services/call_history_recorder.dart`)
   - Move `_addToRecents` logic verbatim.
   - Inject into `CallBloc` constructor; replace all `_addToRecents()` call sites.
   - Write unit tests: `record()` with direction/video/null-username permutations.

2. **`PresenceSyncService`** (`lib/features/call/services/presence_sync_service.dart`)
   - Move `syncPresenceSettings()`, `_assingNumberPresence()` (rename to `_assignNumberPresence`),
     and the `Timer.periodic` setup.
   - Inject `PresenceSyncService.disabled` or `LivePresenceSyncService` based on
     `sipPresenceEnabled`; remove the flag from `CallBloc`.
   - Move `_presenceInfoSyncTimer` ownership to `LivePresenceSyncService`.
   - Write unit tests with fake `PresenceSettingsRepository`.

3. **`AudioDeviceController`** (`lib/features/call/platform/audio_device_manager.dart`)
   - Extract `_onNavigatorMediaDevicesChange`, `_onFirstCallStarted`, `_onLastCallEnded`, and the
     `Helper.setSpeakerphoneOn` calls.
   - `CallBloc.onChange` calls `audioDeviceManager.onFirstCallStarted()` /
     `onLastCallEnded()` instead of directly.
   - Write unit tests (with platform channel mocks for `Helper`).

4. **Update `CallBloc` constructor:** 3 params removed; 3 new injected services (or constructed
   internally with defaults).

**Risk:** Near zero. Pure Dart helpers, no async contract changes.

---

### Phase 2 — `PlatformBridge` (medium risk, ~1 week)

**Goal:** Replace direct `CallkeepDelegate` implementation on `CallBloc` with `PlatformBridge`.

**Tasks:**

1. Create `CallkeepDelegateEvent` sealed class with all 13 subtypes.
2. Implement `PlatformBridge implements CallkeepDelegate`.
3. `CallBloc` subscribes to `platformBridge.events` in `_onCallStarted`.
4. Map each `CallkeepDelegateEvent` to the corresponding private `_onCallPerformEvent` or
   `_onCallControlEvent` dispatch.
5. For `perform*` events: keep the `Completer<bool>` pattern — `PlatformBridge` creates the
   completer and puts it in the event; `CallBloc` resolves it when the operation completes.
6. Remove `implements CallkeepDelegate` from `CallBloc`.
7. Update `callkeep.setDelegate(this)` → `callkeep.setDelegate(platformBridge)`.
8. Write integration test: mock `Callkeep`, fire `performStartCall`, assert completer resolved.

**Risk:** Medium. The completer lifecycle is the critical correctness concern (see §6.1, §6.5).

---

### Phase 3 — `SignalingModule` (medium risk, ~1.5 weeks)

**Goal:** Replace both `WebtritSignalingClient` management in `CallBloc` AND `SignalingManager` used
by isolates.

**Tasks:**

1. Implement `SignalingModule` with `ReconnectPolicy`.
2. Add `waitUntilConnected(timeout)` (resolves §6.2).
3. Migrate `__onSignalingClientEventConnectInitiated` and the two disconnect handlers into
   `SignalingModule` internals. `CallBloc` only observes `SignalingModuleEvent`.
4. Add `channelFor(callId)` (used in Phase 4).
5. Replace `SignalingManager` with `SignalingModule(policy: IsolateDisabledReconnectPolicy())` in
   all isolate constructors under `lib/features/call/services/`.
6. Delete `lib/common/signaling_manager.dart`.
7. Update `lib/common/common.dart` exports.
8. Write unit tests: reconnect policy behaviour, pending-queue drain, close-code parsing.

**Risk:** Medium. The reconnect guard clauses (app active, connectivity active, `force` flag) must
be faithfully reproduced inside `SignalingModule`. A side-by-side comparison test is recommended.

---

### Phase 4 — `CallSession` (high risk, requires Phase 2 + 3, ~2 weeks)

**Goal:** Extract per-call state machines to `CallSession` objects.

**Pre-condition:** `SignalingModule.channelFor(callId)` is available (Phase 3) and
`PlatformBridge` delivers resolved completers (Phase 2).

**Tasks:**

1. Implement `WebRtcSession` (move ICE + SDP logic; fix renegotiation guard §6.4).
2. Implement `OutgoingCallFlow` (move `__onCallPerformEventStarted`; use
   `SignalingModule.waitUntilConnected()` for signaling-wait).
3. Implement `IncomingCallFlow` (move `__onCallPerformEventAnswered`).
4. Implement `CallSession` facade.
5. `CallBloc` maintains `Map<String, CallSession> _sessions`. On
   `_CallSignalingEventIncoming` / `performStartCall`: create session. On hangup/end: dispose.
6. `CallBloc._onCallPerformEvent` routes `started`/`answered`/`ended` to
   `session.start()` / `.answer()` / `.end()` and subscribes to `session.events`.
7. `CallSession.events` streams `CallSessionEvent`s back as internal BLoC events.
8. Remove `_peerConnectionManager.add()` / `disposePeerConnection()` from `onChange`; delegate to
   `CallSession.dispose()`.
9. Write integration tests for full outgoing-call flow with mock signaling + webrtc.

**Risk:** High. This phase touches the most load-bearing paths. Suggested mitigation:
- Feature-flag the new `CallSession` path in a debug build.
- Run existing manual QA test matrix on both paths before removing the old code.

---

### Phase 5 — `TransferCoordinator` (medium risk, parallel with Phase 4, ~1 week)

**Goal:** Extract transfer state machines; requires `CallSession.setHold()` (from Phase 4).

**Tasks:**

1. Implement `TransferCoordinator` (move 6 methods, ~250 lines).
2. Inject into `CallBloc`; route `CallControlEvent` transfer subtypes via `coordinator.*`.
3. Resolve §6.7: `coordinator` re-dispatches `CallControlEvent.setHeld` via the `addEvent` closure.
4. Write unit tests for blind-transfer 3-step and attended-transfer 5-step flows.

**Risk:** Medium. Transfer is largely self-contained once `CallSession.setHold()` exists.

---

### Phase Summary Table

| Phase | What | Depends on | LoC in CallBloc removed | Risk |
|-------|------|-----------|------------------------|------|
| 1 | `CallHistoryRecorder`, `PresenceSyncService`, `AudioDeviceManager` | — | ~200 | Near zero |
| 2 | `PlatformBridge` | Phase 1 | ~300 | Medium |
| 3 | `SignalingModule` (+ replaces `SignalingManager`) | — | ~450 | Medium |
| 4 | `CallSession` | Phase 2 + 3 | ~900 | High |
| 5 | `TransferCoordinator` | Phase 4 | ~250 | Medium |
| **Total** | | | **~2,100 of 2,932** | |

After all phases, `CallBloc` shrinks to approximately **600–700 lines** with **8–10 constructor
dependencies** and a single responsibility: event routing + state emission.

---

## 8. Open Questions Resolution

**Q1: `CallSession` lifetime — at `CallkeepPerformStart` or `CallControlEvent.started`?**

Recommendation: **Create `CallSession` at `CallControlEvent.started`** (UI/API trigger) for
outgoing calls, because the session needs to set up `WebRtcSession` and media _before_
`performStartCall()` arrives. The `PlatformBridge` delivers `performStartCall` as an event;
`CallBloc` already has the session ready to route it.

For incoming calls, create `CallSession` at `__onCallSignalingEventIncoming` (when the line and
offer are known). Push-triggered calls need a placeholder `ActiveCall` first (as today), and the
session is enriched with the offer when `supplyOffer()` is called.

**Q2: `SignalingChannel` — filtered stream or simpler alternative?**

Recommendation: Use `SignalingModule.channelFor(callId)` as a **filtered stream view**, implemented
internally as:

```dart
Stream<SignalingModuleEvent> channelFor(String callId) =>
    events.where((e) => e is SignalingEventReceived && e.event.callId == callId ||
                        e is SignalingHandshakeReceived);
```

This is simpler than passing a raw stream and keeps `SignalingModule` as the single source of truth.

**Q3: Should Phase 3 (`SignalingModule`) be prioritised over Phase 4 (`CallSession`)?**

Yes. Phase 3 is fully independent of Phase 2 and Phase 4. It unblocks isolate code deduplication
immediately, eliminates 316 lines of `SignalingManager`, and reduces the duplication risk in future
PRs. Prioritising Phase 3 is strongly recommended.

**Q4: `TransferCoordinator` access to `CallSession` — direct map or via commands?**

Recommendation: **Via commands** (injected `addEvent` closure dispatching `CallControlEvent`s).
Direct map access would couple `TransferCoordinator` to `CallSession` lifecycle management (when
to create, dispose). Dispatching `CallControlEvent.setHeld` keeps the hold-state logic authoritative
in `CallBloc` and avoids a double-source-of-truth problem.

**Q5: Backward compatibility during migration — will partial extraction break the
`_CallPerformEvent` completer contract?**

The completer contract is preserved as long as:
1. The completer is created in `CallBloc` (via `_perform()`) and resolved in `CallBloc` event
   handlers, regardless of which module executes the underlying operation.
2. Any phase that moves an operation outside `CallBloc` (e.g., `OutgoingCallFlow.start()`) must
   emit a terminal `CallSessionEvent` that triggers the completer resolution back in `CallBloc`.
3. Every `dispose()` path auto-fails pending completers.

With these three invariants, no partial-extraction phase breaks the contract.

---

*Report generated by Copilot — 2026-03-25.*
*Codebase snapshot: `CallBloc` at 2,932 lines, `SignalingManager` at 316 lines.*
