import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'contacts_mapper.dart';

mixin FavoritesDriftMapper on ContactsDriftMapper {
  Favorite favoriteFromDrift(FavoriteV2Data data) {
    return Favorite(
      number: data.number,
      sourceType: FavoriteSourceType.values.byName(data.sourceType.name),
      sourceId: data.sourceId,
      label: data.label,
      position: data.position,
    );
  }

  FavoriteV2Data favoriteToDrift(Favorite favorite) {
    return FavoriteV2Data(
      number: favorite.number,
      sourceType: FavoriteSourceTypeData.values.byName(favorite.sourceType.name),
      sourceId: favorite.sourceId,
      label: favorite.label,
      position: favorite.position,
    );
  }

  FavoriteWithContact favoriteWithContactFromDrift(FavoriteWithContactDataV2 data) {
    return (
      favorite: favoriteFromDrift(data.favoriteData),
      contact: data.contactDatas?.contactData != null
          ? contactFromDrift(
              data.contactDatas!.contactData,
              phones: data.contactDatas!.contactPhones.toList(),
              emails: data.contactDatas!.contactEmails.toList(),
              presenceInfo: data.contactDatas!.contactPresenceInfo.toList(),
            )
          : null,
    );
  }
}
