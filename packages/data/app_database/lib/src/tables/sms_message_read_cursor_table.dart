import 'package:app_database/src/tables/sms_conversations_table.dart';
import 'package:drift/drift.dart';

@DataClassName('SmsMessageReadCursorData')
class SmsMessageReadCursorTable extends Table {
  @override
  String get tableName => 'sms_message_read_cursors';

  @override
  Set<Column> get primaryKey => {conversationId, userId};

  IntColumn get conversationId => integer()
      .references(SmsConversationsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get userId => text()();

  IntColumn get timestampUsec => integer()();
}
