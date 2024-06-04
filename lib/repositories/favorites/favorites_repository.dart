import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';

class FavoritesRepository {
  FavoritesRepository({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<Favorite>> favorites() {
    return _appDatabase.favoritesDao.watchFavoritesExt().map((favoritesExt) => favoritesExt.map((favoriteExt) {
          final favoriteData = favoriteExt.favoriteData;
          final contactPhoneData = favoriteExt.contactPhoneData;
          final contactData = favoriteExt.contactData;
          return Favorite(
            id: favoriteData.id,
            number: contactPhoneData.number,
            label: contactPhoneData.label,
            contact: Contact(
              id: contactData.id,
              sourceType: contactData.sourceType.toModel(),
              sourceId: contactData.sourceId,
              registered: contactData.registered,
              firstName: contactData.firstName,
              lastName: contactData.lastName,
              aliasName: contactData.aliasName,
            ),
          );
        }).toList(growable: false));
  }

  Future<void> remove(Favorite favorite) async {
    _appDatabase.favoritesDao.deleteFavorite(FavoriteDataCompanion(
      id: Value(favorite.id),
    ));
  }
}
