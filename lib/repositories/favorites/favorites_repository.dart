import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

class FavoritesRepository {
  FavoritesRepository({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<Favorite>> favorites() {
    return _appDatabase.favoritesDao.watchFavoritesExt().map((favoritesExt) => favoritesExt.map((data) {
          final favoriteData = data.favoriteData;
          final contactPhoneData = data.contactPhoneData;
          final contactData = data.contactData;

          final email = data.contactEmails.firstOrNull?.address;
          final gravatarUrl = gravatarThumbnailUrl(email);

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
              thumbnail: contactData.thumbnail,
              thumbnailUrl: gravatarUrl,
              phones: data.contactPhones.map(_toRealContactPhone).toList(),
              emails: data.contactEmails.map(_toContactEmail).toList(),
            ),
          );
        }).toList(growable: false));
  }

  Future<void> remove(Favorite favorite) async {
    _appDatabase.favoritesDao.deleteFavorite(FavoriteDataCompanion(
      id: Value(favorite.id),
    ));
  }

  ContactPhone _toRealContactPhone(ContactPhoneData data) {
    return ContactPhone(
      id: data.id,
      number: data.number,
      label: data.label,
      favorite: false,
    );
  }

  ContactEmail _toContactEmail(ContactEmailData data) {
    return ContactEmail(
      id: data.id,
      address: data.address,
      label: data.label,
    );
  }
}
