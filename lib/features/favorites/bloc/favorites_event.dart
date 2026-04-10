part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesStarted extends FavoritesEvent {
  const FavoritesStarted();
}

class FavoritesRemoved extends FavoritesEvent {
  const FavoritesRemoved({required this.favorite});

  final Favorite favorite;

  @override
  List<Object?> get props => [favorite];
}

class FavoritesShifted extends FavoritesEvent {
  const FavoritesShifted({required this.favorite, required this.position});

  final Favorite favorite;
  final int position;

  @override
  List<Object?> get props => [favorite, position];
}
