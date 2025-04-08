import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

import 'generated/schema_v12.dart' as v12;

class MigrationV12 extends Migration {
  const MigrationV12();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    final chatOutboxMessagesTable = v12.ChatOutboxMessages(db);
    final smsOutboxMessagesTable = v12.SmsOutboxMessages(db);
    final outboxAttachmentsTable = v12.OutboxAttachments(db);
    final messageAttachmentsTable = v12.MessageAttachments(db);

    await m.deleteTable(chatOutboxMessagesTable.aliasedName);
    await m.createTable(chatOutboxMessagesTable);

    await m.deleteTable(smsOutboxMessagesTable.aliasedName);
    await m.createTable(smsOutboxMessagesTable);

    await m.createTable(outboxAttachmentsTable);
    await m.createTable(messageAttachmentsTable);
  }
}
