import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class ContactsLocalDataSource {
  Future<void> syncContacts(List<ExternalContact> contacts, String? currentUserMainNumber);

  Future<int> upsertContact(ExternalContact externalContact, ContactKind kind);
}

class ContactsLocalDataSourceImpl implements ContactsLocalDataSource {
  ContactsLocalDataSourceImpl(this._appDatabase);

  final AppDatabase _appDatabase;

  @override
  Future<void> syncContacts(List<ExternalContact> contacts, String? currentUserMainNumber) async {
    await _appDatabase.transaction(() async {
      await _appDatabase.contactsDao.deleteContactsWithNullSourceId(ContactSourceTypeEnum.external);

      final filteredContacts = contacts.where((externalContact) => externalContact.id != currentUserMainNumber);

      final syncedExternalContactsIds = await _appDatabase.contactsDao.getContactsSourceIds(
        ContactSourceTypeEnum.external,
      );

      final updatedExternalContactsIds = filteredContacts.map((c) => c.id).toSet();
      final delExternalContactsIds = syncedExternalContactsIds.difference(updatedExternalContactsIds);

      for (final externalContactsId in delExternalContactsIds) {
        await _appDatabase.contactsDao.deleteContactBySource(ContactSourceTypeEnum.external, externalContactsId);
      }

      for (final externalContact in filteredContacts) {
        final insertOrUpdateContactData = await _appDatabase.contactsDao.insertOnUniqueConflictUpdateContact(
          ContactDataCompanion(
            sourceType: const Value(ContactSourceTypeEnum.external),
            sourceId: Value(externalContact.safeSourceId),
            firstName: Value(externalContact.firstName),
            lastName: Value(externalContact.lastName),
            aliasName: Value(externalContact.aliasName),
            registered: Value(externalContact.registered),
            userRegistered: Value(externalContact.userRegistered),
            isCurrentUser: Value(externalContact.isCurrentUser),
          ),
        );

        final externalContactNumber = externalContact.number;
        final externalContactExt = externalContact.ext;
        final externalContactMobile = externalContact.mobile;
        final externalSmsNumbers = externalContact.smsNumbers;

        final externalContactNumbers = [
          if (externalContactNumber != null) externalContactNumber,
          if (externalContactExt != null) externalContactExt,
          if (externalContactMobile != null) externalContactMobile,
          if (externalSmsNumbers != null) ...externalSmsNumbers,
        ];

        await _appDatabase.contactPhonesDao.deleteOtherContactPhonesOfContactId(
          insertOrUpdateContactData.id,
          externalContactNumbers,
        );

        if (externalContactNumber != null) {
          await _appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
            ContactPhoneDataCompanion(
              number: Value(externalContactNumber),
              label: const Value('number'),
              contactId: Value(insertOrUpdateContactData.id),
            ),
          );
        }
        if (externalContactExt != null) {
          await _appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
            ContactPhoneDataCompanion(
              number: Value(externalContactExt),
              label: const Value('ext'),
              contactId: Value(insertOrUpdateContactData.id),
            ),
          );
        }
        if (externalContactMobile != null) {
          await _appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
            ContactPhoneDataCompanion(
              number: Value(externalContactMobile),
              label: const Value('mobile'),
              contactId: Value(insertOrUpdateContactData.id),
            ),
          );
        }
        if (externalSmsNumbers != null) {
          for (final externalSmsNumber in externalSmsNumbers) {
            await _appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
              ContactPhoneDataCompanion(
                number: Value(externalSmsNumber),
                label: const Value('sms'),
                contactId: Value(insertOrUpdateContactData.id),
              ),
            );
          }
        }

        final externalContactEmail = externalContact.email;
        final externalContactEmails = [if (externalContactEmail != null) externalContactEmail];

        await _appDatabase.contactEmailsDao.deleteOtherContactEmailsOfContactId(
          insertOrUpdateContactData.id,
          externalContactEmails,
        );

        if (externalContactEmail != null) {
          await _appDatabase.contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(
            ContactEmailDataCompanion(
              address: Value(externalContactEmail),
              label: const Value(''),
              contactId: Value(insertOrUpdateContactData.id),
            ),
          );
        }
      }
    });
  }

  @override
  Future<int> upsertContact(ExternalContact externalContact, ContactKind kind) async {
    return _appDatabase.transaction(() async {
      final insertOrUpdateContactData = await _appDatabase.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: const Value(ContactSourceTypeEnum.external),
          sourceId: Value(externalContact.safeSourceId),
          kind: Value(kind),
          firstName: Value(externalContact.firstName),
          lastName: Value(externalContact.lastName),
          aliasName: Value(externalContact.aliasName),
          registered: Value(externalContact.registered),
          userRegistered: Value(externalContact.userRegistered),
          isCurrentUser: Value(externalContact.isCurrentUser),
        ),
      );

      final contactId = insertOrUpdateContactData.id;

      final externalContactNumber = externalContact.number;
      final externalContactExt = externalContact.ext;
      final externalContactMobile = externalContact.mobile;
      final externalSmsNumbers = externalContact.smsNumbers;

      final externalContactNumbers = [
        if (externalContactNumber != null) externalContactNumber,
        if (externalContactExt != null) externalContactExt,
        if (externalContactMobile != null) externalContactMobile,
        if (externalSmsNumbers != null) ...externalSmsNumbers,
      ];

      await _appDatabase.contactPhonesDao.deleteOtherContactPhonesOfContactId(contactId, externalContactNumbers);

      if (externalContactNumber != null) {
        await _appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
          ContactPhoneDataCompanion(
            number: Value(externalContactNumber),
            label: const Value('number'),
            contactId: Value(contactId),
          ),
        );
      }
      if (externalContactExt != null) {
        await _appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
          ContactPhoneDataCompanion(
            number: Value(externalContactExt),
            label: const Value('ext'),
            contactId: Value(contactId),
          ),
        );
      }
      if (externalContactMobile != null) {
        await _appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
          ContactPhoneDataCompanion(
            number: Value(externalContactMobile),
            label: const Value('mobile'),
            contactId: Value(contactId),
          ),
        );
      }
      if (externalSmsNumbers != null) {
        for (final externalSmsNumber in externalSmsNumbers) {
          await _appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
            ContactPhoneDataCompanion(
              number: Value(externalSmsNumber),
              label: const Value('sms'),
              contactId: Value(contactId),
            ),
          );
        }
      }

      final externalContactEmail = externalContact.email;
      final externalContactEmails = [if (externalContactEmail != null) externalContactEmail];

      await _appDatabase.contactEmailsDao.deleteOtherContactEmailsOfContactId(contactId, externalContactEmails);

      if (externalContactEmail != null) {
        await _appDatabase.contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(
          ContactEmailDataCompanion(
            address: Value(externalContactEmail),
            label: const Value(''),
            contactId: Value(contactId),
          ),
        );
      }

      return contactId;
    });
  }
}
