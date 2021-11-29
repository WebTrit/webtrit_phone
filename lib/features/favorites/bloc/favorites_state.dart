part of 'favorites_bloc.dart';

enum FavoritesStatus {
  initial,
  inProgress,
  success,
  failure,
}

class FavoritesState extends Equatable {
  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.favorites = const [],
  });

  final FavoritesStatus status;
  final List<Favorite> favorites;

  @override
  List<Object> get props => [
    status,
    favorites,
  ];

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<Favorite>? favorites,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
    );
  }
}
