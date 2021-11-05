import 'dart:async';

import 'package:webtrit_phone/data/data.dart';

import 'models/models.dart';
export 'models/models.dart';

class ContactsRepository {
  ContactsRepository({required this.appDatabase});

  final AppDatabase appDatabase;

  Stream<List<Contact>> watchContacts([ContactSourceType? sourceType]) {
    return appDatabase.contactsDao.watchAllContacts(sourceType).map(((contactDatas) => contactDatas
        .map((contactData) => Contact(
              id: contactData.id,
              sourceType: contactData.sourceType,
              sourceId: contactData.sourceId,
              displayName: contactData.displayName,
              firstName: contactData.firstName,
              lastName: contactData.lastName,
            ))
        .toList()));
  }

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
