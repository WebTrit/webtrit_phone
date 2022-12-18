import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v2.dart' as v2;

class MigrationV2 extends Migration {
  const MigrationV2();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final contactEmailsTable = v2.ContactEmails(db);
    final newSchemaEntities = [
      contactEmailsTable,
      ...db.generateTableCompanionEntities(contactEmailsTable),
    ];
    for (final entity in newSchemaEntities) {
      await m.create(entity);
    }
  }
}
