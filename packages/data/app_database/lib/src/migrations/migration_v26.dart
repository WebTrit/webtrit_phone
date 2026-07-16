import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v26.dart' as v26;

class MigrationV26 extends Migration {
  const MigrationV26();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    await m.createTable(v26.Transcriptions(db));
  }
}
