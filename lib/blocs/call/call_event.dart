import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/webrtc.dart';

@immutable
abstract class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object> get props => [];
}

class CallIncomingReceived extends CallEvent {
  final String username;
  final Map<String, dynamic> jsepData;

  const CallIncomingReceived({
    @required this.username,
    this.jsepData,
  });

  @override
  List<Object> get props => [username, jsepData];

  @override
  String toString() => '$runtimeType { username: $username, with jsep: ${jsepData != null} }';
}

class CallIncomingAccepted extends CallEvent {
  const CallIncomingAccepted();
}

class CallOutgoingStarted extends CallEvent {
  final String username;

  const CallOutgoingStarted({
    @required this.username,
  });

  @override
  List<Object> get props => [username];

  @override
  String toString() => '$runtimeType { username: $username }';
}

class CallOutgoingAccepted extends CallEvent {
  final String username;
  final Map<String, dynamic> jsepData;

  const CallOutgoingAccepted({
    @required this.username,
    this.jsepData,
  });

  @override
  List<Object> get props => [username, jsepData];

  @override
  String toString() => '$runtimeType { username: $username, with jsep: ${jsepData != null} }';
}

abstract class CallHungUp extends CallEvent {
  final String reason;

  const CallHungUp({
    @required this.reason,
  });

  @override
  List<Object> get props => [reason];

  @override
  String toString() => '$runtimeType { reason: $reason }';
}

class CallRemoteHungUp extends CallHungUp {
  const CallRemoteHungUp({
    @required String reason,
  }) : super(reason: reason);
}

class CallLocalHungUp extends CallHungUp {
  const CallLocalHungUp({
    @required String reason,
  }) : super(reason: reason);
}

class CallRemoteStreamAdded extends CallEvent {
  final MediaStream stream;

  const CallRemoteStreamAdded({
    this.stream,
  });

  @override
  List<Object> get props => [stream];
}

class CallRemoteStreamRemoved extends CallEvent {
  final MediaStream stream;

  const CallRemoteStreamRemoved({
    this.stream,
  });

  @override
  List<Object> get props => [stream];
}
