import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CallState extends Equatable {
  const CallState();

  @override
  List<Object> get props => [];
}

class CallInitial extends CallState {
  const CallInitial();
}

class CallIncoming extends CallState {
  final String username;

  const CallIncoming({
    @required this.username,
  });
}

class CallHangUp extends CallState {
  final String reason;

  const CallHangUp({
    @required this.reason,
  });
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
