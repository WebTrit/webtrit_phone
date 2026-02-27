import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v19.dart' as v19;
import 'generated/schema_v18.dart' as v18;

class MigrationV19 extends Migration {
  const MigrationV19();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final favoritesV2Table = v19.FavoritesV2(db);
    await m.createTable(favoritesV2Table);

    final favoritesTable = v18.Favorites(db);
    final contactPhonesTable = v18.ContactPhones(db);
    final contactsTable = v18.Contacts(db);

    final oldFavorites = await favoritesTable.select().join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.id.equalsExp(favoritesTable.contactPhoneId)),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(contactPhonesTable.contactId)),
    ]).get();

    print('Migrating ${oldFavorites.length} favorites to new favorites_v2 table');

    // TODO: finish correct migration

    // final oldFavorites = await db.favoritesDao.getFavoritesWithContactData();
    // final newFavorites = oldFavorites
    //     .map((oldFavorite) {
    //       final sourceId = oldFavorite.contactData.sourceId;
    //       if (sourceId == null) return null;

    //       final sourceType = switch (oldFavorite.contactData.sourceType) {
    //         ContactSourceTypeEnum.external => 'pbx',
    //         ContactSourceTypeEnum.local => 'device',
    //       };

    //       return FavoriteV2Data(
    //         number: oldFavorite.contactPhoneData.number,
    //         sourceType: sourceType,
    //         sourceId: sourceId,
    //         label: oldFavorite.contactPhoneData.label,
    //         position: oldFavorite.favoriteData.position,
    //       );
    //     })
    //     .nonNulls
    //     .toList();
    // await db.favoritesV2Dao.upsertFavorites(newFavorites);
  }
}
