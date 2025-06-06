import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v14.dart' as v14;

class MigrationV14 extends Migration {
  const MigrationV14();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final systemNotificationsTable = v14.SystemNotifications(db);
    final systemNotificationsOutboxTable = v14.SystemNotificationsOutbox(db);

    await m.createTable(systemNotificationsTable);
    await m.createTable(systemNotificationsOutboxTable);
  }
}
