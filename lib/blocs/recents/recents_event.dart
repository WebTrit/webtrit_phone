part of 'recents_bloc.dart';

abstract class RecentsEvent extends Equatable {
  const RecentsEvent();

  @override
  List<Object> get props => [];
}

class RecentsInitialLoaded extends RecentsEvent {
  const RecentsInitialLoaded();
}

class RecentsUpdated extends RecentsEvent {
  final List<Recent> recents;

  const RecentsUpdated({
    required this.recents,
  });

  @override
  List<Object> get props => [
        recents,
      ];
}

class RecentsAdd extends RecentsEvent {
  final Recent recent;

  const RecentsAdd({
    required this.recent,
  });

  @override
  List<Object> get props => [
        recent,
      ];
}

class RecentsDelete extends RecentsEvent {
  final Recent recent;

  const RecentsDelete({
    required this.recent,
  });

  @override
  List<Object> get props => [
        recent,
      ];
}
