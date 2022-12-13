part of 'recent_bloc.dart';

abstract class RecentEvent {
  const RecentEvent();
}

class RecentStarted extends RecentEvent {
  const RecentStarted();
}

@Freezed(copyWith: false)
class RecentDeleted with _$RecentDeleted implements RecentEvent {
  const factory RecentDeleted(Recent recent) = _RecentDeleted;
}
