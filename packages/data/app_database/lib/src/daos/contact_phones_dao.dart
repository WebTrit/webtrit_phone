import 'package:app_database/src/app_database.dart';
import 'package:drift/drift.dart';

part 'contact_phones_dao.g.dart';

@DriftAccessor(tables: [
  ContactPhonesTable,
  FavoritesTable,
])
class ContactPhonesDao extends DatabaseAccessor<AppDatabase>
    with _$ContactPhonesDaoMixin {
  ContactPhonesDao(super.db);

  SimpleSelectStatement<$ContactPhonesTableTable, ContactPhoneData>
      _selectContactPhonesByContactId(int contactId) {
    return select(contactPhonesTable)
      ..where((t) => t.contactId.equals(contactId))
      ..orderBy([
        (t) => OrderingTerm.asc(t.insertedAt),
      ]);
  }

  Stream<List<ContactPhoneData>> watchContactPhonesByContactId(int contactId) {
    return _selectContactPhonesByContactId(contactId).watch();
  }

  Future<List<ContactPhoneData>> getContactPhonesByContactId(int contactId) {
    return _selectContactPhonesByContactId(contactId).get();
  }

  Future<int> insertOnUniqueConflictUpdateContactPhone(
      Insertable<ContactPhoneData> contactPhone) {
    return into(contactPhonesTable).insert(
      contactPhone,
      onConflict: DoUpdate((_) => contactPhone,
          target: [contactPhonesTable.number, contactPhonesTable.contactId]),
    );
  }

  Future<int> deleteOtherContactPhonesOfContactId(
      int id, Iterable<String> numbers) {
    return (delete(contactPhonesTable)
          ..where((t) => t.contactId.equals(id))
          ..where((t) => t.number.isNotIn(numbers)))
        .go();
  }
}
