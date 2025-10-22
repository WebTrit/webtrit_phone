part of 'favorites_bloc.dart';

sealed class FavoritesEvent {
  const FavoritesEvent();
}

class FavoritesStarted extends FavoritesEvent {
  const FavoritesStarted();
}

class FavoritesAddedByContactPhoneId extends FavoritesEvent {
  const FavoritesAddedByContactPhoneId({
    required this.contactPhoneId,
  });
  final int contactPhoneId;
}

class FavoritesRemovedByContactPhoneId extends FavoritesEvent {
  const FavoritesRemovedByContactPhoneId({
    required this.contactPhoneId,
  });
  final int contactPhoneId;
}

class FavoritesRemoved extends FavoritesEvent {
  const FavoritesRemoved({
    required this.favorite,
  });

  final Favorite favorite;
}
