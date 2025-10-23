part of 'call_log_bloc.dart';

sealed class CallLogEvent {
  const CallLogEvent();
}

class CallLogStarted extends CallLogEvent {
  const CallLogStarted();
}

class CallLogEntryDeleted extends CallLogEvent {
  const CallLogEntryDeleted(this.callLogEntry);

  final CallLogEntry callLogEntry;
}