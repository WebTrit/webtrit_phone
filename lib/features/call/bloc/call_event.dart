part of 'call_bloc.dart';

abstract class CallEvent {
  const CallEvent();
}

class CallStarted extends CallEvent {
  const CallStarted();
}

@Freezed(copyWith: false)
class _AppLifecycleStateChanged with _$_AppLifecycleStateChanged implements CallEvent {
  const factory _AppLifecycleStateChanged(AppLifecycleState state) = __AppLifecycleStateChanged;
}

@Freezed(copyWith: false)
class _ConnectivityResultChanged with _$_ConnectivityResultChanged implements CallEvent {
  const factory _ConnectivityResultChanged(ConnectivityResult result) = __ConnectivityResultChanged;
}

@Freezed(copyWith: false)
class _NavigatorMediaDevicesChange with _$_NavigatorMediaDevicesChange implements CallEvent {
  const factory _NavigatorMediaDevicesChange() = __NavigatorMediaDevicesChange;
}

// signaling client events

@Freezed(copyWith: false)
class _SignalingClientEvent with _$_SignalingClientEvent implements CallEvent {
  const factory _SignalingClientEvent.connectInitiated() = _SignalingClientEventConnectInitiated;

  const factory _SignalingClientEvent.disconnectInitiated() = _SignalingClientEventDisconnectInitiated;

  const factory _SignalingClientEvent.disconnected(int? code, String? reason) = _SignalingClientEventDisconnected;
}

// handshake signaling events

@Freezed(copyWith: false)
class _HandshakeSignalingEvent with _$_HandshakeSignalingEvent implements CallEvent {
  const factory _HandshakeSignalingEvent.state({
    required int linesCount,
  }) = _HandshakeSignalingEventState;
}

// call signaling events

@Freezed(copyWith: false)
class _CallSignalingEvent with _$_CallSignalingEvent implements CallEvent {
  const factory _CallSignalingEvent.incoming({
    required int line,
    required CallIdValue callId,
    required String callee,
    required String caller,
    String? callerDisplayName,
    String? referredBy,
    String? replaceCallId,
    bool? isFocus,
    JsepValue? jsep,
  }) = _CallSignalingEventIncoming;

  const factory _CallSignalingEvent.ringing({
    required int line,
    required CallIdValue callId,
  }) = _CallSignalingEventRinging;

  const factory _CallSignalingEvent.progress({
    required int line,
    required CallIdValue callId,
    required String callee,
    JsepValue? jsep,
  }) = _CallSignalingEventProgress;

  const factory _CallSignalingEvent.accepted({
    required int line,
    required CallIdValue callId,
    String? callee,
    JsepValue? jsep,
  }) = _CallSignalingEventAccepted;

  const factory _CallSignalingEvent.hangup({
    required int line,
    required CallIdValue callId,
    required int code,
    required String reason,
  }) = _CallSignalingEventHangup;

  const factory _CallSignalingEvent.updating({
    required int line,
    required CallIdValue callId,
    required String callee,
    required String caller,
    String? callerDisplayName,
    String? referredBy,
    String? replaceCallId,
    bool? isFocus,
    JsepValue? jsep,
  }) = _CallSignalingEventUpdating;

  const factory _CallSignalingEvent.updated({
    required int line,
    required CallIdValue callId,
  }) = _CallSignalingEventUpdated;
}

// call push events

@Freezed(copyWith: false)
class _CallPushEvent with _$_CallPushEvent implements CallEvent {
  const factory _CallPushEvent.incoming({
    required CallIdValue callId,
    required CallkeepHandle handle,
    String? displayName,
    required bool video,
    CallkeepIncomingCallError? error,
  }) = _CallPushEventIncoming;
}

// call control events

@Freezed(copyWith: false)
class CallControlEvent with _$CallControlEvent implements CallEvent {
  @Assert('!(generic == null && number == null && email == null)',
      'one of generic, number or email parameters must be assign')
  @Assert(
      '(generic != null && number == null && email == null) ||'
          '(generic == null && number != null && email == null) ||'
          '(generic == null && number == null && email != null)',
      'only one of generic, number or email parameters must be assign')
  @With<CallControlEventStartedMixin>()
  const factory CallControlEvent.started({
    int? line,
    String? generic,
    String? number,
    String? email,
    String? displayName,
    required bool video,
  }) = _CallControlEventStarted;

  const factory CallControlEvent.answered(UuidValue uuid) = _CallControlEventAnswered;

  const factory CallControlEvent.ended(UuidValue uuid) = _CallControlEventEnded;

  const factory CallControlEvent.setHeld(UuidValue uuid, bool onHold) = _CallControlEventSetHeld;

  const factory CallControlEvent.setMuted(UuidValue uuid, bool muted) = _CallControlEventSetMuted;

  const factory CallControlEvent.sentDTMF(UuidValue uuid, String key) = _CallControlEventSentDTMF;

  const factory CallControlEvent.cameraSwitched(UuidValue uuid) = _CallControlEventCameraSwitched;

  const factory CallControlEvent.cameraEnabled(UuidValue uuid, bool enabled) = _CallControlEventCameraEnabled;

  const factory CallControlEvent.speakerEnabled(UuidValue uuid, bool enabled) = _CallControlEventSpeakerEnabled;

  const factory CallControlEvent.failureApproved(UuidValue uuid) = _CallControlEventFailureApproved;
}

mixin CallControlEventStartedMixin {
  String? get generic;

  String? get number;

  String? get email;

  CallkeepHandle get handle {
    if (generic != null) {
      return CallkeepHandle.generic(generic!);
    } else if (number != null) {
      return CallkeepHandle.number(number!);
    } else if (email != null) {
      return CallkeepHandle.email(email!);
    } else {
      throw StateError('one of generic, number or email parameters must be assign');
    }
  }
}

// call perform events

@Freezed(copyWith: false)
class _CallPerformEvent with _$_CallPerformEvent implements CallEvent {
  _CallPerformEvent._();

  factory _CallPerformEvent.started(
    UuidValue uuid, {
    required CallkeepHandle handle,
    String? displayName,
    required bool video,
  }) = _CallPerformEventStarted;

  factory _CallPerformEvent.answered(UuidValue uuid) = _CallPerformEventAnswered;

  factory _CallPerformEvent.ended(UuidValue uuid) = _CallPerformEventEnded;

  factory _CallPerformEvent.setHeld(UuidValue uuid, bool onHold) = _CallPerformEventSetHeld;

  factory _CallPerformEvent.setMuted(UuidValue uuid, bool muted) = _CallPerformEventSetMuted;

  factory _CallPerformEvent.sentDTMF(UuidValue uuid, String key) = _CallPerformEventSentDTMF;

  final _performCompleter = Completer<bool>();

  Future<bool> get future => _performCompleter.future;

  void fulfill() => _performCompleter.complete(true);

  void fail() => _performCompleter.complete(false);
}

// peer connection events

@Freezed(copyWith: false)
class _PeerConnectionEvent with _$_PeerConnectionEvent implements CallEvent {
  const factory _PeerConnectionEvent.iceGatheringStateChanged(UuidValue uuid, RTCIceGatheringState state) =
      _PeerConnectionEventIceGatheringStateChanged;

  const factory _PeerConnectionEvent.iceCandidateIdentified(UuidValue uuid, RTCIceCandidate candidate) =
      _PeerConnectionEventIceCandidateIdentified;

  const factory _PeerConnectionEvent.streamAdded(UuidValue uuid, MediaStream stream) = _PeerConnectionEventStreamAdded;

  const factory _PeerConnectionEvent.streamRemoved(UuidValue uuid, MediaStream stream) =
      _PeerConnectionEventStreamRemoved;
}

// call screen events

@Freezed(copyWith: false)
class CallScreenEvent with _$CallScreenEvent implements CallEvent {
  factory CallScreenEvent.didPush() = _CallScreenEventDidPush;

  factory CallScreenEvent.didPop() = _CallScreenEventDidPop;
}
