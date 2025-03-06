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
      return _appDatabase.contactsDao.watchAllContacts(null, sourceType?.toData()).map(
            ((contactDatas) => contactDatas
                .map((data) =>
                    contactFromDrift(data.contact, phones: data.phones, emails: data.emails, favorites: data.favorites))
                .toList()),
          );
    } else {
      return _appDatabase.contactsDao.watchAllContacts(searchBits, sourceType?.toData()).map(
            ((contactDatas) => contactDatas
                .map((data) =>
                    contactFromDrift(data.contact, phones: data.phones, emails: data.emails, favorites: data.favorites))
                .toList()),
          );
    }
  }

  Stream<Contact?> watchContact(ContactId contactId) {
    return _appDatabase.contactsDao.watchContact(contactId).map((data) {
      if (data == null) return null;
      return contactFromDrift(data.contact, phones: data.phones, emails: data.emails, favorites: data.favorites);
    });
  }

  Stream<Contact?> watchContactBySourceWithPhonesAndEmails(ContactSourceType sourceType, String sourceId) {
    return _appDatabase.contactsDao.watchContactBySource(sourceType.toData(), sourceId).map((data) {
      if (data == null) return null;
      return contactFromDrift(data.contact, phones: data.phones, emails: data.emails, favorites: data.favorites);
    });
  }

  Future<Contact?> getContactBySource(ContactSourceType sourceType, String sourceId) async {
    final data = await _appDatabase.contactsDao.getContactBySource(sourceType.toData(), sourceId);
    if (data == null) return null;
    return contactFromDrift(data.contact, phones: data.phones, emails: data.emails, favorites: data.favorites);
  }

  Future<Contact?> getContactByPhoneNumber(String number) async {
    final data = await _appDatabase.contactsDao.getContactByPhoneNumber(number);
    if (data == null) return null;
    return contactFromDrift(data.contact, phones: data.phones, emails: data.emails, favorites: data.favorites);
  }

  Future<int> addContactPhoneToFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.insertFavoriteByContactPhoneId(contactPhone.id);
  }

  Future<int> removeContactPhoneFromFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.deleteByContactPhoneId(contactPhone.id);
  }
}
