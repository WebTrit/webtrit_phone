part of 'call_bloc.dart';

enum SignalingClientStatus {
  disconnecting,
  disconnect,
  connecting,
  connect,
  failure,
}

extension SignalingClientStatusX on SignalingClientStatus {
  bool get isReady => this == SignalingClientStatus.connect;
}

@freezed
class CallState with _$CallState {
  const CallState._();

  const factory CallState({
    @Default(SignalingClientStatus.disconnect) SignalingClientStatus signalingClientStatus,
    Object? signalingFailure,
    @Default([]) List<ActiveCall> activeCalls,
  }) = _CallState;

  bool get isActive => activeCalls.isNotEmpty;

  ActiveCall get activeCall => activeCalls.last;

  ActiveCall? retrieveActiveCall(UuidValue uuid) {
    for (var activeCall in activeCalls) {
      if (activeCall.callId.uuid == uuid) {
        return activeCall;
      }
    }
    return null;
  }

  FutureOr<void>? performOnActiveCall(UuidValue uuid, FutureOr<void>? Function(ActiveCall element) perform) {
    for (var activeCall in activeCalls) {
      if (activeCall.callId.uuid == uuid) {
        return perform(activeCall);
      }
    }
  }

  CallState copyWithMappedActiveCall(UuidValue uuid, ActiveCall Function(ActiveCall element) map) {
    final activeCalls = this.activeCalls.map((activeCall) {
      if (activeCall.callId.uuid == uuid) {
        return map(activeCall);
      } else {
        return activeCall;
      }
    }).toList();
    return copyWith(activeCalls: activeCalls);
  }

  CallState copyWithPushActiveCall(ActiveCall activeCall) {
    final activeCalls = List<ActiveCall>.from(this.activeCalls)..add(activeCall);
    return copyWith(activeCalls: activeCalls);
  }

  CallState copyWithPopActiveCall(UuidValue uuid) {
    final activeCalls = this.activeCalls.where((activeCall) {
      return activeCall.callId.uuid != uuid;
    }).toList();
    return copyWith(activeCalls: activeCalls);
  }
}

@freezed
class ActiveCall with _$ActiveCall {
  const ActiveCall._();

  const factory ActiveCall({
    required Direction direction,
    required CallIdValue callId,
    required CallkeepHandle handle,
    String? displayName,
    required bool video,
    @Default(false) bool held,
    @Default(false) bool muted,
    required DateTime createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    Object? failure,
    MediaStream? localStream,
    MediaStream? remoteStream,
    RTCPeerConnection? peerConnection,
  }) = _ActiveCall;

  bool get isIncoming => direction == Direction.incoming;

  bool get isOutgoing => direction == Direction.outgoing;

  bool get wasAccepted => acceptedTime != null;

  bool get wasHungUp => hungUpTime != null;
}
