import 'package:app_database/src/tables/chat_messages_table.dart';
import 'package:app_database/src/tables/sms_messages_table.dart';

import 'package:drift/drift.dart';

@DataClassName('MessageAttachmentData')
class MessageAttachmentTable extends Table {
  @override
  String get tableName => 'message_attachments';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  IntColumn get chatsMessageId => integer().nullable().references(
        ChatMessagesTable,
        #id,
        onDelete: KeyAction.cascade,
      )();

  IntColumn get smsMessageId => integer().nullable().references(
        SmsMessagesTable,
        #id,
        onDelete: KeyAction.cascade,
      )();

  TextColumn get fileName => text()();

  TextColumn get filePath => text()();
}
