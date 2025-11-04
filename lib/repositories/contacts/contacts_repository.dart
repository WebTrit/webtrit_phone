import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/regexes.dart';
import 'package:webtrit_phone/utils/string_phone_utils.dart';

class ContactsRepository with PresenceInfoDriftMapper, ContactsDriftMapper {
  ContactsRepository({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<Contact>> watchContacts(String search, [ContactSourceType? sourceType]) {
    final searchBits = search.split(' ').where((value) => value.isNotEmpty);
    if (searchBits.isEmpty) {
      return _appDatabase.contactsDao.watchAllContacts(null, sourceType?.toData()).map(
            ((contactDatas) => contactDatas
                .map((data) => contactFromDrift(
                      data.contact,
                      phones: data.phones,
                      emails: data.emails,
                      favorites: data.favorites,
                      presenceInfo: data.presenceInfo,
                    ))
                .toList()),
          );
    } else {
      return _appDatabase.contactsDao.watchAllContacts(searchBits, sourceType?.toData()).map(
            ((contactDatas) => contactDatas
                .map((data) => contactFromDrift(
                      data.contact,
                      phones: data.phones,
                      emails: data.emails,
                      favorites: data.favorites,
                      presenceInfo: data.presenceInfo,
                    ))
                .toList()),
          );
    }
  }

  Stream<Contact?> watchContact(ContactId contactId) {
    return _appDatabase.contactsDao.watchContact(contactId).map((data) {
      if (data == null) return null;
      return contactFromDrift(
        data.contact,
        phones: data.phones,
        emails: data.emails,
        favorites: data.favorites,
        presenceInfo: data.presenceInfo,
      );
    });
  }

  Stream<Contact?> watchContactBySourceWithPhonesAndEmails(ContactSourceType sourceType, String sourceId) {
    return _appDatabase.contactsDao.watchContactBySource(sourceType.toData(), sourceId).map((data) {
      if (data == null) return null;
      return contactFromDrift(
        data.contact,
        phones: data.phones,
        emails: data.emails,
        favorites: data.favorites,
        presenceInfo: data.presenceInfo,
      );
    });
  }

  Future<Contact?> getContactBySource(ContactSourceType sourceType, String sourceId) async {
    final data = await _appDatabase.contactsDao.getContactBySource(sourceType.toData(), sourceId);
    if (data == null) return null;
    return contactFromDrift(
      data.contact,
      phones: data.phones,
      emails: data.emails,
      favorites: data.favorites,
      presenceInfo: data.presenceInfo,
    );
  }

  Future<Contact?> getContactByPhoneNumber(String number) async {
    final data = await _appDatabase.contactsDao.getContactByPhoneNumber(number);
    if (data == null) return null;
    return contactFromDrift(
      data.contact,
      phones: data.phones,
      emails: data.emails,
      favorites: data.favorites,
      presenceInfo: data.presenceInfo,
    );
  }

  Stream<Contact?> watchContactByPhoneNumber(String number) {
    return _appDatabase.contactsDao.watchContactByPhoneNumber(number).map((data) {
      if (data == null) return null;
      return contactFromDrift(data.contact, phones: data.phones, emails: data.emails, favorites: data.favorites);
    });
  }

  Stream<Contact?> watchContactByPhoneNumberMatch(String number) {
    number = number.replaceAll(RegExp(numberSanitizeRegex), '');
    if (number.isEmpty) return Stream.value(null);

    // For short numbers(services numbers, extensions) do exact match only
    // to avoid mismatches like matching "111" to "001234567111"
    if (number.length <= 4) return watchContactByPhoneNumber(number);

    // Try to get national format if possible to improve matching
    // for cases when contact stored in national format "123456789" but
    // remote system automaticaly appends country code "+00123456789" after calling
    // so only way to find such contact is to search by extract national part
    final nationalNumber = number.nationalPhoneIfValid;
    return _appDatabase.contactsDao.watchContactByPhoneMatchedEnding(nationalNumber ?? number).map((data) {
      if (data == null) return null;
      return contactFromDrift(data.contact, phones: data.phones, emails: data.emails, favorites: data.favorites);
    });
  }

  Future<int> addContactPhoneToFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.insertFavoriteByContactPhoneId(contactPhone.id);
  }

  Future<int> removeContactPhoneFromFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.deleteByContactPhoneId(contactPhone.id);
  }
}
