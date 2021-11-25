import 'dart:async';

import 'package:webtrit_phone/data/data.dart';

import 'models/models.dart';
export 'models/models.dart';

class ContactsRepository {
  ContactsRepository({required this.appDatabase});

  final AppDatabase appDatabase;

  Stream<List<Contact>> watchContacts(String search, [ContactSourceType? sourceType]) {
    final searchBits = search.split(' ').where((value) => value.isNotEmpty);
    if (searchBits.isEmpty) {
      return appDatabase.contactsDao
          .watchAllNotEmptyContacts(sourceType)
          .map(((contactDatas) => contactDatas.map(_mapContactDataToContact).toList()));
    } else {
      return appDatabase.contactsDao
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
    if (contactId == null) {
      return Future.value(const []); // TODO maybe error
    } else {
      return appDatabase.contactPhonesDao
          .getContactPhonesByContactId(contactId)
          .then((contactPhoneDatas) => contactPhoneDatas
              .map((contactPhoneData) => ContactPhone(
                    number: contactPhoneData.number,
                    label: contactPhoneData.label,
                  ))
              .toList());
    }
  }
}
