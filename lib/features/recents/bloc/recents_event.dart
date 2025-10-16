part of 'recents_bloc.dart';

abstract class RecentsEvent {
  const RecentsEvent();
}

class RecentsStarted extends RecentsEvent {
  const RecentsStarted();
}

@Freezed(copyWith: false)
abstract class RecentsFiltered with _$RecentsFiltered implements RecentsEvent {
  const factory RecentsFiltered(RecentsVisibilityFilter filter) = _RecentsFiltered;
}

@Freezed(copyWith: false)
abstract class RecentsDeleted with _$RecentsDeleted implements RecentsEvent {
  const factory RecentsDeleted(Recent recent) = _RecentsDeleted;
}
