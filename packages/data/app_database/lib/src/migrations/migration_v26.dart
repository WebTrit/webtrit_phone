import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

class MigrationV26 extends Migration {
  const MigrationV26();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    await m.createTable(db.transcriptionTable);
  }
}
