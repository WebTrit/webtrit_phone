part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesStarted extends FavoritesEvent {
  const FavoritesStarted();
}

class FavoritesAddedByContactPhoneId extends FavoritesEvent {
  const FavoritesAddedByContactPhoneId({
    required this.contactPhoneId,
  });

  final int contactPhoneId;

  @override
  List<Object> get props => [
    contactPhoneId,
  ];
}

class FavoritesRemovedByContactPhoneId extends FavoritesEvent {
  const FavoritesRemovedByContactPhoneId({
    required this.contactPhoneId,
  });

  final int contactPhoneId;

  @override
  List<Object> get props => [
    contactPhoneId,
  ];
}

class FavoritesRemoved extends FavoritesEvent {
  const FavoritesRemoved({
    required this.favorite,
  });

  final Favorite favorite;

  @override
  List<Object> get props => [
        favorite,
      ];
}
