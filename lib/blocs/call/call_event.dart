import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object> get props => [];
}

class CallReceived extends CallEvent {
  final String username;

  const CallReceived({
    @required this.username,
  });

  @override
  List<Object> get props => [username];

  @override
  String toString() => '$runtimeType { username: $username }';
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

class CallHungUpRemote extends CallHungUp {
  const CallHungUpRemote({
    @required reason,
  }) : super(reason: reason);
}

class CallHungUpLocal extends CallHungUp {
  const CallHungUpLocal({
    @required reason,
  }) : super(reason: reason);
}
