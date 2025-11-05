import 'package:app_database/src/tables/sms_conversations_table.dart';
import 'package:drift/drift.dart';

@DataClassName('SmsOutboxMessageDeleteData')
class SmsOutboxMessageDeleteTable extends Table {
  @override
  String get tableName => 'sms_outbox_message_deletes';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get idKey => text()();

  IntColumn get conversationId => integer().references(SmsConversationsTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();
}
