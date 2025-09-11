import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'contacts_mapper.dart';

mixin FavoritesDriftMapper on ContactsDriftMapper {
  Favorite favoriteFromDrift(FavoriteWithContactData data) {
    return Favorite(
      id: data.favoriteData.id,
      number: data.contactPhoneData.number,
      label: data.contactPhoneData.label,
      contact: contactFromDrift(
        data.contactData,
        phones: data.contactPhones.toList(),
        emails: data.contactEmails.toList(),
        presenceInfo: data.contactPresenceInfo.toList(),
      ),
    );
  }
}
