import '../migration.dart';

import 'migration_v2.dart';
import 'migration_v3.dart';
import 'migration_v4.dart';
import 'migration_v5.dart';
import 'migration_v6.dart';
import 'migration_v7.dart';
import 'migration_v8.dart';
import 'migration_v9.dart';
import 'migration_v10.dart';
import 'migration_v11.dart';
import 'migration_v12.dart';
import 'migration_v13.dart';
import 'migration_v14.dart';
import 'migration_v15.dart';
import 'migration_v16.dart';

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
  MigrationV6(),
  MigrationV7(),
  MigrationV8(),
  MigrationV9(),
  MigrationV10(),
  MigrationV11(),
  MigrationV12(),
  MigrationV13(),
  MigrationV14(),
  MigrationV15(),
  MigrationV16(),
];
