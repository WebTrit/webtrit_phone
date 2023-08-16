part of 'call_bloc.dart';

@freezed
class CallState with _$CallState {
  const CallState._();

  const factory CallState({
    ConnectivityResult? currentConnectivityResult,
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
    } else if (lastSignalingDisconnectCode != null) {
      final code = SignalingDisconnectCode.values.byCode(lastSignalingDisconnectCode);
      switch (code) {
        case SignalingDisconnectCode.appUnregisteredError:
          return CallStatus.appUnregistered;
        default:
          return CallStatus.connectIssue;
      }
    } else if (signalingClientStatus == SignalingClientStatus.connect) {
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
      return CallDisplay.none;
    } else {
      if (minimized == true) {
        return CallDisplay.overlay;
      } else {
        return CallDisplay.screen;
      }
    }
  }

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

  FutureOr<T>? performOnActiveCall<T>(UuidValue uuid, FutureOr<T>? Function(ActiveCall element) perform) {
    for (var activeCall in activeCalls) {
      if (activeCall.callId.uuid == uuid) {
        return perform(activeCall);
      }
    }
    return null;
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
    return copyWith(activeCalls: activeCalls, minimized: activeCalls.isEmpty ? null : minimized);
  }
}

@freezed
class ActiveCall with _$ActiveCall {
  ActiveCall._();

  factory ActiveCall({
    required Direction direction,
    required int line,
    required CallIdValue callId,
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
    Object? failure,
    required RTCVideoRenderers renderers,
  }) = _ActiveCall;

  bool get isIncoming => direction == Direction.incoming;

  bool get isOutgoing => direction == Direction.outgoing;

  bool get wasAccepted => acceptedTime != null;

  bool get wasHungUp => hungUpTime != null;
}

class RTCVideoRenderers {
  RTCVideoRenderers()
      : local = RTCVideoRenderer(),
        remote = RTCVideoRenderer();

  final RTCVideoRenderer local;
  final RTCVideoRenderer remote;

  Future<void> initialize() {
    return Future.wait([
      local.initialize(),
      remote.initialize(),
    ]);
  }

  Future<void> dispose() {
    return Future.wait([
      local.dispose(),
      remote.dispose(),
    ]);
  }
}
