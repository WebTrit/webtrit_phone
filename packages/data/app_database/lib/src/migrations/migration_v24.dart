import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v24.dart' as v24;

class MigrationV24 extends Migration {
  const MigrationV24();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final dialogInfoTable = v24.DialogInfo(db);
    await m.addColumn(dialogInfoTable, dialogInfoTable.hasVideo);
  }
}
