import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v5.dart' as v5;

class MigrationV5 extends Migration {
  const MigrationV5();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final chatsTable = v5.Chats(db);
    final chatMembersTable = v5.ChatMembers(db);
    final chatMessagesTable = v5.ChatMessages(db);
    final chatOutboxMessagesTable = v5.ChatOutboxMessages(db);
    final chatOutboxMessageEditsTable = v5.ChatOutboxMessageEdits(db);
    final chatOutboxMessageDeletesTable = v5.ChatOutboxMessageDeletes(db);
    final chatOutboxMessageViewsTable = v5.ChatOutboxMessageViews(db);
    final chatMessageSyncCursorTable = v5.ChatMessageSyncCursors(db);

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
