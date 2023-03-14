import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/data/data.dart';

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState> implements FavoritesBloc {
  MockFavoritesBloc();

  factory MockFavoritesBloc.mainScreen() {
    final mock = MockFavoritesBloc();
    whenListen(
      mock,
      const Stream<FavoritesState>.empty(),
      initialState: const FavoritesState(
        favorites: dFavorites,
      ),
    );
    return mock;
  }
}
