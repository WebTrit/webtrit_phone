part of 'favorites_bloc.dart';

abstract class FavoritesEvent {
  const FavoritesEvent();
}

@Freezed(copyWith: false)
class FavoritesStarted with _$FavoritesStarted implements FavoritesEvent {
  const factory FavoritesStarted() = _FavoritesStarted;
}

@Freezed(copyWith: false)
abstract class FavoritesAddedByContactPhoneId with _$FavoritesAddedByContactPhoneId implements FavoritesEvent {
  const factory FavoritesAddedByContactPhoneId({
    required int contactPhoneId,
  }) = _FavoritesAddedByContactPhoneId;
}

@Freezed(copyWith: false)
abstract class FavoritesRemovedByContactPhoneId with _$FavoritesRemovedByContactPhoneId implements FavoritesEvent {
  const factory FavoritesRemovedByContactPhoneId({
    required int contactPhoneId,
  }) = _FavoritesRemovedByContactPhoneId;
}

@Freezed(copyWith: false)
abstract class FavoritesRemoved with _$FavoritesRemoved implements FavoritesEvent {
  const factory FavoritesRemoved({
    required Favorite favorite,
  }) = _FavoritesRemoved;
}
