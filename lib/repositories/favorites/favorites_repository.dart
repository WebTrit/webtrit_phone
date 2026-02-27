import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

class FavoritesRepository with PresenceInfoDriftMapper, ContactsDriftMapper, FavoritesDriftMapper {
  FavoritesRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;
  late final _dao = _appDatabase.favoritesV2Dao;

  Stream<List<FavoriteWithContact>> favorites() {
    return _dao.watchWithContacts().map((data) => data.map((e) => favoriteWithContactFromDrift(e)).toList());
  }

  Future<void> remove(Favorite favorite) async {
    _dao.remove((favorite.number, FavoriteSourceTypeData.values.byName(favorite.sourceType.name)));
  }
}
