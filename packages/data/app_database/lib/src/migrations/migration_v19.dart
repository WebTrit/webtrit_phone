import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v19.dart' as v19;

class MigrationV19 extends Migration {
  const MigrationV19();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final contactPhonesTable = v19.ContactPhones(db);
    await m.renameColumn(contactPhonesTable, 'number', contactPhonesTable.rawNumber);
    await m.addColumn(contactPhonesTable, contactPhonesTable.sanitizedNumber);
  }
}
