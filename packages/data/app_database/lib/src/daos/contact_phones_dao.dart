import 'package:app_database/src/app_database.dart';
import 'package:drift/drift.dart';

part 'contact_phones_dao.g.dart';

@DriftAccessor(tables: [ContactPhonesTable, FavoritesTable])
class ContactPhonesDao extends DatabaseAccessor<AppDatabase> with _$ContactPhonesDaoMixin {
  ContactPhonesDao(super.db);

  SimpleSelectStatement<$ContactPhonesTableTable, ContactPhoneData> _selectContactPhonesByContactId(int contactId) {
    return select(contactPhonesTable)
      ..where((t) => t.contactId.equals(contactId))
      ..orderBy([(t) => OrderingTerm.asc(t.insertedAt)]);
  }

  Stream<List<ContactPhoneData>> watchContactPhonesByContactId(int contactId) {
    return _selectContactPhonesByContactId(contactId).watch();
  }

  Future<List<ContactPhoneData>> getContactPhonesByContactId(int contactId) {
    return _selectContactPhonesByContactId(contactId).get();
  }

  Future<int> insertOnUniqueConflictUpdateContactPhone(Insertable<ContactPhoneData> contactPhone) {
    return into(contactPhonesTable).insert(
      contactPhone,
      onConflict: DoUpdate(
        (_) => contactPhone,
        target: [contactPhonesTable.number, contactPhonesTable.label, contactPhonesTable.contactId],
      ),
    );
  }

  /// Deletes all phone rows for [contactId] that are NOT present in [pairs].
  ///
  /// Each pair is a `(number, label)` tuple that identifies a row to keep.
  /// If [pairs] is empty, all phones for the contact are deleted.
  Future<void> deleteOtherContactPhonesOfContactId(int contactId, List<({String number, String label})> pairs) async {
    // No phones to keep - wipe all rows for this contact.
    if (pairs.isEmpty) {
      await (delete(contactPhonesTable)..where((t) => t.contactId.equals(contactId))).go();
      return;
    }

    // Build a keep-expression: rows whose (number, label) is in [pairs] are retained;
    // everything else for this contact is deleted.
    final keepExpr = pairs
        .map<Expression<bool>>(
          (p) => contactPhonesTable.number.equals(p.number) & contactPhonesTable.label.equals(p.label),
        )
        .reduce((a, b) => a | b);

    await (delete(contactPhonesTable)..where((t) => t.contactId.equals(contactId) & keepExpr.not())).go();
  }

  Future<void> insertContactPhonesBatch(List<ContactPhoneDataCompanion> phones) {
    if (phones.isEmpty) return Future.value();
    return batch((batch) {
      for (final phone in phones) {
        batch.insert(
          contactPhonesTable,
          phone,
          onConflict: DoUpdate(
            (old) => phone,
            target: [contactPhonesTable.number, contactPhonesTable.label, contactPhonesTable.contactId],
          ),
        );
      }
    });
  }
}
