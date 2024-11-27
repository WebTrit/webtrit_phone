part of 'recent_bloc.dart';

@freezed
class RecentState with _$RecentState {
  const factory RecentState({
    Recent? recent,
    List<CallLogEntry>? callLog,
  }) = _RecentState;
}
