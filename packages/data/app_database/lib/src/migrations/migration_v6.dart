import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v6.dart' as v6;

class MigrationV6 extends Migration {
  const MigrationV6();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final contactsTable = v6.Contacts(db);
    await m.addColumn(contactsTable, contactsTable.userRegistered);
    await m.addColumn(contactsTable, contactsTable.isCurrentUser);
  }
}
