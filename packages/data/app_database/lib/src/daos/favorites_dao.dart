import 'package:app_database/src/app_database.dart';
import 'package:drift/drift.dart';

part 'favorites_dao.g.dart';

class FavoriteDataWithContactPhoneDataAndContactData {
  FavoriteDataWithContactPhoneDataAndContactData(this.favoriteData, this.contactPhoneData, this.contactData);

  final FavoriteData favoriteData;
  final ContactPhoneData contactPhoneData;
  final ContactData contactData;
}

@DriftAccessor(tables: [
  FavoritesTable,
  ContactPhonesTable,
  ContactsTable,
])
class FavoritesDao extends DatabaseAccessor<AppDatabase> with _$FavoritesDaoMixin {
  FavoritesDao(super.db);

  Stream<List<FavoriteDataWithContactPhoneDataAndContactData>> watchFavoritesExt() {
    final q = (select(favoritesTable)..orderBy([(t) => OrderingTerm.asc(t.position)])).join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.id.equalsExp(favoritesTable.contactPhoneId)),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(contactPhonesTable.contactId)),
    ]);
    return q.watch().map((rows) => rows
        .map((row) => FavoriteDataWithContactPhoneDataAndContactData(
              row.readTable(favoritesTable),
              row.readTable(contactPhonesTable),
              row.readTable(contactsTable),
            ))
        .toList());
  }

  Future<int> insertFavoriteByContactPhoneId(int contactPhoneId) => customInsert(
        'INSERT INTO favorites (contact_phone_id, position) VALUES (?, (SELECT ifnull(max(position), 0) + 1 FROM favorites))',
        variables: [Variable.withInt(contactPhoneId)],
        updates: {favoritesTable},
      );

  Future<int> deleteByContactPhoneId(int contactPhoneId) =>
      (delete(favoritesTable)..where((t) => t.contactPhoneId.equals(contactPhoneId))).go();

  Future<int> deleteFavorite(Insertable<FavoriteData> favoriteData) => delete(favoritesTable).delete(favoriteData);
}
