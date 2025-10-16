part of 'call_log_bloc.dart';

abstract class CallLogEvent {
  const CallLogEvent();
}

class CallLogStarted extends CallLogEvent {
  const CallLogStarted();
}

@Freezed(copyWith: false)
abstract class CallLogEntryDeleted with _$CallLogEntryDeleted implements CallLogEvent {
  const factory CallLogEntryDeleted(CallLogEntry callLogEntry) = _CallLogEntryDeleted;
}
