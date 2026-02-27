import 'package:app_database/src/app_database.dart';
import 'package:drift/drift.dart';

part 'favorites_v2_dao.g.dart';

typedef FavoriteKeyData = (String number, FavoriteSourceTypeData sourceType);

typedef ContactDatas = ({
  ContactData contactData,
  Set<ContactPhoneData> contactPhones,
  Set<ContactEmailData> contactEmails,
  Set<PresenceInfoData> contactPresenceInfo,
});

typedef FavoriteWithContactDataV2 = ({FavoriteV2Data favoriteData, ContactDatas? contactDatas});

@DriftAccessor(tables: [FavoritesV2Table, ContactsTable, ContactPhonesTable, ContactEmailsTable, PresenceInfoTable])
class FavoritesV2Dao extends DatabaseAccessor<AppDatabase> with _$FavoritesV2DaoMixin {
  FavoritesV2Dao(super.db);

  late final $ContactPhonesTableTable _sourcePhone = alias(contactPhonesTable, 'source_phone');
  late final $ContactPhonesTableTable _contactPhones = alias(contactPhonesTable, 'contact_phones');

  Stream<List<FavoriteWithContactDataV2>> watchWithContacts() {
    final q = (select(favoritesV2Table)..orderBy([(t) => OrderingTerm.asc(t.position)])).join([
      leftOuterJoin(_sourcePhone, favoritesV2Table.number.equalsExp(_sourcePhone.number)),
      leftOuterJoin(
        contactsTable,
        contactsTable.id.equalsExp(_sourcePhone.contactId) &
            ((favoritesV2Table.sourceType.equalsValue(FavoriteSourceTypeData.pbx) &
                    contactsTable.sourceType.equalsValue(ContactSourceTypeEnum.external)) |
                (favoritesV2Table.sourceType.equalsValue(FavoriteSourceTypeData.device) &
                    contactsTable.sourceType.equalsValue(ContactSourceTypeEnum.local))),
      ),
      leftOuterJoin(contactEmailsTable, contactEmailsTable.contactId.equalsExp(contactsTable.id)),
      leftOuterJoin(_contactPhones, _contactPhones.contactId.equalsExp(contactsTable.id)),
      leftOuterJoin(presenceInfoTable, presenceInfoTable.number.equalsExp(_contactPhones.number)),
    ]);
    return q.watch().map(_rowsToData);
  }

  List<FavoriteWithContactDataV2> _rowsToData(Iterable<TypedResult> rows) {
    Map<FavoriteKeyData, FavoriteWithContactDataV2> favorites = {};

    for (final row in rows) {
      final favoriteData = row.readTable(favoritesV2Table);
      final contactData = row.readTableOrNull(contactsTable);
      final contactPhone = row.readTableOrNull(_contactPhones);
      final contactEmail = row.readTableOrNull(contactEmailsTable);
      final presenceInfo = row.readTableOrNull(presenceInfoTable);

      final key = (favoriteData.number, favoriteData.sourceType);

      favorites.putIfAbsent(
        key,
        () => (
          favoriteData: favoriteData,
          contactDatas: contactData != null
              ? (contactData: contactData, contactPhones: {}, contactEmails: {}, contactPresenceInfo: {})
              : null,
        ),
      );

      if (contactPhone != null) favorites[key]!.contactDatas?.contactPhones.add(contactPhone);
      if (contactEmail != null) favorites[key]!.contactDatas?.contactEmails.add(contactEmail);
      if (presenceInfo != null) favorites[key]!.contactDatas?.contactPresenceInfo.add(presenceInfo);
    }

    return favorites.values.toList();
  }

  Stream<List<FavoriteV2Data>> watchAll() {
    final query = select(favoritesV2Table)..orderBy([(table) => OrderingTerm.asc(table.position)]);
    return query.watch();
  }

  Future<List<FavoriteV2Data>> getAll() {
    final query = select(favoritesV2Table)..orderBy([(table) => OrderingTerm.asc(table.position)]);
    return query.get();
  }

  Future<void> add(String number, FavoriteSourceTypeData sourceType, String sourceId, String label) {
    return transaction(() async {
      final maxPosition =
          (await (selectOnly(
            favoritesV2Table,
          )..addColumns([favoritesV2Table.position.max()])).getSingle()).read(favoritesV2Table.position.max()) ??
          0;
      final newFavorite = FavoriteV2Data(
        number: number,
        sourceType: sourceType,
        sourceId: sourceId,
        label: label,
        position: maxPosition + 1,
      );
      await into(favoritesV2Table).insert(newFavorite);
    });
  }

  Future<void> shift(FavoriteKeyData key, int position) {
    final (number, sourceType) = key;
    return transaction(() async {
      final favoritesOld = await getAll();

      List<FavoriteV2Data> favoritesNew = [];

      final oldFavorite = favoritesOld.firstWhere((f) => f.number == number && f.sourceType == sourceType);
      final favoritesWithout = List.of(
        favoritesOld,
      ).where((f) => !(f.number == number && f.sourceType == sourceType)).toList();
      favoritesWithout.insert(position, oldFavorite);

      for (var i = 0; i < favoritesWithout.length; i++) {
        final f = favoritesWithout[i];
        favoritesNew.add(
          FavoriteV2Data(number: f.number, sourceType: f.sourceType, sourceId: f.sourceId, label: f.label, position: i),
        );
      }

      await batch((batch) {
        batch.insertAllOnConflictUpdate(favoritesV2Table, favoritesNew);
      });
    });
  }

  Future<void> remove(FavoriteKeyData key) {
    final (number, sourceType) = key;
    final query = delete(favoritesV2Table)
      ..where((table) => table.number.equals(number) & table.sourceType.equals(sourceType.name));
    return query.go();
  }

  Future<void> wipe() {
    return delete(favoritesV2Table).go();
  }
}
