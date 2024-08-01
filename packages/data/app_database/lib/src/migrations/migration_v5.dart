import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v5.dart' as v5;

class MigrationV5 extends Migration {
  const MigrationV5();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final contactsTable = v5.Contacts(db);
    await m.addColumn(contactsTable, contactsTable.thumbnail);
  }
}
