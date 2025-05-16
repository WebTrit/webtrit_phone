import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v13.dart' as v13;

class MigrationV13 extends Migration {
  const MigrationV13();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final callLogsTable = v13.CallLogs(db);
    await m.addColumn(callLogsTable, callLogsTable.username);
  }
}
