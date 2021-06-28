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
  CallAttachInProgress();
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
  final String number;
  final bool video;
  final bool accepted;
  final bool hungUp;
  final DateTime? createdTime;
  final DateTime? acceptedTime;
  final DateTime? hungUpTime;
  final MediaStream? localStream;
  final MediaStream? remoteStream;

  const CallActive({
    required this.number,
    required this.video,
    this.accepted = false,
    this.hungUp = false,
    this.createdTime,
    this.acceptedTime,
    this.hungUpTime,
    this.localStream,
    this.remoteStream,
  }) : assert(createdTime != null);

  @override
  List<Object?> get props => [
        number,
        video,
        accepted,
        hungUp,
        createdTime,
        acceptedTime,
        hungUpTime,
        localStream,
        remoteStream,
      ];

  @override
  String toString() => '$runtimeType { number: $number, video: $video, accepted: $accepted,'
      ' hungUp: $hungUp, createdTime: $createdTime, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime,'
      ' with localStream: ${localStream != null}, with remoteStream: ${remoteStream != null} }';

  CallActive copyWith({
    String? number,
    bool? video,
    bool? accepted,
    bool? hungUp,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  });
}

class CallIncoming extends CallActive {
  const CallIncoming({
    required String number,
    required bool video,
    bool accepted = false,
    bool hungUp = false,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) : super(
          number: number,
          video: video,
          accepted: accepted,
          hungUp: hungUp,
          createdTime: createdTime,
          acceptedTime: acceptedTime,
          hungUpTime: hungUpTime,
          localStream: localStream,
          remoteStream: remoteStream,
        );

  @override
  CallIncoming copyWith({
    String? number,
    bool? video,
    bool? accepted,
    bool? hungUp,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) {
    return CallIncoming(
      number: number ?? this.number,
      video: video ?? this.video,
      accepted: accepted ?? this.accepted,
      hungUp: hungUp ?? this.hungUp,
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
    required String number,
    required bool video,
    bool accepted = false,
    bool hungUp = false,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) : super(
          number: number,
          video: video,
          accepted: accepted,
          hungUp: hungUp,
          createdTime: createdTime,
          acceptedTime: acceptedTime,
          hungUpTime: hungUpTime,
          localStream: localStream,
          remoteStream: remoteStream,
        );

  @override
  CallOutgoing copyWith({
    String? number,
    bool? video,
    bool? accepted,
    bool? hungUp,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) {
    return CallOutgoing(
      number: number ?? this.number,
      video: video ?? this.video,
      accepted: accepted ?? this.accepted,
      hungUp: hungUp ?? this.hungUp,
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
