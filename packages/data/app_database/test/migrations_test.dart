import 'package:test/test.dart';

import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';

import 'package:app_database/app_database.dart';
import 'package:app_database/src/migrations/migrations.dart';

// Import the generated schema helper to instantiate databases at old versions.
import 'package:app_database/src/migrations/generated/schema.dart';
import 'package:app_database/src/migrations/generated/schema_v18.dart' as v18;
import 'package:app_database/src/migrations/generated/schema_v19.dart' as v19;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  // Test all possible schema migrations with a simple test that just ensures
  // the schema is correct after the migration.
  // More complex tests ensuring data integrity are written below.
  group('general migration', () {
    final currentSchema = migrations.schemaVersion;

    for (var oldVersion = 1; oldVersion < currentSchema; oldVersion++) {
      group('from v$oldVersion', () {
        for (var targetVersion = oldVersion + 1; targetVersion <= currentSchema; targetVersion++) {
          test('to v$targetVersion', () async {
            final connection = await verifier.startAt(oldVersion);
            final appDatabase = AppDatabase(connection);
            try {
              await verifier.migrateAndValidate(appDatabase, targetVersion);
            } finally {
              await appDatabase.close();
            }
          });
        }
      });
    }
  });

  group('migration v19 data integrity', () {
    test('migrates old favorites and creates outbox entries', () async {
      final schema = await verifier.schemaAt(18);
      try {
        final oldDb = v18.DatabaseAtV18(schema.newConnection());

        await oldDb.customStatement(
          "INSERT INTO contacts (id, source_type, source_id, kind) VALUES (1, 0, 'device_source_1', 0)",
        );
        await oldDb.customStatement(
          "INSERT INTO contacts (id, source_type, source_id, kind) VALUES (2, 1, 'pbx_source_1', 0)",
        );

        await oldDb.customStatement(
          "INSERT INTO contact_phones (id, number, label, contact_id) VALUES (1, '1001', 'Mobile', 1)",
        );
        await oldDb.customStatement(
          "INSERT INTO contact_phones (id, number, label, contact_id) VALUES (2, '2001', 'Desk', 2)",
        );

        await oldDb.customStatement('INSERT INTO favorites (id, contact_phone_id, position) VALUES (1, 1, 0)');
        await oldDb.customStatement('INSERT INTO favorites (id, contact_phone_id, position) VALUES (2, 2, 1)');
        await oldDb.close();

        final appDatabase = AppDatabase(schema.newConnection());
        await verifier.migrateAndValidate(appDatabase, 19);
        await appDatabase.close();

        final checkDb = v19.DatabaseAtV19(schema.newConnection());

        final favoritesV2Rows = await checkDb.customSelect('''
          SELECT number, source_type, source_id, label, position
          FROM favorites_v2
          ORDER BY position ASC
          ''').get();

        expect(favoritesV2Rows.length, 2);
        expect(favoritesV2Rows[0].read<String>('number'), '1001');
        expect(favoritesV2Rows[0].read<String>('source_type'), 'device');
        expect(favoritesV2Rows[0].read<String>('source_id'), 'device_source_1');
        expect(favoritesV2Rows[0].read<String>('label'), 'Mobile');
        expect(favoritesV2Rows[0].read<int>('position'), 0);

        expect(favoritesV2Rows[1].read<String>('number'), '2001');
        expect(favoritesV2Rows[1].read<String>('source_type'), 'pbx');
        expect(favoritesV2Rows[1].read<String>('source_id'), 'pbx_source_1');
        expect(favoritesV2Rows[1].read<String>('label'), 'Desk');
        expect(favoritesV2Rows[1].read<int>('position'), 1);

        final outboxRows = await checkDb.customSelect('''
          SELECT number, source_type, action, source_id, label, position, send_attempts, timestamp_usec
          FROM favorites_outbox
          ORDER BY position ASC
          ''').get();

        expect(outboxRows.length, 2);

        expect(outboxRows[0].read<String>('number'), '1001');
        expect(outboxRows[0].read<String>('source_type'), 'device');
        expect(outboxRows[0].read<String>('action'), 'upsert');
        expect(outboxRows[0].read<String>('source_id'), 'device_source_1');
        expect(outboxRows[0].read<String>('label'), 'Mobile');
        expect(outboxRows[0].read<int>('position'), 0);
        expect(outboxRows[0].read<int>('send_attempts'), 0);
        expect(outboxRows[0].read<int>('timestamp_usec') > 0, isTrue);

        expect(outboxRows[1].read<String>('number'), '2001');
        expect(outboxRows[1].read<String>('source_type'), 'pbx');
        expect(outboxRows[1].read<String>('action'), 'upsert');
        expect(outboxRows[1].read<String>('source_id'), 'pbx_source_1');
        expect(outboxRows[1].read<String>('label'), 'Desk');
        expect(outboxRows[1].read<int>('position'), 1);
        expect(outboxRows[1].read<int>('send_attempts'), 0);
        expect(outboxRows[1].read<int>('timestamp_usec') > 0, isTrue);
        await checkDb.close();
      } finally {
        schema.close();
      }
    });
  });
}
