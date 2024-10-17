import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v7.dart' as v7;

class MigrationV7 extends Migration {
  const MigrationV7();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final chatsTable = v7.Chats(db);
    final chatMembersTable = v7.ChatMembers(db);
    final chatMessagesTable = v7.ChatMessages(db);
    final chatOutboxMessagesTable = v7.ChatOutboxMessages(db);
    final chatOutboxMessageEditsTable = v7.ChatOutboxMessageEdits(db);
    final chatOutboxMessageDeletesTable = v7.ChatOutboxMessageDeletes(db);
    final chatOutboxMessageViewsTable = v7.ChatOutboxMessageViews(db);
    final chatMessageSyncCursorTable = v7.ChatMessageSyncCursors(db);

    final newSchemaEntities = <DatabaseSchemaEntity>[
      chatsTable,
      chatMembersTable,
      chatMessagesTable,
      chatOutboxMessagesTable,
      chatOutboxMessageEditsTable,
      chatOutboxMessageDeletesTable,
      chatOutboxMessageViewsTable,
      chatMessageSyncCursorTable,
      ...db.generateTableCompanionEntities(chatsTable),
      ...db.generateTableCompanionEntities(chatMembersTable),
      ...db.generateTableCompanionEntities(chatMessagesTable),
      ...db.generateTableCompanionEntities(chatOutboxMessagesTable),
      ...db.generateTableCompanionEntities(chatOutboxMessageEditsTable),
      ...db.generateTableCompanionEntities(chatOutboxMessageDeletesTable),
      ...db.generateTableCompanionEntities(chatOutboxMessageViewsTable),
      ...db.generateTableCompanionEntities(chatMessageSyncCursorTable),
    ];
    for (final entity in newSchemaEntities) {
      await m.create(entity);
    }
  }
}
