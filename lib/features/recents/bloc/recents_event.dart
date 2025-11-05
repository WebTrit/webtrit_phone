part of 'recents_bloc.dart';

sealed class RecentsEvent extends Equatable {
  const RecentsEvent();

  @override
  List<Object> get props => [];
}

class RecentsStarted extends RecentsEvent {
  const RecentsStarted();
}

class RecentsFiltered extends RecentsEvent {
  const RecentsFiltered(this.filter);

  final RecentsVisibilityFilter filter;

  @override
  List<Object> get props => [filter];
}

class RecentsDeleted extends RecentsEvent {
  const RecentsDeleted(this.recent);

  final Recent recent;

  @override
  List<Object> get props => [recent];
}
