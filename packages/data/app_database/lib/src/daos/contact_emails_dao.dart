import 'package:drift/drift.dart';

import 'package:app_database/src/app_database.dart';

part 'contact_emails_dao.g.dart';

@DriftAccessor(tables: [ContactEmailsTable])
class ContactEmailsDao extends DatabaseAccessor<AppDatabase> with _$ContactEmailsDaoMixin {
  ContactEmailsDao(super.db);

  SimpleSelectStatement<$ContactEmailsTableTable, ContactEmailData> _selectContactEmailsByContactId(int contactId) {
    return select(contactEmailsTable)
      ..where((t) => t.contactId.equals(contactId))
      ..orderBy([
        (t) => OrderingTerm.asc(t.insertedAt),
      ]);
  }

  Stream<List<ContactEmailData>> watchContactEmailsByContactId(int contactId) {
    return _selectContactEmailsByContactId(contactId).watch();
  }

  Future<List<ContactEmailData>> getContactEmailsByContactId(int contactId) {
    return _selectContactEmailsByContactId(contactId).get();
  }

  Future<int> insertOnUniqueConflictUpdateContactEmail(Insertable<ContactEmailData> entity) {
    return into(contactEmailsTable).insert(
      entity,
      onConflict: DoUpdate((_) => entity, target: [contactEmailsTable.address, contactEmailsTable.contactId]),
    );
  }

  Future<int> deleteOtherContactEmailsOfContactId(int contactId, Iterable<String> addresses) {
    return (delete(contactEmailsTable)
          ..where((t) => t.contactId.equals(contactId))
          ..where((t) => t.address.isNotIn(addresses)))
        .go();
  }
}
