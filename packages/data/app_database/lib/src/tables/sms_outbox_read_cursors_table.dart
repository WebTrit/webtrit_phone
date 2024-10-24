import 'package:app_database/src/tables/sms_conversations_table.dart';
import 'package:drift/drift.dart';

@DataClassName('SmsOutboxReadCursorData')
class SmsOutboxReadCursorsTable extends Table {
  @override
  String get tableName => 'sms_outbox_read_cursors';

  @override
  Set<Column> get primaryKey => {conversationId};

  IntColumn get conversationId => integer().references(SmsConversationsTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get timestampUsec => integer()();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();
}
