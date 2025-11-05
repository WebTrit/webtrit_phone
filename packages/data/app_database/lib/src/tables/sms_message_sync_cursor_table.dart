import 'package:app_database/src/tables/sms_conversations_table.dart';
import 'package:drift/drift.dart';

enum SmsSyncCursorTypeEnum { oldest, newest }

@DataClassName('SmsMessageSyncCursorData')
class SmsMessageSyncCursorTable extends Table {
  @override
  String get tableName => 'sms_message_sync_cursors';

  @override
  Set<Column> get primaryKey => {conversationId, cursorType};

  IntColumn get conversationId => integer()
      .references(SmsConversationsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get cursorType => textEnum<SmsSyncCursorTypeEnum>()();

  IntColumn get timestampUsec => integer()();
}
