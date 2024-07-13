import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v4.dart' as v4;

class MigrationV4 extends Migration {
  const MigrationV4();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final chatsTable = v4.Chats(db);
    final chatMembersTable = v4.ChatMembers(db);
    final chatMessagesTable = v4.ChatMessages(db);
    final chatOutboxMessagesTable = v4.ChatOutboxMessages(db);
    final chatOutboxMessageEditsTable = v4.ChatOutboxMessageEdits(db);
    final chatOutboxMessageDeletesTable = v4.ChatOutboxMessageDeletes(db);
    final chatMessageSyncCursorTable = v4.ChatMessageSyncCursors(db);

    final newSchemaEntities = <DatabaseSchemaEntity>[
      chatsTable,
      chatMembersTable,
      chatMessagesTable,
      chatOutboxMessagesTable,
      chatOutboxMessageEditsTable,
      chatOutboxMessageDeletesTable,
      chatMessageSyncCursorTable,
      ...db.generateTableCompanionEntities(chatsTable),
      ...db.generateTableCompanionEntities(chatMembersTable),
      ...db.generateTableCompanionEntities(chatMessagesTable),
      ...db.generateTableCompanionEntities(chatOutboxMessagesTable),
      ...db.generateTableCompanionEntities(chatOutboxMessageEditsTable),
      ...db.generateTableCompanionEntities(chatOutboxMessageDeletesTable),
      ...db.generateTableCompanionEntities(chatMessageSyncCursorTable),
    ];
    for (final entity in newSchemaEntities) {
      await m.create(entity);
    }
  }
}
