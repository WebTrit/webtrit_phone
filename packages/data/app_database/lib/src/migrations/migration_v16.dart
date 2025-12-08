import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v16.dart' as v16;

class MigrationV16 extends Migration {
  const MigrationV16();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final cdrTable = v16.Cdrs(db);

    // recreate table with breaking changes
    await m.deleteTable(cdrTable.aliasedName);
    await m.createTable(cdrTable);
  }
}
