import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v21.dart' as v21;

class MigrationV21 extends Migration {
  const MigrationV21();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final presenceTable = v21.PresenceInfo(db);
    await m.deleteTable(presenceTable.actualTableName);
    await m.createTable(presenceTable);

    final dialogTable = v21.DialogInfo(db);
    await m.createTable(dialogTable);
  }
}
