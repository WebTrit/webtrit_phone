part of 'recents_bloc.dart';

sealed class RecentsEvent {
  const RecentsEvent();
}

class RecentsStarted extends RecentsEvent {
  const RecentsStarted();
}

class RecentsFiltered extends RecentsEvent {
  const RecentsFiltered(this.filter);

  final RecentsVisibilityFilter filter;
}

class RecentsDeleted extends RecentsEvent {
  const RecentsDeleted(this.recent);

  final Recent recent;
}