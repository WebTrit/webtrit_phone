part of 'call_bloc.dart';

abstract class CallState extends Equatable {
  const CallState();

  @override
  List<Object?> get props => [];
}

class CallInitial extends CallState {
  const CallInitial();
}

class CallAttachInProgress extends CallState {
  const CallAttachInProgress();
}

class CallAttachFailure extends CallState {
  final String reason;

  const CallAttachFailure({
    required this.reason,
  });

  @override
  List<Object> get props => [
        reason,
      ];

  @override
  String toString() => 'CallAttachFailure { reason: $reason }';
}

class CallIdle extends CallState {
  const CallIdle();
}

abstract class CallActive extends CallState {
  final String callId;
  final String number;
  final bool video;
  final DateTime createdTime;
  final DateTime? acceptedTime;
  final DateTime? hungUpTime;
  final MediaStream? localStream;
  final MediaStream? remoteStream;

  const CallActive({
    required this.callId,
    required this.number,
    required this.video,
    required this.createdTime,
    this.acceptedTime,
    this.hungUpTime,
    this.localStream,
    this.remoteStream,
  });

  bool get accepted => acceptedTime != null;

  bool get hungUp => hungUpTime != null;

  @override
  List<Object?> get props => [
        callId,
        number,
        video,
        createdTime,
        acceptedTime,
        hungUpTime,
        localStream,
        remoteStream,
      ];

  @override
  String toString() => '$runtimeType { callId: $callId, number: $number, video: $video,'
      ' createdTime: $createdTime, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime,'
      ' with localStream: ${localStream != null}, with remoteStream: ${remoteStream != null} }';

  CallActive copyWith({
    String? number,
    bool? video,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  });
}

class CallIncoming extends CallActive {
  const CallIncoming({
    required String callId,
    required String number,
    required bool video,
    required DateTime createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) : super(
          callId: callId,
          number: number,
          video: video,
          createdTime: createdTime,
          acceptedTime: acceptedTime,
          hungUpTime: hungUpTime,
          localStream: localStream,
          remoteStream: remoteStream,
        );

  @override
  CallIncoming copyWith({
    String? callId,
    String? number,
    bool? video,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) {
    return CallIncoming(
      callId: callId ?? this.callId,
      number: number ?? this.number,
      video: video ?? this.video,
      createdTime: createdTime ?? this.createdTime,
      acceptedTime: acceptedTime ?? this.acceptedTime,
      hungUpTime: hungUpTime ?? this.hungUpTime,
      localStream: localStream ?? this.localStream,
      remoteStream: remoteStream ?? this.remoteStream,
    );
  }
}

class CallOutgoing extends CallActive {
  const CallOutgoing({
    required String callId,
    required String number,
    required bool video,
    required DateTime createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) : super(
          callId: callId,
          number: number,
          video: video,
          createdTime: createdTime,
          acceptedTime: acceptedTime,
          hungUpTime: hungUpTime,
          localStream: localStream,
          remoteStream: remoteStream,
        );

  @override
  CallOutgoing copyWith({
    String? callId,
    String? number,
    bool? video,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) {
    return CallOutgoing(
      callId: callId ?? this.callId,
      number: number ?? this.number,
      video: video ?? this.video,
      createdTime: createdTime ?? this.createdTime,
      acceptedTime: acceptedTime ?? this.acceptedTime,
      hungUpTime: hungUpTime ?? this.hungUpTime,
      localStream: localStream ?? this.localStream,
      remoteStream: remoteStream ?? this.remoteStream,
    );
  }
}

class CallFailure extends CallState {
  final String reason;

  const CallFailure({
    required this.reason,
  });

  @override
  List<Object> get props => [reason];

  @override
  String toString() => '$runtimeType { reason: $reason }';
}
