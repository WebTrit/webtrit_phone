import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v4.dart' as v4;

class MigrationV4 extends Migration {
  const MigrationV4();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final contactsTable = v4.Contacts(db);
    await m.addColumn(contactsTable, contactsTable.registered);
  }
}
