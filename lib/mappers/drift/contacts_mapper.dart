import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/models/contact.dart';
import 'package:webtrit_phone/models/contact_email.dart';
import 'package:webtrit_phone/models/contact_phone.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/utils/utils.dart';

Contact contactFromDrift(
  ContactData contactData, {
  List<ContactPhoneData> phones = const [],
  List<ContactEmailData> emails = const [],
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
    phones: phones.map(contactPhoneFromDrift).toList(),
    emails: emails.map(contactEmailFromDrift).toList(),
  );
}

ContactPhone contactPhoneWithFavoriteFromDrift(ContactPhoneDataWithFavoriteData data) {
  return ContactPhone(
    id: data.contactPhoneData.id,
    number: data.contactPhoneData.number,
    label: data.contactPhoneData.label,
    favorite: data.favoriteData != null,
  );
}

ContactPhone contactPhoneFromDrift(ContactPhoneData data) {
  return ContactPhone(
    id: data.id,
    number: data.number,
    label: data.label,
    favorite: false,
  );
}

ContactEmail contactEmailFromDrift(ContactEmailData data) {
  return ContactEmail(
    id: data.id,
    address: data.address,
    label: data.label,
  );
}
