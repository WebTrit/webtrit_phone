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
    final favoritesOutboxTable = v19.FavoritesOutbox(db);

    await m.createTable(favoritesV2Table);
    await m.createTable(favoritesOutboxTable);

    final favoritesTable = v18.Favorites(db);
    final contactPhonesTable = v18.ContactPhones(db);
    final contactsTable = v18.Contacts(db);

    await db.customStatement('''
      INSERT INTO ${favoritesV2Table.actualTableName} (
        number,
        source_type,
        source_id,
        label,
        position
      )
      SELECT
        mapped.number,
        mapped.source_type,
        mapped.source_id,
        mapped.label,
        MIN(mapped.position) AS position
      FROM (
        SELECT
          cp.number AS number,
          CASE c.source_type
            WHEN 0 THEN 'device'
            WHEN 1 THEN 'pbx'
            ELSE NULL
          END AS source_type,
          c.source_id AS source_id,
          cp.label AS label,
          f.position AS position
        FROM ${favoritesTable.actualTableName} f
        LEFT JOIN ${contactPhonesTable.actualTableName} cp ON cp.id = f.contact_phone_id
        LEFT JOIN ${contactsTable.actualTableName} c ON c.id = cp.contact_id
      ) AS mapped
      WHERE mapped.number IS NOT NULL
        AND mapped.source_type IS NOT NULL
        AND mapped.source_id IS NOT NULL
        AND mapped.label IS NOT NULL
        AND mapped.position IS NOT NULL
      GROUP BY mapped.number, mapped.source_type
    ''');

    final timestampUsec = DateTime.now().microsecondsSinceEpoch;

    await db.customStatement(
      '''
      INSERT INTO ${favoritesOutboxTable.actualTableName} (
        number,
        source_type,
        action,
        source_id,
        label,
        position,
        send_attempts,
        timestamp_usec
      )
      SELECT
        number,
        source_type,
        'upsert',
        source_id,
        label,
        position,
        0,
        ?
      FROM ${favoritesV2Table.actualTableName}
      ''',
      [timestampUsec],
    );
  }
}
