import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class ContactsLocalDataSource {
  Future<int> upsertContact(ExternalContact externalContact, ContactKind kind);
}

class ContactsLocalDataSourceImpl implements ContactsLocalDataSource {
  ContactsLocalDataSourceImpl(this._appDatabase);

  final AppDatabase _appDatabase;

  // TODO: This logic almost is duplicated from ExternalContactsRepository.
  // The plan is to refactor this and use a single source of truth for contact
  // updates to avoid the current situation where every change needs to be
  // synchronized in two places.
  @override
  Future<int> upsertContact(ExternalContact externalContact, ContactKind kind) async {
    return _appDatabase.transaction(() async {
      final insertOrUpdateContactData = await _appDatabase.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: const Value(ContactSourceTypeEnum.external),
          // Ensure a stable and unique sourceId for deduplication and upsert logic.
          // Falls back to contact number, email, or a hashed identity if no API-provided ID is available.
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
      // Some external accounts legitimately have `ext` equal to `number`
      // (e.g. auto-provisioned users where the signup flow copies main into ext).
      //
      // In our local DB phone records are keyed by (contact_id, number), so each
      // distinct phone number is stored only once. When we upsert phones, the last
      // write "wins" for a given (contact_id, number) pair.
      //
      // If we insert both `number` and `ext` when they are the same value, the
      // second upsert for label 'ext' overwrites the existing row that was created
      // for label 'number'. As a result, the primary "number" entry disappears and
      // the UI shows "Unknown" for the main number, while the same value is only
      // visible under the 'ext' label.
      //
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
      if (externalContactAdditional != null) {
        for (final externalContactAdditionalNumber in externalContactAdditional) {
          await _appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
            ContactPhoneDataCompanion(
              number: Value(externalContactAdditionalNumber),
              label: const Value('additional'),
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
