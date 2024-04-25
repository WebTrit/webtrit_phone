part of 'call_bloc.dart';

@freezed
class CallState with _$CallState {
  const CallState._();

  const factory CallState({
    ConnectivityResult? currentConnectivityResult,
    @Default(RegistrationStatus.registering) RegistrationStatus registrationStatus,
    @Default(SignalingClientStatus.disconnect) SignalingClientStatus signalingClientStatus,
    Object? lastSignalingClientConnectError,
    Object? lastSignalingClientDisconnectError,
    int? lastSignalingDisconnectCode,
    @Default(0) int linesCount,
    @Default([]) List<ActiveCall> activeCalls,
    bool? minimized,
    bool? speaker,
  }) = _CallState;

  CallStatus get status {
    final lastSignalingDisconnectCode = this.lastSignalingDisconnectCode;

    if (currentConnectivityResult == ConnectivityResult.none) {
      return CallStatus.connectivityNone;
    } else if (lastSignalingClientConnectError != null) {
      return CallStatus.connectError;
    } else if (registrationStatus.isUnregistered) {
      return CallStatus.appUnregistered;
    } else if (registrationStatus.isFailed) {
      return CallStatus.connectIssue;
    } else if (lastSignalingDisconnectCode != null) {
      return CallStatus.connectIssue;
    } else if (signalingClientStatus.isConnect && registrationStatus.isRegistered) {
      return CallStatus.ready;
    } else {
      return CallStatus.inProgress;
    }
  }

  int? retrieveIdleLine() {
    for (var line = 0; line < linesCount; line++) {
      if (!activeCalls.any((activeCall) => activeCall.line == line)) {
        return line;
      }
    }
    return null;
  }

  CallDisplay get display {
    if (activeCalls.isEmpty) {
      if (minimized == false) {
        return CallDisplay.noneScreen;
      } else {
        return CallDisplay.none;
      }
    } else {
      if (minimized == true) {
        return CallDisplay.overlay;
      } else {
        return CallDisplay.screen;
      }
    }
  }

  bool get isActive => activeCalls.isNotEmpty;

  bool get isVoiceChat => activeCalls.current.video == false;

  bool get isBlingTransferInitiated => activeCalls.blindTransferInitiated != null;

  bool get shouldListenToProximity => isActive && isVoiceChat && minimized != true;

  ActiveCall? retrieveActiveCall(String callId) {
    for (var activeCall in activeCalls) {
      if (activeCall.callId == callId) {
        return activeCall;
      }
    }
    return null;
  }

  FutureOr<T>? performOnActiveCall<T>(String callId, FutureOr<T>? Function(ActiveCall element) perform) {
    for (var activeCall in activeCalls) {
      if (activeCall.callId == callId) {
        return perform(activeCall);
      }
    }
    return null;
  }

  CallState copyWithMappedActiveCalls(ActiveCall Function(ActiveCall element) map) {
    final activeCalls = this.activeCalls.map(map).toList();
    return copyWith(activeCalls: activeCalls);
  }

  CallState copyWithMappedActiveCall(String callId, ActiveCall Function(ActiveCall element) map) {
    final activeCalls = this.activeCalls.map((activeCall) {
      if (activeCall.callId == callId) {
        return map(activeCall);
      } else {
        return activeCall;
      }
    }).toList();
    return copyWith(activeCalls: activeCalls);
  }

  CallState copyWithPushActiveCall(ActiveCall activeCall, {bool? minimized}) {
    final activeCalls = List<ActiveCall>.from(this.activeCalls)..add(activeCall);
    return copyWith(activeCalls: activeCalls, minimized: minimized ?? this.minimized);
  }

  CallState copyWithPopActiveCall(String callId) {
    final activeCalls = this.activeCalls.where((activeCall) {
      return activeCall.callId != callId;
    }).toList();
    return copyWith(activeCalls: activeCalls, minimized: activeCalls.isEmpty ? null : minimized);
  }
}

@freezed
class ActiveCall with _$ActiveCall {
  ActiveCall._();

  factory ActiveCall({
    required Direction direction,
    required int line,
    required String callId,
    required CallkeepHandle handle,
    String? displayName,
    required bool video,
    @Default(true) bool? frontCamera,
    @Default(false) bool held,
    @Default(false) bool muted,
    @Default(false) bool updating,
    required DateTime createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    Transfer? transfer,
    Object? failure,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) = _ActiveCall;

  bool get isIncoming => direction == Direction.incoming;

  bool get isOutgoing => direction == Direction.outgoing;

  bool get wasAccepted => acceptedTime != null;

  bool get wasHungUp => hungUpTime != null;
}

extension ActiveCallIterableExtension<T extends ActiveCall> on Iterable<T> {
  T get current => lastWhere((activeCall) => !activeCall.held, orElse: () => last);
  List<T> get exceptCurrent => where((activeCall) => activeCall != current).toList();

  T? get blindTransferInitiated {
    try {
      return firstWhere((activeCall) {
        final transfer = activeCall.transfer;
        if (transfer == null) {
          return false;
        } else {
          return transfer.isBlind && transfer.isInitiated;
        }
      });
    } on StateError catch (_) {
      return null;
    }
  }
}
