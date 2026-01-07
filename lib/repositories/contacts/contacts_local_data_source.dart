import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

abstract class ContactsLocalDataSource {
  /// Upserts a single external contact.
  /// Used for fetching details of a specific contact.
  Future<int> upsertContact(ExternalContact externalContact, ContactKind kind);

  /// Synchronizes a list of external contacts.
  /// Handles deletion of missing contacts and batch upsert of new/updated ones.
  Future<void> syncExternalContacts(List<ExternalContact> contacts);

  /// Synchronizes a list of local device contacts.
  Future<void> syncLocalContacts(List<LocalContact> contacts);
}

class ContactsLocalDataSourceImpl implements ContactsLocalDataSource {
  ContactsLocalDataSourceImpl(this._appDatabase);

  /// App-level database instance used for contact persistence and queries.
  final AppDatabase _appDatabase;

  /// RegExp used to strip non-digit characters from phone numbers.
  /// Pattern comes from `numberSanitizeRegex`.
  final RegExp _numberRegExp = RegExp(numberSanitizeRegex);

  @override
  Future<int> upsertContact(ExternalContact externalContact, ContactKind kind) {
    return _appDatabase.transaction(() async {
      return _upsertContactInternal(externalContact, kind: kind);
    });
  }

  @override
  Future<void> syncExternalContacts(List<ExternalContact> contacts) async {
    await _appDatabase.transaction(() async {
      // Remove legacy or invalid external contacts that were previously stored without a proper sourceId,
      // which may cause duplication or prevent accurate sync updates.
      await _appDatabase.contactsDao.deleteContactsWithNullSourceId(ContactSourceTypeEnum.external);

      final syncedExternalContactsIds = await _appDatabase.contactsDao.getContactsSourceIds(
        ContactSourceTypeEnum.external,
      );

      // Use `safeSourceId` because that is the value persisted in the database.
      // If the API returns `id == null`, `safeSourceId` generates a stable identifier
      // (derived from number/email), preventing incorrect deletions that would occur if `c.id` were used.
      final updatedExternalContactsIds = contacts.map((c) => c.safeSourceId).toSet();
      final delExternalContactsIds = syncedExternalContactsIds.difference(updatedExternalContactsIds);

      if (delExternalContactsIds.isNotEmpty) {
        await _appDatabase.contactsDao.deleteContactsBySourceList(
          ContactSourceTypeEnum.external,
          delExternalContactsIds,
        );
      }

      await Future.wait(contacts.map((externalContact) => _upsertContactInternal(externalContact)));
    });
  }

  @override
  Future<void> syncLocalContacts(List<LocalContact> contacts) async {
    await _appDatabase.transaction(() async {
      final syncedLocalContactsIds = await _appDatabase.contactsDao.getContactsSourceIds(ContactSourceTypeEnum.local);
      final updatedLocalContactsIds = contacts.map((c) => c.id).toSet();
      final delLocalContactsIds = syncedLocalContactsIds.difference(updatedLocalContactsIds);

      if (delLocalContactsIds.isNotEmpty) {
        await _appDatabase.contactsDao.deleteContactsBySourceList(ContactSourceTypeEnum.local, delLocalContactsIds);
      }

      await Future.wait(
        contacts.map((localContact) async {
          final insertOrUpdateContactData = await _appDatabase.contactsDao.insertOnUniqueConflictUpdateContact(
            ContactDataCompanion(
              sourceType: const Value(ContactSourceTypeEnum.local),
              sourceId: Value(localContact.id),
              firstName: Value(localContact.firstName),
              lastName: Value(localContact.lastName),
              aliasName: Value(localContact.displayName),
              thumbnail: Value(localContact.thumbnail),
            ),
          );

          final contactId = insertOrUpdateContactData.id;

          // Prepare lists for batch inserts
          final phoneCompanions = <ContactPhoneDataCompanion>[];
          final emailCompanions = <ContactEmailDataCompanion>[];

          // Cleanup old phones
          await _appDatabase.contactPhonesDao.deleteOtherContactPhonesOfContactId(
            contactId,
            localContact.phones.map((phone) => phone.number),
          );

          for (final localContactPhone in localContact.phones) {
            phoneCompanions.add(
              ContactPhoneDataCompanion(
                // TODO: maybe store raw and sanitized versions together
                number: Value(_sanitizeNumber(localContactPhone.number)),
                label: Value(localContactPhone.label),
                contactId: Value(contactId),
              ),
            );
          }

          // Cleanup old emails
          await _appDatabase.contactEmailsDao.deleteOtherContactEmailsOfContactId(
            contactId,
            localContact.emails.map((email) => email.address),
          );

          for (final localContactEmail in localContact.emails) {
            emailCompanions.add(
              ContactEmailDataCompanion(
                address: Value(localContactEmail.address),
                label: Value(localContactEmail.label),
                contactId: Value(contactId),
              ),
            );
          }

          await Future.wait([
            if (phoneCompanions.isNotEmpty) _appDatabase.contactPhonesDao.insertContactPhonesBatch(phoneCompanions),
            if (emailCompanions.isNotEmpty) _appDatabase.contactEmailsDao.insertContactEmailsBatch(emailCompanions),
          ]);
        }),
      );
    });
  }

  /// Internal method to upsert a contact without creating a new transaction scope.
  /// This allows it to be reused in both single [upsertContact] and batch [syncExternalContacts].
  Future<int> _upsertContactInternal(ExternalContact externalContact, {ContactKind? kind}) async {
    final insertOrUpdateContactData = await _appDatabase.contactsDao.insertOnUniqueConflictUpdateContact(
      ContactDataCompanion(
        sourceType: const Value(ContactSourceTypeEnum.external),
        // Ensure a stable and unique sourceId for deduplication and upsert logic.
        sourceId: Value(externalContact.safeSourceId),
        // If kind is provided, update it; otherwise, leave it absent (Drift keeps existing value or uses default)
        kind: kind != null ? Value(kind) : const Value.absent(),
        firstName: Value(externalContact.firstName),
        lastName: Value(externalContact.lastName),
        aliasName: Value(externalContact.aliasName),
        registered: Value(externalContact.registered),
        userRegistered: Value(externalContact.userRegistered),
        isCurrentUser: Value(externalContact.isCurrentUser),
      ),
    );

    final contactId = insertOrUpdateContactData.id;
    await _upsertExternalContactDetails(contactId, externalContact);

    return contactId;
  }

  Future<void> _upsertExternalContactDetails(int contactId, ExternalContact externalContact) async {
    final externalContactNumber = externalContact.number;
    // Some external accounts legitimately have `ext` equal to `number`.
    // To avoid losing the main number label, when `ext` is identical to `number`
    // we treat `ext` as absent and do not create a separate phone record for it.
    final externalContactExt = externalContact.ext != externalContact.number ? externalContact.ext : null;
    final externalContactAdditional = externalContact.additional;
    final externalSmsNumbers = externalContact.smsNumbers;

    final externalContactNumbers = [
      if (externalContactNumber != null) externalContactNumber,
      if (externalContactExt != null) externalContactExt,
      if (externalContactAdditional != null) ...externalContactAdditional,
      if (externalSmsNumbers != null) ...externalSmsNumbers,
    ];

    // Cleanup old phones
    await _appDatabase.contactPhonesDao.deleteOtherContactPhonesOfContactId(contactId, externalContactNumbers);

    // Prepare Batch List
    final phoneCompanions = <ContactPhoneDataCompanion>[];

    if (externalContactNumber != null) {
      phoneCompanions.add(
        ContactPhoneDataCompanion(
          number: Value(externalContactNumber),
          label: const Value(kContactMainLabel),
          contactId: Value(contactId),
        ),
      );
    }
    if (externalContactExt != null) {
      phoneCompanions.add(
        ContactPhoneDataCompanion(
          number: Value(externalContactExt),
          label: const Value(kContactExtLabel),
          contactId: Value(contactId),
        ),
      );
    }
    if (externalSmsNumbers != null) {
      for (final externalSmsNumber in externalSmsNumbers) {
        phoneCompanions.add(
          ContactPhoneDataCompanion(
            number: Value(externalSmsNumber),
            label: const Value(kContactSmsLabel),
            contactId: Value(contactId),
          ),
        );
      }
    }
    if (externalContactAdditional != null) {
      for (final externalContactAdditionalNumber in externalContactAdditional) {
        phoneCompanions.add(
          ContactPhoneDataCompanion(
            number: Value(externalContactAdditionalNumber),
            label: const Value(kContactAdditionalLabel),
            contactId: Value(contactId),
          ),
        );
      }
    }

    final emailCompanions = <ContactEmailDataCompanion>[];
    final externalContactEmail = externalContact.email;

    // Cleanup old emails
    final externalContactEmails = [if (externalContactEmail != null) externalContactEmail];
    await _appDatabase.contactEmailsDao.deleteOtherContactEmailsOfContactId(contactId, externalContactEmails);

    if (externalContactEmail != null) {
      emailCompanions.add(
        ContactEmailDataCompanion(
          address: Value(externalContactEmail),
          label: const Value(''),
          contactId: Value(contactId),
        ),
      );
    }

    await Future.wait([
      if (phoneCompanions.isNotEmpty) _appDatabase.contactPhonesDao.insertContactPhonesBatch(phoneCompanions),
      if (emailCompanions.isNotEmpty) _appDatabase.contactEmailsDao.insertContactEmailsBatch(emailCompanions),
    ]);
  }

  /// Strip non-digit characters from `number`.
  String _sanitizeNumber(String number) => number.replaceAll(_numberRegExp, '');
}
