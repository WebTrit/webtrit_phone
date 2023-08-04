part of 'recents_bloc.dart';

@freezed
class RecentsState with _$RecentsState {
  const RecentsState._();

  const factory RecentsState({
    List<Recent>? recents,
    required RecentsVisibilityFilter filter,
  }) = _RecentsState;

  List<Recent>? get recentsFiltered {
    return recents?.where((recent) {
      if (filter == RecentsVisibilityFilter.missed) {
        return !recent.isComplete && recent.direction == Direction.incoming;
      } else if (filter == RecentsVisibilityFilter.incoming) {
        return recent.direction == Direction.incoming;
      } else if (filter == RecentsVisibilityFilter.outgoing) {
        return recent.direction == Direction.outgoing;
      } else {
        return true;
      }
    }).toList();
  }
}
