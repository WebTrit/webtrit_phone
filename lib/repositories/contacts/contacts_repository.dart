import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

class ContactsRepository with ContactsDriftMapper {
  ContactsRepository({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<Contact>> watchContacts(String search, [ContactSourceType? sourceType]) {
    final searchBits = search.split(' ').where((value) => value.isNotEmpty);
    if (searchBits.isEmpty) {
      return _appDatabase.contactsDao.watchAllContactsExt(null, sourceType?.toData()).map(
            ((contactDatas) => contactDatas
                .map((data) => contactFromDrift(data.contact, phones: data.phones, emails: data.emails))
                .toList()),
          );
    } else {
      return _appDatabase.contactsDao.watchAllContactsExt(searchBits, sourceType?.toData()).map(
            ((contactDatas) => contactDatas
                .map((data) => contactFromDrift(data.contact, phones: data.phones, emails: data.emails))
                .toList()),
          );
    }
  }

  Stream<Contact> watchContact(ContactId contactId) {
    return _appDatabase.contactsDao
        .watchContact(ContactDataCompanion(
          id: Value(contactId),
        ))
        .map(contactFromDrift);
  }

  Stream<Contact?> watchContactBySource(ContactSourceType sourceType, String sourceId) {
    return _appDatabase.contactsDao.watchContactBySource(sourceType.toData(), sourceId).map((c) {
      if (c == null) return null;
      return contactFromDrift(c);
    });
  }

  Stream<Contact?> watchContactBySourceWithPhonesAndEmails(ContactSourceType sourceType, String sourceId) {
    return _appDatabase.contactsDao.watchContactExtBySource(sourceType.toData(), sourceId).map((data) {
      if (data == null) return null;
      return contactFromDrift(data.contact, phones: data.phones, emails: data.emails);
    });
  }

  Future<Contact?> getContactBySource(ContactSourceType sourceType, String sourceId) async {
    final contactData = await _appDatabase.contactsDao.getContactBySource(sourceType.toData(), sourceId);
    if (contactData == null) return null;
    return contactFromDrift(contactData);
  }

  Stream<List<ContactPhone>> watchContactPhones(ContactId contactId) {
    return _appDatabase.contactPhonesDao
        .watchContactPhonesExtByContactId(contactId)
        .map((contactPhoneDatas) => contactPhoneDatas.map(contactPhoneWithFavoriteFromDrift).toList());
  }

  Stream<List<ContactEmail>> watchContactEmails(ContactId contactId) {
    return _appDatabase.contactEmailsDao
        .watchContactEmailsByContactId(contactId)
        .map((contactEmailDatas) => contactEmailDatas.map(contactEmailFromDrift).toList());
  }

  Future<int> addContactPhoneToFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.insertFavoriteByContactPhoneId(contactPhone.id);
  }

  Future<int> removeContactPhoneFromFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.deleteByContactPhoneId(contactPhone.id);
  }

  Future<List<Contact>> getContactByPhoneNumber(String number) async {
    final contactDataList = await _appDatabase.contactsDao.getContactsByPhoneNumber(number);
    return contactDataList.map(contactFromDrift).toList();
  }
}
