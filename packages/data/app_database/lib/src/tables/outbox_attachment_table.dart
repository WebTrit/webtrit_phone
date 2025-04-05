import 'package:app_database/src/tables/chat_outbox_message_table.dart';
import 'package:app_database/src/tables/sms_outbox_messages_table.dart';

import 'package:drift/drift.dart';

@DataClassName('OutboxAttachmentData')
class OutboxAttachmentTable extends Table {
  @override
  String get tableName => 'outbox_attachments';

  @override
  Set<Column> get primaryKey => {idKey};

  TextColumn get idKey => text()();

  TextColumn get chatsOutboxMessageIdKey => text().nullable().references(
        ChatOutboxMessageTable,
        #idKey,
        onDelete: KeyAction.cascade,
      )();

  TextColumn get smsOutboxMessageIdKey => text().nullable().references(
        SmsOutboxMessagesTable,
        #idKey,
        onDelete: KeyAction.cascade,
      )();

  TextColumn get pickedPath => text()();

  TextColumn get encodedPath => text().nullable()();

  TextColumn get uploadedPath => text().nullable()();
}
