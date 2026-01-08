import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v18.dart' as v18;

class MigrationV18 extends Migration {
  const MigrationV18();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final contactTable = v18.Contacts(db);
    await m.addColumn(contactTable, contactTable.kind);
  }
}
