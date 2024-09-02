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
    final chatMessagesTable = v8.ChatMessages(db);
    final syncCursorsTable = v8.ChatMessageSyncCursors(db);
    await m.createTable(readCursorsTable);
    await m.createTable(readCursorsOutboxTable);
    await m.deleteTable(chatMessagesTable.aliasedName);
    await m.createTable(chatMessagesTable);
    await m.deleteTable(syncCursorsTable.aliasedName);
    await m.createTable(syncCursorsTable);
  }
}
