import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'contacts_mapper.dart';

mixin FavoritesDriftMapper on ContactsDriftMapper {
  Favorite favoriteFromDrift(FavoriteWithContactData data) {
    return Favorite(
      id: data.favoriteData.id,
      rawNumber: data.contactPhoneData.rawNumber,
      sanitizedNumber: data.contactPhoneData.sanitizedNumber,
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
