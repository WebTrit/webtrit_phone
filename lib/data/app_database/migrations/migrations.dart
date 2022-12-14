import '../migration.dart';

extension MigrationsSchemaVersion<T extends Migration> on Iterable<T> {
  int get schemaVersion => length + 1;
}

// Steps that must proceed after each migration add:
// 1. dump a new schema (where <N> must be replaced with the version number of added migration):
//    $ flutter pub run drift_dev schema dump lib/data/app_database/app_database.dart lib/data/app_database/drift_schemas/drift_schema_v<N>.json
// 2. generate migration schemas for test:
//    $ flutter pub run drift_dev schema generate lib/data/app_database/drift_schemas/ test/data/app_database/generated_migrations/
// 3. add necessary tests
const migrations = <Migration>[];
