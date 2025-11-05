part of 'call_bloc.dart';

sealed class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object?> get props => [];
}

class CallStarted extends CallEvent {
  const CallStarted();
}

class _AppLifecycleStateChanged extends CallEvent {
  const _AppLifecycleStateChanged(this.state);

  final AppLifecycleState state;

  @override
  List<Object?> get props => [state];
}

class _ConnectivityResultChanged extends CallEvent {
  const _ConnectivityResultChanged(this.result);

  final ConnectivityResult result;

  @override
  List<Object?> get props => [result];
}

class _NavigatorMediaDevicesChange extends CallEvent {
  const _NavigatorMediaDevicesChange();
}

// registration event change

class _RegistrationChange extends CallEvent {
  const _RegistrationChange({required this.registration});

  final Registration registration;

  @override
  List<Object?> get props => [registration];
}

// handle app state

sealed class _ResetStateEvent extends CallEvent {
  const _ResetStateEvent();

  const factory _ResetStateEvent.completeCalls() = _ResetStateEventCompleteCalls;

  const factory _ResetStateEvent.completeCall(String callId) = _ResetStateEventCompleteCall;
}

class _ResetStateEventCompleteCalls extends _ResetStateEvent {
  const _ResetStateEventCompleteCalls();
}

class _ResetStateEventCompleteCall extends _ResetStateEvent {
  const _ResetStateEventCompleteCall(this.callId);

  final String callId;

  @override
  List<Object?> get props => [callId];
}

// signaling client events

sealed class _SignalingClientEvent extends CallEvent {
  const _SignalingClientEvent();

  const factory _SignalingClientEvent.connectInitiated() = _SignalingClientEventConnectInitiated;

  const factory _SignalingClientEvent.disconnectInitiated() = _SignalingClientEventDisconnectInitiated;

  const factory _SignalingClientEvent.disconnected(int? code, String? reason) = _SignalingClientEventDisconnected;
}

class _SignalingClientEventConnectInitiated extends _SignalingClientEvent {
  const _SignalingClientEventConnectInitiated();
}

class _SignalingClientEventDisconnectInitiated extends _SignalingClientEvent {
  const _SignalingClientEventDisconnectInitiated();
}

class _SignalingClientEventDisconnected extends _SignalingClientEvent {
  const _SignalingClientEventDisconnected(this.code, this.reason);

  final int? code;
  final String? reason;

  @override
  List<Object?> get props => [code, reason];
}

// handshake signaling events

class _HandshakeSignalingEventState extends CallEvent {
  const _HandshakeSignalingEventState({required this.registration, required this.linesCount});

  final Registration registration;
  final int linesCount;

  @override
  List<Object?> get props => [registration, linesCount];
}

// call signaling events

sealed class _CallSignalingEvent extends CallEvent {
  const _CallSignalingEvent();

  const factory _CallSignalingEvent.incoming({
    required int? line,
    required String callId,
    required String callee,
    required String caller,
    String? callerDisplayName,
    String? referredBy,
    String? replaceCallId,
    bool? isFocus,
    JsepValue? jsep,
  }) = _CallSignalingEventIncoming;

  const factory _CallSignalingEvent.ringing({required int? line, required String callId}) = _CallSignalingEventRinging;

  const factory _CallSignalingEvent.progress({
    required int? line,
    required String callId,
    required String callee,
    JsepValue? jsep,
  }) = _CallSignalingEventProgress;

  const factory _CallSignalingEvent.accepted({
    required int? line,
    required String callId,
    String? callee,
    JsepValue? jsep,
  }) = _CallSignalingEventAccepted;

  const factory _CallSignalingEvent.hangup({
    required int? line,
    required String callId,
    required int code,
    required String reason,
  }) = _CallSignalingEventHangup;

  const factory _CallSignalingEvent.updating({
    required int? line,
    required String callId,
    required String callee,
    required String caller,
    String? callerDisplayName,
    String? referredBy,
    String? replaceCallId,
    bool? isFocus,
    JsepValue? jsep,
  }) = _CallSignalingEventUpdating;

  const factory _CallSignalingEvent.updated({required int? line, required String callId}) = _CallSignalingEventUpdated;

  const factory _CallSignalingEvent.transfer({
    required int? line,
    required String referId,
    required String referTo,
    required String? referredBy,
    required String? replaceCallId,
  }) = _CallSignalingEventTransfer;

  const factory _CallSignalingEvent.transferring({required int? line, required String callId}) =
      _CallSignalingEventTransferring;

  const factory _CallSignalingEvent.notifyDialog({
    required int? line,
    required String callId,
    required String? notify,
    required SubscriptionState? subscriptionState,
    required List<UserActiveCall> userActiveCalls,
  }) = _CallSignalingEventNotifyDialog;

  const factory _CallSignalingEvent.notifyRefer({
    required int? line,
    required String callId,
    required String? notify,
    required SubscriptionState? subscriptionState,
    required ReferNotifyState state,
  }) = _CallSignalingEventNotifyRefer;

  const factory _CallSignalingEvent.notifyPresence({
    required int? line,
    required String callId,
    required String? notify,
    required SubscriptionState? subscriptionState,
    required String number,
    required List<SignalingPresenceInfo> presenceInfo,
  }) = _CallSignalingEventNotifyPresence;

  const factory _CallSignalingEvent.notifyUnknown({
    required int? line,
    required String callId,
    required String? notify,
    required SubscriptionState? subscriptionState,
    required String? contentType,
    required String? content,
  }) = _CallSignalingEventNotifyUnknown;

  const factory _CallSignalingEvent.registering() = _CallSignalingEventRegistering;

  const factory _CallSignalingEvent.registered() = _CallSignalingEventRegistered;

  const factory _CallSignalingEvent.registrationFailed(int code, String reason) =
      _CallSignalingEventRegisterationFailed;

  const factory _CallSignalingEvent.unregistering() = _CallSignalingEventUnregistering;

  const factory _CallSignalingEvent.unregistered() = _CallSignalingEventUnregistered;
}

class _CallSignalingEventIncoming extends _CallSignalingEvent {
  const _CallSignalingEventIncoming({
    required this.line,
    required this.callId,
    required this.callee,
    required this.caller,
    this.callerDisplayName,
    this.referredBy,
    this.replaceCallId,
    this.isFocus,
    this.jsep,
  });

  final int? line;
  final String callId;
  final String callee;
  final String caller;
  final String? callerDisplayName;
  final String? referredBy;
  final String? replaceCallId;
  final bool? isFocus;
  final JsepValue? jsep;

  @override
  List<Object?> get props => [
    line,
    callId,
    callee,
    caller,
    callerDisplayName,
    referredBy,
    replaceCallId,
    isFocus,
    jsep,
  ];
}

class _CallSignalingEventRinging extends _CallSignalingEvent {
  const _CallSignalingEventRinging({required this.line, required this.callId});

  final int? line;
  final String callId;

  @override
  List<Object?> get props => [line, callId];
}

class _CallSignalingEventProgress extends _CallSignalingEvent {
  const _CallSignalingEventProgress({required this.line, required this.callId, required this.callee, this.jsep});

  final int? line;
  final String callId;
  final String callee;
  final JsepValue? jsep;

  @override
  List<Object?> get props => [line, callId, callee, jsep];
}

class _CallSignalingEventAccepted extends _CallSignalingEvent {
  const _CallSignalingEventAccepted({required this.line, required this.callId, this.callee, this.jsep});

  final int? line;
  final String callId;
  final String? callee;
  final JsepValue? jsep;

  @override
  List<Object?> get props => [line, callId, callee, jsep];
}

class _CallSignalingEventHangup extends _CallSignalingEvent {
  const _CallSignalingEventHangup({required this.line, required this.callId, required this.code, required this.reason});

  final int? line;
  final String callId;
  final int code;
  final String reason;

  @override
  List<Object?> get props => [line, callId, code, reason];
}

class _CallSignalingEventUpdating extends _CallSignalingEvent {
  const _CallSignalingEventUpdating({
    required this.line,
    required this.callId,
    required this.callee,
    required this.caller,
    this.callerDisplayName,
    this.referredBy,
    this.replaceCallId,
    this.isFocus,
    this.jsep,
  });

  final int? line;
  final String callId;
  final String callee;
  final String caller;
  final String? callerDisplayName;
  final String? referredBy;
  final String? replaceCallId;
  final bool? isFocus;
  final JsepValue? jsep;

  @override
  List<Object?> get props => [
    line,
    callId,
    callee,
    caller,
    callerDisplayName,
    referredBy,
    replaceCallId,
    isFocus,
    jsep,
  ];
}

class _CallSignalingEventUpdated extends _CallSignalingEvent {
  const _CallSignalingEventUpdated({required this.line, required this.callId});

  final int? line;
  final String callId;

  @override
  List<Object?> get props => [line, callId];
}

class _CallSignalingEventTransfer extends _CallSignalingEvent {
  const _CallSignalingEventTransfer({
    required this.line,
    required this.referId,
    required this.referTo,
    required this.referredBy,
    required this.replaceCallId,
  });

  final int? line;
  final String referId;
  final String referTo;
  final String? referredBy;
  final String? replaceCallId;

  @override
  List<Object?> get props => [line, referId, referTo, referredBy, replaceCallId];
}

class _CallSignalingEventTransferring extends _CallSignalingEvent {
  const _CallSignalingEventTransferring({required this.line, required this.callId});

  final int? line;
  final String callId;

  @override
  List<Object?> get props => [line, callId];
}

class _CallSignalingEventNotifyDialog extends _CallSignalingEvent {
  const _CallSignalingEventNotifyDialog({
    required this.line,
    required this.callId,
    required this.notify,
    required this.subscriptionState,
    required this.userActiveCalls,
  });

  final int? line;
  final String callId;
  final String? notify;
  final SubscriptionState? subscriptionState;
  final List<UserActiveCall> userActiveCalls;

  @override
  List<Object?> get props => [line, callId, notify, subscriptionState, userActiveCalls];
}

class _CallSignalingEventNotifyRefer extends _CallSignalingEvent {
  const _CallSignalingEventNotifyRefer({
    required this.line,
    required this.callId,
    required this.notify,
    required this.subscriptionState,
    required this.state,
  });

  final int? line;
  final String callId;
  final String? notify;
  final SubscriptionState? subscriptionState;
  final ReferNotifyState state;

  @override
  List<Object?> get props => [line, callId, notify, subscriptionState, state];
}

class _CallSignalingEventNotifyPresence extends _CallSignalingEvent {
  const _CallSignalingEventNotifyPresence({
    required this.line,
    required this.callId,
    required this.notify,
    required this.subscriptionState,
    required this.number,
    required this.presenceInfo,
  });

  final int? line;
  final String callId;
  final String? notify;
  final SubscriptionState? subscriptionState;
  final String number;
  final List<SignalingPresenceInfo> presenceInfo;

  @override
  List<Object?> get props => [line, callId, notify, subscriptionState, number, presenceInfo];
}

class _CallSignalingEventNotifyUnknown extends _CallSignalingEvent {
  const _CallSignalingEventNotifyUnknown({
    required this.line,
    required this.callId,
    required this.notify,
    required this.subscriptionState,
    required this.contentType,
    required this.content,
  });

  final int? line;
  final String callId;
  final String? notify;
  final SubscriptionState? subscriptionState;
  final String? contentType;
  final String? content;

  @override
  List<Object?> get props => [line, callId, notify, subscriptionState, contentType, content];
}

class _CallSignalingEventRegistering extends _CallSignalingEvent {
  const _CallSignalingEventRegistering();
}

class _CallSignalingEventRegistered extends _CallSignalingEvent {
  const _CallSignalingEventRegistered();
}

class _CallSignalingEventRegisterationFailed extends _CallSignalingEvent {
  const _CallSignalingEventRegisterationFailed(this.code, this.reason);

  final int code;
  final String reason;

  @override
  List<Object?> get props => [code, reason];
}

class _CallSignalingEventUnregistering extends _CallSignalingEvent {
  const _CallSignalingEventUnregistering();
}

class _CallSignalingEventUnregistered extends _CallSignalingEvent {
  const _CallSignalingEventUnregistered();
}

// call push events

class _CallPushEventIncoming extends CallEvent {
  const _CallPushEventIncoming({
    required this.callId,
    required this.handle,
    this.displayName,
    required this.video,
    this.error,
  });

  final String callId;
  final CallkeepHandle handle;
  final String? displayName;
  final bool video;
  final CallkeepIncomingCallError? error;

  @override
  List<Object?> get props => [callId, handle, displayName, video, error];
}

// call control events

sealed class CallControlEvent extends CallEvent {
  const CallControlEvent();

  const factory CallControlEvent.started({
    int? line,
    String? generic,
    String? number,
    String? email,
    String? displayName,
    String? replaces,
    String? fromNumber,
    required bool video,
  }) = _CallControlEventStarted;

  const factory CallControlEvent.answered(String callId) = _CallControlEventAnswered;

  const factory CallControlEvent.ended(String callId) = _CallControlEventEnded;

  const factory CallControlEvent.setHeld(String callId, bool onHold) = _CallControlEventSetHeld;

  const factory CallControlEvent.setMuted(String callId, bool muted) = _CallControlEventSetMuted;

  const factory CallControlEvent.sentDTMF(String callId, String key) = _CallControlEventSentDTMF;

  const factory CallControlEvent.cameraSwitched(String callId) = _CallControlEventCameraSwitched;

  const factory CallControlEvent.cameraEnabled(String callId, bool enabled) = _CallControlEventCameraEnabled;

  const factory CallControlEvent.audioDeviceSet(String callId, CallAudioDevice device) =
      _CallControlEventAudioDeviceSet;

  const factory CallControlEvent.failureApproved(String callId) = _CallControlEventFailureApproved;

  const factory CallControlEvent.blindTransferInitiated(String callId) = _CallControlEventBlindTransferInitiated;

  const factory CallControlEvent.attendedTransferInitiated(String callId) = _CallControlEventAttendedTransferInitiated;

  const factory CallControlEvent.blindTransferSubmitted({required String number}) =
      _CallControlEventBlindTransferSubmitted;

  const factory CallControlEvent.attendedTransferSubmitted({
    required ActiveCall referorCall,
    required ActiveCall replaceCall,
  }) = _CallControlEventAttendedTransferSubmitted;

  const factory CallControlEvent.attendedRequestDeclined({required String callId, required String referId}) =
      _CallControlEventAttendedRequestDeclined;

  const factory CallControlEvent.attendedRequestApproved({required String referId, required String referTo}) =
      _CallControlEventAttendedRequestApproved;
}

class _CallControlEventStarted extends CallControlEvent with CallControlEventStartedMixin {
  const _CallControlEventStarted({
    this.line,
    this.generic,
    this.number,
    this.email,
    this.displayName,
    this.replaces,
    this.fromNumber,
    required this.video,
  });

  final int? line;
  @override
  final String? generic;
  @override
  final String? number;
  @override
  final String? email;
  final String? displayName;
  final String? replaces;
  final String? fromNumber;
  final bool video;

  @override
  List<Object?> get props => [line, generic, number, email, displayName, replaces, fromNumber, video];
}

class _CallControlEventAnswered extends CallControlEvent {
  const _CallControlEventAnswered(this.callId);

  final String callId;

  @override
  List<Object?> get props => [callId];
}

class _CallControlEventEnded extends CallControlEvent {
  const _CallControlEventEnded(this.callId);

  final String callId;

  @override
  List<Object?> get props => [callId];
}

class _CallControlEventSetHeld extends CallControlEvent {
  const _CallControlEventSetHeld(this.callId, this.onHold);

  final String callId;
  final bool onHold;

  @override
  List<Object?> get props => [callId, onHold];
}

class _CallControlEventSetMuted extends CallControlEvent {
  const _CallControlEventSetMuted(this.callId, this.muted);

  final String callId;
  final bool muted;

  @override
  List<Object?> get props => [callId, muted];
}

class _CallControlEventSentDTMF extends CallControlEvent {
  const _CallControlEventSentDTMF(this.callId, this.key);

  final String callId;
  final String key;

  @override
  List<Object?> get props => [callId, key];
}

class _CallControlEventCameraSwitched extends CallControlEvent {
  const _CallControlEventCameraSwitched(this.callId);

  final String callId;

  @override
  List<Object?> get props => [callId];
}

class _CallControlEventCameraEnabled extends CallControlEvent {
  const _CallControlEventCameraEnabled(this.callId, this.enabled);

  final String callId;
  final bool enabled;

  @override
  List<Object?> get props => [callId, enabled];
}

class _CallControlEventAudioDeviceSet extends CallControlEvent {
  const _CallControlEventAudioDeviceSet(this.callId, this.device);

  final String callId;
  final CallAudioDevice device;

  @override
  List<Object?> get props => [callId, device];
}

class _CallControlEventFailureApproved extends CallControlEvent {
  const _CallControlEventFailureApproved(this.callId);

  final String callId;

  @override
  List<Object?> get props => [callId];
}

class _CallControlEventBlindTransferInitiated extends CallControlEvent {
  const _CallControlEventBlindTransferInitiated(this.callId);

  final String callId;

  @override
  List<Object?> get props => [callId];
}

class _CallControlEventAttendedTransferInitiated extends CallControlEvent {
  const _CallControlEventAttendedTransferInitiated(this.callId);

  final String callId;

  @override
  List<Object?> get props => [callId];
}

class _CallControlEventBlindTransferSubmitted extends CallControlEvent {
  const _CallControlEventBlindTransferSubmitted({required this.number});

  final String number;

  @override
  List<Object?> get props => [number];
}

class _CallControlEventAttendedTransferSubmitted extends CallControlEvent {
  const _CallControlEventAttendedTransferSubmitted({required this.referorCall, required this.replaceCall});

  final ActiveCall referorCall;
  final ActiveCall replaceCall;

  @override
  List<Object?> get props => [referorCall, replaceCall];
}

class _CallControlEventAttendedRequestDeclined extends CallControlEvent {
  const _CallControlEventAttendedRequestDeclined({required this.callId, required this.referId});

  final String callId;
  final String referId;

  @override
  List<Object?> get props => [callId, referId];
}

class _CallControlEventAttendedRequestApproved extends CallControlEvent {
  const _CallControlEventAttendedRequestApproved({required this.referId, required this.referTo});

  final String referId;
  final String referTo;

  @override
  List<Object?> get props => [referId, referTo];
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

sealed class _CallPerformEvent extends CallEvent {
  _CallPerformEvent();

  factory _CallPerformEvent.started(
    String callId, {
    required CallkeepHandle handle,
    String? displayName,
    required bool video,
  }) = _CallPerformEventStarted;

  factory _CallPerformEvent.answered(String callId) = _CallPerformEventAnswered;

  factory _CallPerformEvent.ended(String callId) = _CallPerformEventEnded;

  factory _CallPerformEvent.setHeld(String callId, bool onHold) = _CallPerformEventSetHeld;

  factory _CallPerformEvent.setMuted(String callId, bool muted) = _CallPerformEventSetMuted;

  factory _CallPerformEvent.sentDTMF(String callId, String key) = _CallPerformEventSentDTMF;

  factory _CallPerformEvent.audioDeviceSet(String callId, CallAudioDevice device) = _CallPerformEventAudioDeviceSet;

  factory _CallPerformEvent.audioDevicesUpdate(String callId, List<CallAudioDevice> devices) =
      _CallPerformEventAudioDevicesUpdate;

  final _performCompleter = Completer<bool>();

  Future<bool> get future => _performCompleter.future;

  void fulfill() => _performCompleter.isCompleted ? null : _performCompleter.complete(true);

  void fail() => _performCompleter.isCompleted ? null : _performCompleter.complete(false);
}

class _CallPerformEventStarted extends _CallPerformEvent {
  _CallPerformEventStarted(this.callId, {required this.handle, this.displayName, required this.video});

  final String callId;
  final CallkeepHandle handle;
  final String? displayName;
  final bool video;

  @override
  List<Object?> get props => [callId, handle, displayName, video];
}

class _CallPerformEventAnswered extends _CallPerformEvent {
  _CallPerformEventAnswered(this.callId);

  final String callId;

  @override
  List<Object?> get props => [callId];
}

class _CallPerformEventEnded extends _CallPerformEvent {
  _CallPerformEventEnded(this.callId);

  final String callId;

  @override
  List<Object?> get props => [callId];
}

class _CallPerformEventSetHeld extends _CallPerformEvent {
  _CallPerformEventSetHeld(this.callId, this.onHold);

  final String callId;
  final bool onHold;

  @override
  List<Object?> get props => [callId, onHold];
}

class _CallPerformEventSetMuted extends _CallPerformEvent {
  _CallPerformEventSetMuted(this.callId, this.muted);

  final String callId;
  final bool muted;

  @override
  List<Object?> get props => [callId, muted];
}

class _CallPerformEventSentDTMF extends _CallPerformEvent {
  _CallPerformEventSentDTMF(this.callId, this.key);

  final String callId;
  final String key;

  @override
  List<Object?> get props => [callId, key];
}

class _CallPerformEventAudioDeviceSet extends _CallPerformEvent {
  _CallPerformEventAudioDeviceSet(this.callId, this.device);

  final String callId;
  final CallAudioDevice device;

  @override
  List<Object?> get props => [callId, device];
}

class _CallPerformEventAudioDevicesUpdate extends _CallPerformEvent {
  _CallPerformEventAudioDevicesUpdate(this.callId, this.devices);

  final String callId;
  final List<CallAudioDevice> devices;

  @override
  List<Object?> get props => [callId, devices];
}

// peer connection events

sealed class _PeerConnectionEvent extends CallEvent {
  const _PeerConnectionEvent();

  const factory _PeerConnectionEvent.signalingStateChanged(String callId, RTCSignalingState state) =
      _PeerConnectionEventSignalingStateChanged;

  const factory _PeerConnectionEvent.connectionStateChanged(String callId, RTCPeerConnectionState state) =
      _PeerConnectionEventConnectionStateChanged;

  const factory _PeerConnectionEvent.iceGatheringStateChanged(String callId, RTCIceGatheringState state) =
      _PeerConnectionEventIceGatheringStateChanged;

  const factory _PeerConnectionEvent.iceConnectionStateChanged(String callId, RTCIceConnectionState state) =
      _PeerConnectionEventIceConnectionStateChanged;

  const factory _PeerConnectionEvent.iceCandidateIdentified(String callId, RTCIceCandidate candidate) =
      _PeerConnectionEventIceCandidateIdentified;

  const factory _PeerConnectionEvent.streamAdded(String callId, MediaStream stream) = _PeerConnectionEventStreamAdded;

  const factory _PeerConnectionEvent.streamRemoved(String callId, MediaStream stream) =
      _PeerConnectionEventStreamRemoved;
}

class _PeerConnectionEventSignalingStateChanged extends _PeerConnectionEvent {
  const _PeerConnectionEventSignalingStateChanged(this.callId, this.state);

  final String callId;
  final RTCSignalingState state;

  @override
  List<Object?> get props => [callId, state];
}

class _PeerConnectionEventConnectionStateChanged extends _PeerConnectionEvent {
  const _PeerConnectionEventConnectionStateChanged(this.callId, this.state);

  final String callId;
  final RTCPeerConnectionState state;

  @override
  List<Object?> get props => [callId, state];
}

class _PeerConnectionEventIceGatheringStateChanged extends _PeerConnectionEvent {
  const _PeerConnectionEventIceGatheringStateChanged(this.callId, this.state);

  final String callId;
  final RTCIceGatheringState state;

  @override
  List<Object?> get props => [callId, state];
}

class _PeerConnectionEventIceConnectionStateChanged extends _PeerConnectionEvent {
  const _PeerConnectionEventIceConnectionStateChanged(this.callId, this.state);

  final String callId;
  final RTCIceConnectionState state;

  @override
  List<Object?> get props => [callId, state];
}

class _PeerConnectionEventIceCandidateIdentified extends _PeerConnectionEvent {
  const _PeerConnectionEventIceCandidateIdentified(this.callId, this.candidate);

  final String callId;
  final RTCIceCandidate candidate;

  @override
  List<Object?> get props => [callId, candidate];
}

class _PeerConnectionEventStreamAdded extends _PeerConnectionEvent {
  const _PeerConnectionEventStreamAdded(this.callId, this.stream);

  final String callId;
  final MediaStream stream;

  @override
  List<Object?> get props => [callId, stream];
}

class _PeerConnectionEventStreamRemoved extends _PeerConnectionEvent {
  const _PeerConnectionEventStreamRemoved(this.callId, this.stream);

  final String callId;
  final MediaStream stream;

  @override
  List<Object?> get props => [callId, stream];
}

// call screen events

sealed class CallScreenEvent extends CallEvent {
  const CallScreenEvent();

  const factory CallScreenEvent.didPush() = _CallScreenEventDidPush;

  const factory CallScreenEvent.didPop() = _CallScreenEventDidPop;
}

class _CallScreenEventDidPush extends CallScreenEvent {
  const _CallScreenEventDidPush();
}

class _CallScreenEventDidPop extends CallScreenEvent {
  const _CallScreenEventDidPop();
}
