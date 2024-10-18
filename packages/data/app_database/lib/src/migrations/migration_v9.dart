import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v9.dart' as v9;

class MigrationV9 extends Migration {
  const MigrationV9();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    await m.createTable(v9.ActiveMessagingNotifications(db));
  }
}
