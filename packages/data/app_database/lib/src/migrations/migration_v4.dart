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
    final chatQueueTable = v4.ChatQueue(db);

    final newSchemaEntities = <DatabaseSchemaEntity>[
      chatsTable,
      chatMembersTable,
      chatMessagesTable,
      chatQueueTable,
      ...db.generateTableCompanionEntities(chatsTable),
      ...db.generateTableCompanionEntities(chatMembersTable),
      ...db.generateTableCompanionEntities(chatMessagesTable),
      ...db.generateTableCompanionEntities(chatQueueTable),
    ];
    for (final entity in newSchemaEntities) {
      await m.create(entity);
    }
  }
}
