import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v10.dart' as v10;

class MigrationV10 extends Migration {
  const MigrationV10();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final contactsTable = v10.Contacts(db);

    await m.alterTable(TableMigration(contactsTable, columnTransformer: {}));
  }
}
