part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
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
    EquatablePropToString([contactPhoneId], listPropToString),
  ];
}

class FavoritesRemovedByContactPhoneId extends FavoritesEvent {
  const FavoritesRemovedByContactPhoneId({
    required this.contactPhoneId,
  });
  final int contactPhoneId;

  @override
  List<Object> get props => [
    EquatablePropToString([contactPhoneId], listPropToString),
  ];
}

class FavoritesRemoved extends FavoritesEvent {
  const FavoritesRemoved({
    required this.favorite,
  });

  final Favorite favorite;

  @override
  List<Object> get props => [
    EquatablePropToString([favorite], listPropToString),
  ];
}