part of 'call_log_bloc.dart';

sealed class CallLogEvent extends Equatable {
  const CallLogEvent();

  @override
  List<Object> get props => [];
}

class CallLogStarted extends CallLogEvent {
  const CallLogStarted();
}

class CallLogEntryDeleted extends CallLogEvent {
  const CallLogEntryDeleted(this.callLogEntry);

  final CallLogEntry callLogEntry;

  @override
  List<Object> get props => [
        EquatablePropToString([callLogEntry], listPropToString),
      ];
}
