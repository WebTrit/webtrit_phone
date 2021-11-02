part of 'recents_bloc.dart';

abstract class RecentsState extends Equatable {
  const RecentsState();

  @override
  List<Object> get props => [];
}

class RecentsInitial extends RecentsState {
  const RecentsInitial();
}

class RecentsLoadSuccess extends RecentsState {
  final List<Recent> recents;

  const RecentsLoadSuccess({
    required this.recents,
  });

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}

class RecentsLoadFailure extends RecentsState {
  const RecentsLoadFailure();

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}
