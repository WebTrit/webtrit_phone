import 'dart:async';

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
          .map(((contactDatas) => contactDatas.map(_mapContactDataToContact).toList()));
    } else {
      return _appDatabase.contactsDao
          .watchAllLikeContacts(searchBits, sourceType)
          .map(((contactDatas) => contactDatas.map(_mapContactDataToContact).toList()));
    }
  }

  Contact _mapContactDataToContact(ContactData contactData) => Contact(
        id: contactData.id,
        sourceType: contactData.sourceType,
        sourceId: contactData.sourceId,
        displayName: contactData.displayName,
        firstName: contactData.firstName,
        lastName: contactData.lastName,
      );

  Future<List<ContactPhone>> getContactPhones(Contact contact) {
    final contactId = contact.id;
    return _appDatabase.contactPhonesDao
        .getContactPhonesExtByContactId(contactId)
        .then((contactPhoneDatas) => contactPhoneDatas
            .map((contactPhoneDataWithFavoriteData) => ContactPhone(
                  id: contactPhoneDataWithFavoriteData.contactPhoneData.id,
                  number: contactPhoneDataWithFavoriteData.contactPhoneData.number,
                  label: contactPhoneDataWithFavoriteData.contactPhoneData.label,
                  favorite: contactPhoneDataWithFavoriteData.favoriteData != null,
                ))
            .toList());
  }

  Future<int> addContactPhoneToFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.insertFavoriteByContactPhoneId(contactPhone.id);
  }

  Future<int> removeContactPhoneFromFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.deleteByContactPhoneId(contactPhone.id);
  }
}
