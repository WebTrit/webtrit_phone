part of 'call_bloc.dart';

abstract class CallState extends Equatable {
  const CallState();

  @override
  List<Object?> get props => [];
}

class CallIdle extends CallState {
  const CallIdle();
}

abstract class CallActive extends CallState {
  final String username;
  final bool accepted;
  final bool hungUp;
  final DateTime? createdTime;
  final DateTime? acceptedTime;
  final DateTime? hungUpTime;
  final MediaStream? localStream;
  final MediaStream? remoteStream;

  const CallActive({
    required this.username,
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
        username,
        accepted,
        hungUp,
        createdTime,
        acceptedTime,
        hungUpTime,
        localStream,
        remoteStream,
      ];

  @override
  String toString() => '$runtimeType { username: $username, accepted: $accepted,'
      ' hungUp: $hungUp, createdTime: $createdTime, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime,'
      ' with localStream: ${localStream != null}, with remoteStream: ${remoteStream != null} }';

  CallActive copyWith({
    String? username,
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
    required String username,
    bool accepted = false,
    bool hungUp = false,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) : super(
          username: username,
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
    String? username,
    bool? accepted,
    bool? hungUp,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) {
    return CallIncoming(
      username: username ?? this.username,
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
    required String username,
    bool accepted = false,
    bool hungUp = false,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) : super(
          username: username,
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
    String? username,
    bool? accepted,
    bool? hungUp,
    DateTime? createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) {
    return CallOutgoing(
      username: username ?? this.username,
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
