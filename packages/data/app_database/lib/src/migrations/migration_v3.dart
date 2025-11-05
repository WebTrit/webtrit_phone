import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

class MigrationV3 extends Migration {
  const MigrationV3();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    await m.renameColumn(
        db.contactsTable, 'display_name', db.contactsTable.aliasName);
  }
}
