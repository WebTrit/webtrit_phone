import 'package:app_database/src/app_database.dart';
import 'package:drift/drift.dart';

part 'contact_phones_dao.g.dart';

class ContactPhoneDataWithFavoriteData {
  ContactPhoneDataWithFavoriteData(this.contactPhoneData, this.favoriteData);

  final ContactPhoneData contactPhoneData;
  final FavoriteData? favoriteData;
}

@DriftAccessor(tables: [
  ContactPhonesTable,
  FavoritesTable,
])
class ContactPhonesDao extends DatabaseAccessor<AppDatabase> with _$ContactPhonesDaoMixin {
  ContactPhonesDao(super.db);

  SimpleSelectStatement<$ContactPhonesTableTable, ContactPhoneData> _selectContactPhonesByContactId(int contactId) {
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

  JoinedSelectStatement _selectContactPhonesByContactIdJoinFavorites(int contactId) {
    return _selectContactPhonesByContactId(contactId).join([
      leftOuterJoin(favoritesTable, favoritesTable.contactPhoneId.equalsExp(contactPhonesTable.id)),
    ]);
  }

  ContactPhoneDataWithFavoriteData _mapContactPhoneDataWithFavoriteData(TypedResult row) {
    return ContactPhoneDataWithFavoriteData(
      row.readTable(contactPhonesTable),
      row.readTableOrNull(favoritesTable),
    );
  }

  Stream<List<ContactPhoneDataWithFavoriteData>> watchContactPhonesExtByContactId(int contactId) {
    return _selectContactPhonesByContactIdJoinFavorites(contactId)
        .watch()
        .map((rows) => rows.map(_mapContactPhoneDataWithFavoriteData).toList());
  }

  Future<List<ContactPhoneDataWithFavoriteData>> getContactPhonesExtByContactId(int contactId) {
    return _selectContactPhonesByContactIdJoinFavorites(contactId)
        .get()
        .then((rows) => rows.map(_mapContactPhoneDataWithFavoriteData).toList());
  }

  Future<int> insertOnUniqueConflictUpdateContactPhone(Insertable<ContactPhoneData> contactPhone) {
    return into(contactPhonesTable).insert(
      contactPhone,
      onConflict: DoUpdate((_) => contactPhone, target: [contactPhonesTable.number, contactPhonesTable.contactId]),
    );
  }

  Future<int> deleteOtherContactPhonesOfContactId(int id, Iterable<String> numbers) {
    return (delete(contactPhonesTable)
          ..where((t) => t.contactId.equals(id))
          ..where((t) => t.number.isNotIn(numbers)))
        .go();
  }
}
