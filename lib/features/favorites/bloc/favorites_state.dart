part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  const FavoritesState({this.favorites});

  final List<FavoriteWithContact>? favorites;

  @override
  List<Object?> get props => [favorites];
}
