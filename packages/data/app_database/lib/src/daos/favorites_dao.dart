import 'package:app_database/src/app_database.dart';
import 'package:drift/drift.dart';

part 'favorites_dao.g.dart';

class FavoriteWithContactData {
  FavoriteWithContactData(
    this.favoriteData,
    this.contactPhoneData,
    this.contactData,
    this.contactPhones,
    this.contactEmails,
    this.contactPresenceInfo,
  );

  final FavoriteData favoriteData;
  final ContactPhoneData contactPhoneData;
  final ContactData contactData;
  final Set<ContactPhoneData> contactPhones;
  final Set<ContactEmailData> contactEmails;
  final Set<PresenceInfoData> contactPresenceInfo;
}

@DriftAccessor(tables: [
  FavoritesTable,
  ContactsTable,
  ContactPhonesTable,
  ContactEmailsTable,
  PresenceInfoTable
])
class FavoritesDao extends DatabaseAccessor<AppDatabase>
    with _$FavoritesDaoMixin {
  FavoritesDao(super.db);

  Stream<List<FavoriteWithContactData>> watchFavoritesExt() {
    final q = (select(favoritesTable)
          ..orderBy([(t) => OrderingTerm.asc(t.position)]))
        .join([
      leftOuterJoin(_sourcePhone,
          favoritesTable.contactPhoneId.equalsExp(_sourcePhone.id)),
      leftOuterJoin(
          contactsTable, contactsTable.id.equalsExp(_sourcePhone.contactId)),
      leftOuterJoin(contactEmailsTable,
          contactEmailsTable.contactId.equalsExp(contactsTable.id)),
      leftOuterJoin(
          _contactPhones, _contactPhones.contactId.equalsExp(contactsTable.id)),
      leftOuterJoin(presenceInfoTable,
          presenceInfoTable.number.equalsExp(_contactPhones.number)),
    ]);
    return q.watch().map(_rowsToData);
  }

  Future<int> insertFavoriteByContactPhoneId(int contactPhoneId) =>
      customInsert(
        'INSERT INTO favorites (contact_phone_id, position) VALUES (?, (SELECT ifnull(max(position), 0) + 1 FROM favorites))',
        variables: [Variable.withInt(contactPhoneId)],
        updates: {favoritesTable},
      );

  Future<int> deleteByContactPhoneId(int contactPhoneId) =>
      (delete(favoritesTable)
            ..where((t) => t.contactPhoneId.equals(contactPhoneId)))
          .go();

  Future<int> deleteFavorite(Insertable<FavoriteData> favoriteData) =>
      delete(favoritesTable).delete(favoriteData);

  List<FavoriteWithContactData> _rowsToData(Iterable<TypedResult> rows) {
    Map<int, FavoriteWithContactData> favorites = {};

    for (final row in rows) {
      final favoriteData = row.readTable(favoritesTable);
      final contactData = row.readTable(contactsTable);
      final sourcePhone = row.readTable(_sourcePhone);

      final contactPhone = row.readTableOrNull(_contactPhones);
      final contactEmail = row.readTableOrNull(contactEmailsTable);
      final presenceInfo = row.readTableOrNull(presenceInfoTable);

      favorites.putIfAbsent(
        favoriteData.id,
        () => FavoriteWithContactData(
            favoriteData, sourcePhone, contactData, {}, {}, {}),
      );

      if (contactPhone != null)
        favorites[favoriteData.id]!.contactPhones.add(contactPhone);
      if (contactEmail != null)
        favorites[favoriteData.id]!.contactEmails.add(contactEmail);
      if (presenceInfo != null)
        favorites[favoriteData.id]!.contactPresenceInfo.add(presenceInfo);
    }

    return favorites.values.toList();
  }

  get _sourcePhone => alias(contactPhonesTable, 'source_phone');
  get _contactPhones => alias(contactPhonesTable, 'contact_phones');
}
