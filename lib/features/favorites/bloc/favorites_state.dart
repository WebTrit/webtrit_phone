part of 'favorites_bloc.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    List<Favorite>? favorites,
  }) = _FavoritesState;
}
