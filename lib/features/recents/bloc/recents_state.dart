part of 'recents_bloc.dart';

@freezed
class RecentsState with _$RecentsState {
  const RecentsState({
    this.recents,
    required this.filter,
  });

  @override
  final List<Recent>? recents;
  @override
  final RecentsVisibilityFilter filter;

  List<Recent>? get recentsFiltered {
    return recents?.where((recent) {
      final callLogEntry = recent.callLogEntry;

      if (filter == RecentsVisibilityFilter.missed) {
        return !callLogEntry.isComplete && callLogEntry.direction == CallDirection.incoming;
      } else if (filter == RecentsVisibilityFilter.incoming) {
        return callLogEntry.direction == CallDirection.incoming;
      } else if (filter == RecentsVisibilityFilter.outgoing) {
        return callLogEntry.direction == CallDirection.outgoing;
      } else {
        return true;
      }
    }).toList();
  }

  @override
  String toString() {
    return 'RecentsState { recents: ${recents?.length ?? 0} items, filter: $filter }';
  }
}
