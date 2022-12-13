import 'dart:async';

import 'package:drift/drift.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

class ContactsRepository {
  ContactsRepository({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<Contact>> watchContacts(String search, [ContactSourceType? sourceType]) {
    final searchBits = search.split(' ').where((value) => value.isNotEmpty);
    if (searchBits.isEmpty) {
      return _appDatabase.contactsDao
          .watchAllNotEmptyContacts(sourceType)
          .map(((contactDatas) => contactDatas.map(_toContact).toList()));
    } else {
      return _appDatabase.contactsDao
          .watchAllLikeContacts(searchBits, sourceType)
          .map(((contactDatas) => contactDatas.map(_toContact).toList()));
    }
  }

  Stream<Contact> watchContact(ContactId contactId) {
    return _appDatabase.contactsDao
        .watchContact(ContactDataCompanion(
          id: Value(contactId),
        ))
        .map(_toContact);
  }

  Stream<List<ContactPhone>> watchContactPhones(ContactId contactId) {
    return _appDatabase.contactPhonesDao
        .watchContactPhonesExtByContactId(contactId)
        .map((contactPhoneDatas) => contactPhoneDatas.map(_toContactPhone).toList());
  }

  Future<int> addContactPhoneToFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.insertFavoriteByContactPhoneId(contactPhone.id);
  }

  Future<int> removeContactPhoneFromFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.deleteByContactPhoneId(contactPhone.id);
  }

  Contact _toContact(ContactData data) {
    return Contact(
      id: data.id,
      sourceType: data.sourceType,
      sourceId: data.sourceId,
      displayName: data.displayName,
      firstName: data.firstName,
      lastName: data.lastName,
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
}
