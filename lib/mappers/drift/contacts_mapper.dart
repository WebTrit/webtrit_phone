import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/models/contact.dart';
import 'package:webtrit_phone/models/contact_email.dart';
import 'package:webtrit_phone/models/contact_phone.dart';
import 'package:webtrit_phone/models/presence/presence_info.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'presence_info_drift_mapper.dart';

mixin ContactsDriftMapper on PresenceInfoDriftMapper {
  Contact contactFromDrift(
    ContactData contactData, {
    List<ContactPhoneData> phones = const [],
    List<ContactEmailData> emails = const [],
    List<FavoriteData> favorites = const [],
    List<PresenceInfoData> presenceInfo = const [],
  }) {
    final email = emails.firstOrNull?.address;
    final gravatarUrl = gravatarThumbnailUrl(email);

    return Contact(
      id: contactData.id,
      sourceType: contactData.sourceType.toModel(),
      sourceId: contactData.sourceId,
      registered: contactData.registered,
      userRegistered: contactData.userRegistered,
      isCurrentUser: contactData.isCurrentUser,
      firstName: contactData.firstName,
      lastName: contactData.lastName,
      aliasName: contactData.aliasName,
      thumbnail: contactData.thumbnail,
      thumbnailUrl: gravatarUrl,
      phones: contactPhonesFromDrift(phones, favorites).toList(),
      emails: contactEmailsFromDrift(emails).toList(),
      presenceInfo: contactPresenceInfosFromDrift(presenceInfo).toList(),
    );
  }

  Iterable<ContactPhone> contactPhonesFromDrift(List<ContactPhoneData> phones, List<FavoriteData> favorites) {
    return phones.map(
      (phone) => contactPhoneFromDrift(
        phone,
        favorite: favorites.any((favorite) => favorite.contactPhoneId == phone.id),
      ),
    );
  }

  Iterable<ContactEmail> contactEmailsFromDrift(List<ContactEmailData> emails) {
    return emails.map(contactEmailFromDrift);
  }

  Iterable<PresenceInfo> contactPresenceInfosFromDrift(List<PresenceInfoData> presenceInfo) {
    return presenceInfo.map(presenceInfoFromDrift);
  }

  ContactPhone contactPhoneFromDrift(ContactPhoneData data, {bool favorite = false}) {
    return ContactPhone(
      id: data.id,
      number: data.number,
      label: data.label,
      favorite: favorite,
    );
  }

  ContactEmail contactEmailFromDrift(ContactEmailData data) {
    return ContactEmail(
      id: data.id,
      address: data.address,
      label: data.label,
    );
  }
}
