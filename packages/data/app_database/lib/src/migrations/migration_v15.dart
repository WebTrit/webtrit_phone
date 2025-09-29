import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v15.dart' as v15;

class MigrationV15 extends Migration {
  const MigrationV15();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final cdrTable = v15.Cdrs(db);
    await m.createTable(cdrTable);
  }
}
