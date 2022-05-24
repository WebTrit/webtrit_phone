part of 'call_bloc.dart';

abstract class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object?> get props => [];
}

class CallStarted extends CallEvent {
  const CallStarted();
}

abstract class _SignalingClientEvent extends CallEvent {
  const _SignalingClientEvent();
}

class _SignalingClientConnectInitiated extends _SignalingClientEvent {
  const _SignalingClientConnectInitiated();
}

class _SignalingClientDisconnectInitiated extends _SignalingClientEvent {
  const _SignalingClientDisconnectInitiated();
}

class CallIncomingReceived extends CallEvent {
  final String callId;
  final String username;
  final Map<String, dynamic>? jsepData;

  const CallIncomingReceived({
    required this.callId,
    required this.username,
    this.jsepData,
  });

  @override
  List<Object?> get props => [callId, username, jsepData];

  @override
  String toString() => '$runtimeType { callId: $callId, username: $username, with jsep: ${jsepData != null} }';
}

class CallIncomingAccepted extends CallEvent {
  const CallIncomingAccepted();
}

class CallOutgoingStarted extends CallEvent {
  const CallOutgoingStarted({
    required this.number,
    required this.video,
  });

  final String number;
  final bool video;

  @override
  List<Object?> get props => [
        number,
        video,
      ];

  @override
  String toString() => '$runtimeType { number: $number, video: $video }';
}

class CallOutgoingAccepted extends CallEvent {
  final String username;
  final Map<String, dynamic>? jsepData;

  const CallOutgoingAccepted({
    required this.username,
    this.jsepData,
  });

  @override
  List<Object?> get props => [username, jsepData];

  @override
  String toString() => '$runtimeType { username: $username, with jsep: ${jsepData != null} }';
}

abstract class CallHungUp extends CallEvent {
  final String? reason;

  const CallHungUp({
    required this.reason,
  });

  @override
  List<Object?> get props => [reason];

  @override
  String toString() => '$runtimeType { reason: $reason }';
}

class CallRemoteHungUp extends CallHungUp {
  const CallRemoteHungUp({
    required String? reason,
  }) : super(reason: reason);
}

class CallLocalHungUp extends CallHungUp {
  const CallLocalHungUp({
    required String reason,
  }) : super(reason: reason);
}

class _RemoteStreamAdded extends CallEvent {
  final MediaStream stream;

  const _RemoteStreamAdded({
    required this.stream,
  });

  @override
  List<Object?> get props => [stream];
}

class _RemoteStreamRemoved extends CallEvent {
  final MediaStream stream;

  const _RemoteStreamRemoved({
    required this.stream,
  });

  @override
  List<Object?> get props => [stream];
}

class CallCameraSwitched extends CallEvent {
  const CallCameraSwitched();
}

class CallCameraEnabled extends CallEvent {
  final bool mode;

  const CallCameraEnabled(this.mode);
}

class CallMicrophoneEnabled extends CallEvent {
  final bool mode;

  const CallMicrophoneEnabled(this.mode);
}

class CallSpeakerphoneEnabled extends CallEvent {
  final bool mode;

  const CallSpeakerphoneEnabled(this.mode);
}

class CallFailureApproved extends CallEvent {
  const CallFailureApproved();
}

class _AppLifecycleStateChanged extends CallEvent {
  const _AppLifecycleStateChanged(this.state);

  final AppLifecycleState state;
}

class _ConnectivityResultChanged extends CallEvent {
  const _ConnectivityResultChanged(this.result);

  final ConnectivityResult result;
}
