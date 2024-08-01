import '../migration.dart';

import 'migration_v2.dart';
import 'migration_v3.dart';
import 'migration_v4.dart';
import 'migration_v5.dart';

extension MigrationsSchemaVersion<T extends Migration> on Iterable<T> {
  int get schemaVersion => length + 1;
}

// Steps that must proceed after each migration add:
// 1. Create a new schema dump and test migration based on the current application database:
//    $ dart run bin/create_new_schema_dump_and_test_migration.dart
// 2. Add necessary tests
const migrations = <Migration>[
  MigrationV2(),
  MigrationV3(),
  MigrationV4(),
  MigrationV5(),
];
