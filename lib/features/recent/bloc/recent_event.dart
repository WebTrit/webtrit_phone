part of 'recent_bloc.dart';

abstract class RecentEvent {
  const RecentEvent();
}

class RecentStarted extends RecentEvent {
  const RecentStarted();
}

@Freezed(copyWith: false)
class CallLogEntryDeleted with _$CallLogEntryDeleted implements RecentEvent {
  const factory CallLogEntryDeleted(CallLogEntry callLogEntry) = _CallLogEntryDeleted;
}
