import 'package:test/test.dart';

import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';

import 'package:app_database/app_database.dart';
import 'package:app_database/src/migrations/migrations.dart';

// Import the generated schema helper to instantiate databases at old versions.
import 'package:app_database/src/migrations/generated/schema.dart';

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
}
