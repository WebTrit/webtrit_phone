part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  const FavoritesState({this.favorites, this.refreshing = false});

  final List<FavoriteWithContact>? favorites;

  /// Whether a fetch asked for by hand is still running.
  ///
  /// The list is watched, so it redraws on its own and needs no flag. This one
  /// is for the spinner: without it a pull has nothing to wait on, and either
  /// ends the moment it starts or hangs when the fetch changes nothing.
  final bool refreshing;

  FavoritesState copyWith({List<FavoriteWithContact>? favorites, bool? refreshing}) {
    return FavoritesState(favorites: favorites ?? this.favorites, refreshing: refreshing ?? this.refreshing);
  }

  @override
  List<Object?> get props => [favorites, refreshing];
}
