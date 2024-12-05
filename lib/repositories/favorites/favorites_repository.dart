import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

class FavoritesRepository with ContactsDriftMapper, FavoritesDriftMapper {
  FavoritesRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<Favorite>> favorites() {
    return _appDatabase.favoritesDao.watchFavoritesExt().map((data) => data.map(favoriteFromDrift).toList());
  }

  Future<void> remove(Favorite favorite) async {
    _appDatabase.favoritesDao.deleteFavorite(FavoriteDataCompanion(id: Value(favorite.id)));
  }
}
