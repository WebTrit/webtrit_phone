import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v12.dart' as v12;

class MigrationV12 extends Migration {
  const MigrationV12();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    await m.createTable(v12.Voicemails(db));
  }
}
