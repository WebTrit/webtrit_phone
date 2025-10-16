part of 'favorites_bloc.dart';

@freezed
abstract class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    List<Favorite>? favorites,
  }) = _FavoritesState;
}
