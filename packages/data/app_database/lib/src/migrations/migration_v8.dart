import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v8.dart' as v8;

class MigrationV8 extends Migration {
  const MigrationV8();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final readCursorsTable = v8.ChatMessageReadCursors(db);
    final readCursorsOutboxTable = v8.ChatOutboxReadCursors(db);
    await m.createTable(readCursorsTable);
    await m.createTable(readCursorsOutboxTable);
  }
}
