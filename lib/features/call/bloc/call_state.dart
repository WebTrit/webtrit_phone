part of 'call_bloc.dart';

@freezed
class CallState with _$CallState {
  const CallState({
    this.callServiceState = const CallServiceState(),
    this.currentAppLifecycleState,
    this.linesCount = 0,
    this.activeCalls = const [],
    this.minimized,
    this.speakerOnBeforeMinimize,
    this.audioDevice,
    this.availableAudioDevices = const [],
  });

  @override
  final CallServiceState callServiceState;
  @override
  final AppLifecycleState? currentAppLifecycleState;
  @override
  final int linesCount;
  @override
  final List<ActiveCall> activeCalls;
  @override
  final bool? minimized;
  @override
  final bool? speakerOnBeforeMinimize;
  @override
  final CallAudioDevice? audioDevice;
  @override
  final List<CallAudioDevice> availableAudioDevices;

  CallStatus get status => callServiceState.status;

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

  CallState copyWithPushActiveCall(ActiveCall activeCall) {
    return copyWith(activeCalls: [...activeCalls, activeCall]);
  }

  CallState copyWithPopActiveCall(String callId) {
    final activeCalls = this.activeCalls.where((activeCall) {
      return activeCall.callId != callId;
    }).toList();
    return copyWith(activeCalls: activeCalls, minimized: activeCalls.isEmpty ? null : minimized);
  }
}

@freezed
class ActiveCall with _$ActiveCall implements CallEntry {
  ActiveCall({
    required this.direction,
    required this.line,
    required this.callId,
    required this.handle,
    required this.createdTime,
    required this.video,
    required this.processingStatus,
    this.frontCamera = true,
    this.held = false,
    this.muted = false,
    this.updating = false,
    this.incomingOffer,
    this.displayName,
    this.fromReferId,
    this.fromReplaces,
    this.fromNumber,
    this.acceptedTime,
    this.hungUpTime,
    this.transfer,
    this.failure,
    this.localStream,
    this.remoteStream,
  });

  @override
  final CallDirection direction;
  @override
  final int? line;
  @override
  final String callId;
  @override
  final CallkeepHandle handle;
  @override
  final DateTime createdTime;
  @override
  final bool video;
  @override
  final CallProcessingStatus processingStatus;
  @override
  final bool? frontCamera;
  @override
  final bool held;
  @override
  final bool muted;
  @override
  final bool updating;
  @override
  final JsepValue? incomingOffer;
  @override
  final String? displayName;
  @override
  final String? fromReferId;
  @override
  final String? fromReplaces;
  @override
  final String? fromNumber;
  @override
  final DateTime? acceptedTime;
  @override
  final DateTime? hungUpTime;
  @override
  final Transfer? transfer;
  @override
  final Object? failure;
  @override
  final MediaStream? localStream;
  @override
  final MediaStream? remoteStream;

  @override
  bool get isIncoming => direction == CallDirection.incoming;

  @override
  bool get isOutgoing => direction == CallDirection.outgoing;

  @override
  bool get wasAccepted => acceptedTime != null;

  @override
  bool get wasHungUp => hungUpTime != null;

  bool get remoteVideo => remoteStream?.getVideoTracks().isNotEmpty ?? video;

  bool get localVideo => localStream?.getVideoTracks().isNotEmpty ?? false;

  bool get cameraEnabled => localStream?.getVideoTracks().firstOrNull?.enabled == true;
}

extension ActiveCallIterableExtension<T extends ActiveCall> on Iterable<T> {
  T get current => lastWhere((activeCall) => !activeCall.held, orElse: () => last);

  List<T> get nonCurrent => where((activeCall) => activeCall != current).toList();

  T? get blindTransferInitiated => firstWhereOrNull((activeCall) => activeCall.transfer is BlindTransferInitiated);
}

enum CallAudioDeviceType { earpiece, speaker, bluetooth, wiredHeadset, streaming, unknown }

@freezed
class CallAudioDevice with _$CallAudioDevice {
  CallAudioDevice({
    required this.type,
    this.id,
    this.name,
  });

  @override
  final CallAudioDeviceType type;
  @override
  final String? id;
  @override
  final String? name;

  factory CallAudioDevice.fromMediaInput(MediaDeviceInfo device) {
    return CallAudioDevice(
      type: switch (device.groupId) {
        'MicrophoneBuiltIn' => CallAudioDeviceType.earpiece,
        'MicrophoneWired' || 'LineIn' || 'USBAudio' => CallAudioDeviceType.wiredHeadset,
        'BluetoothHFP' => CallAudioDeviceType.bluetooth,
        'CarAudio' => CallAudioDeviceType.streaming,
        _ => CallAudioDeviceType.unknown,
      },
      name: device.label,
      id: device.deviceId,
    );
  }

  factory CallAudioDevice.fromMediaOutput(MediaDeviceInfo device) {
    return CallAudioDevice(
      type: switch (device.groupId) {
        'Speaker' => CallAudioDeviceType.speaker,
        'Receiver' => CallAudioDeviceType.earpiece,
        'BluetoothA2DPOutput' || 'BluetoothHFP' || 'BluetoothLE' => CallAudioDeviceType.bluetooth,
        'Headphones' || 'LineOut' || 'USBAudio' => CallAudioDeviceType.wiredHeadset,
        'CarAudio' => CallAudioDeviceType.streaming,
        _ => CallAudioDeviceType.unknown,
      },
      name: device.label,
      id: device.deviceId,
    );
  }

  factory CallAudioDevice.fromCallkeep(CallkeepAudioDevice device) {
    return CallAudioDevice(
      type: CallAudioDeviceType.values.byName(device.type.name),
      id: device.id,
      name: device.name,
    );
  }

  CallkeepAudioDevice toCallkeep() {
    return CallkeepAudioDevice(
      type: CallkeepAudioDeviceType.values.byName(type.name),
      id: id,
      name: name,
    );
  }
}

extension CallAudioDeviceIterableExtension<T extends CallAudioDevice> on Iterable<T> {
  bool get onlyBuiltIn => every(
        (device) => device.type == CallAudioDeviceType.earpiece || device.type == CallAudioDeviceType.speaker,
      );

  T get getSpeaker => firstWhere((device) => device.type == CallAudioDeviceType.speaker);
  T get getEarpiece => firstWhere((device) => device.type == CallAudioDeviceType.earpiece);
}
