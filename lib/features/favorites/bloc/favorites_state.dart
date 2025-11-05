part of 'favorites_bloc.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const FavoritesState({this.favorites});

  @override
  final List<Favorite>? favorites;
}
