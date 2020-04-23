import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/webrtc.dart';

@immutable
abstract class CallState extends Equatable {
  const CallState();

  @override
  List<Object> get props => [];
}

class CallIdle extends CallState {
  const CallIdle();
}

abstract class CallActive extends CallState {
  final String username;
  final bool accepted;
  final bool hungUp;

  final MediaStream localStream;
  final MediaStream remoteStream;

  const CallActive({
    @required this.username,
    this.accepted = false,
    this.hungUp = false,
    this.localStream,
    this.remoteStream,
  })  : assert(username != null),
        assert(accepted != null),
        assert(hungUp != null);

  @override
  List<Object> get props => [username, accepted, localStream, remoteStream];

  @override
  String toString() =>
      '$runtimeType { username: $username, accepted: $accepted, with localStream: ${localStream != null}, with remoteStream: ${remoteStream != null} }';

  CallActive copyWith({
    String username,
    bool accepted,
    bool hungUp,
    MediaStream localStream,
    MediaStream remoteStream,
  });
}

class CallIncoming extends CallActive {
  const CallIncoming({
    @required String username,
    bool accepted = false,
    bool hungUp = false,
    localStream,
    remoteStream,
  }) : super(
          username: username,
          accepted: accepted,
          hungUp: hungUp,
          localStream: localStream,
          remoteStream: remoteStream,
        );

  @override
  CallIncoming copyWith({
    @required String username,
    bool accepted,
    bool hungUp,
    MediaStream localStream,
    MediaStream remoteStream,
  }) {
    return CallIncoming(
      username: username ?? this.username,
      accepted: accepted ?? this.accepted,
      hungUp: hungUp ?? this.hungUp,
      localStream: localStream ?? this.localStream,
      remoteStream: remoteStream ?? this.remoteStream,
    );
  }
}

class CallOutgoing extends CallActive {
  const CallOutgoing({
    @required String username,
    bool accepted = false,
    bool hungUp = false,
    localStream,
    remoteStream,
  }) : super(
          username: username,
          accepted: accepted,
          hungUp: hungUp,
          localStream: localStream,
          remoteStream: remoteStream,
        );

  @override
  CallOutgoing copyWith({
    String username,
    bool accepted,
    bool hungUp,
    MediaStream localStream,
    MediaStream remoteStream,
  }) {
    return CallOutgoing(
      username: username ?? this.username,
      accepted: accepted ?? this.accepted,
      hungUp: hungUp ?? this.hungUp,
      localStream: localStream ?? this.localStream,
      remoteStream: remoteStream ?? this.remoteStream,
    );
  }
}

class CallFailure extends CallState {
  final String reason;

  const CallFailure({
    @required this.reason,
  });

  @override
  List<Object> get props => [reason];

  @override
  String toString() => '$runtimeType { reason: $reason }';
}
