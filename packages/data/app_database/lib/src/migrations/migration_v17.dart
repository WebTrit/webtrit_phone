import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v17.dart' as v17;

class MigrationV17 extends Migration {
  const MigrationV17();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final presenceInfoTable = v17.PresenceInfo(db);
    await m.createTable(presenceInfoTable);
  }
}
