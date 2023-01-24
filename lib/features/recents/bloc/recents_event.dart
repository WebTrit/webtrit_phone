part of 'recents_bloc.dart';

abstract class RecentsEvent {
  const RecentsEvent();
}

class RecentsStarted extends RecentsEvent {
  const RecentsStarted();
}

@Freezed(copyWith: false)
class RecentsDeleted with _$RecentsDeleted implements RecentsEvent {
  const factory RecentsDeleted(Recent recent) = _RecentsDeleted;
}
