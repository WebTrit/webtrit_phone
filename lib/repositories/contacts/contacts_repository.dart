import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

class ContactsRepository {
  ContactsRepository({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<Contact>> watchContacts(String search, [ContactSourceType? sourceType]) {
    final searchBits = search.split(' ').where((value) => value.isNotEmpty);
    if (searchBits.isEmpty) {
      return _appDatabase.contactsDao
          .watchAllContactsExt(null, sourceType?.toData())
          .map(((contactDatas) => contactDatas.map(_toContactWithPhonesAndEmails).toList()));
    } else {
      return _appDatabase.contactsDao
          .watchAllContactsExt(searchBits, sourceType?.toData())
          .map(((contactDatas) => contactDatas.map(_toContactWithPhonesAndEmails).toList()));
    }
  }

  Stream<Contact> watchContact(ContactId contactId) {
    return _appDatabase.contactsDao
        .watchContact(ContactDataCompanion(
          id: Value(contactId),
        ))
        .map(_toContact);
  }

  Stream<Contact?> watchContactBySource(ContactSourceType sourceType, String sourceId) {
    return _appDatabase.contactsDao.watchContactBySource(sourceType.toData(), sourceId).map((c) {
      if (c == null) return null;
      return _toContact(c);
    });
  }

  Stream<Contact?> watchContactBySourceWithPhonesAndEmails(ContactSourceType sourceType, String sourceId) {
    return _appDatabase.contactsDao.watchContactExtBySource(sourceType.toData(), sourceId).map((c) {
      if (c == null) return null;
      return _toContactWithPhonesAndEmails(c);
    });
  }

  Future<Contact?> getContactBySource(ContactSourceType sourceType, String sourceId) async {
    final contactData = await _appDatabase.contactsDao.getContactBySource(sourceType.toData(), sourceId);
    if (contactData == null) return null;
    return _toContact(contactData);
  }

  Stream<List<ContactPhone>> watchContactPhones(ContactId contactId) {
    return _appDatabase.contactPhonesDao
        .watchContactPhonesExtByContactId(contactId)
        .map((contactPhoneDatas) => contactPhoneDatas.map(_toContactPhone).toList());
  }

  Stream<List<ContactEmail>> watchContactEmails(ContactId contactId) {
    return _appDatabase.contactEmailsDao
        .watchContactEmailsByContactId(contactId)
        .map((contactEmailDatas) => contactEmailDatas.map(_toContactEmail).toList());
  }

  Future<int> addContactPhoneToFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.insertFavoriteByContactPhoneId(contactPhone.id);
  }

  Future<int> removeContactPhoneFromFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.deleteByContactPhoneId(contactPhone.id);
  }

  Contact _toContactWithPhonesAndEmails(ContactWithPhonesAndEmailsData data) {
    final email = data.emails.firstOrNull?.address;
    final gravatarUrl = gravatarThumbnailUrl(email);

    return Contact(
      id: data.contact.id,
      sourceType: data.contact.sourceType.toModel(),
      sourceId: data.contact.sourceId,
      registered: data.contact.registered,
      userRegistered: data.contact.userRegistered,
      isCurrentUser: data.contact.isCurrentUser,
      firstName: data.contact.firstName,
      lastName: data.contact.lastName,
      aliasName: data.contact.aliasName,
      thumbnail: data.contact.thumbnail,
      thumbnailUrl: gravatarUrl,
      phones: data.phones.map(_toRealContactPhone).toList(),
      emails: data.emails.map(_toContactEmail).toList(),
    );
  }

  Contact _toContact(ContactData data) {
    return Contact(
      id: data.id,
      sourceType: data.sourceType.toModel(),
      sourceId: data.sourceId,
      registered: data.registered,
      userRegistered: data.userRegistered,
      isCurrentUser: data.isCurrentUser,
      firstName: data.firstName,
      lastName: data.lastName,
      aliasName: data.aliasName,
      thumbnail: data.thumbnail,
    );
  }

  ContactPhone _toContactPhone(ContactPhoneDataWithFavoriteData data) {
    return ContactPhone(
      id: data.contactPhoneData.id,
      number: data.contactPhoneData.number,
      label: data.contactPhoneData.label,
      favorite: data.favoriteData != null,
    );
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
