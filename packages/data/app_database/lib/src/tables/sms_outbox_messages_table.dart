import 'package:app_database/src/tables/sms_conversations_table.dart';
import 'package:drift/drift.dart';

@DataClassName('SmsOutboxMessageData')
class SmsOutboxMessagesTable extends Table {
  @override
  String get tableName => 'sms_outbox_messages';

  @override
  Set<Column> get primaryKey => {idKey};

  TextColumn get idKey => text()();

  IntColumn get conversationId =>
      integer().nullable().references(SmsConversationsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get fromPhoneNumber => text()();

  TextColumn get toPhoneNumber => text()();

  TextColumn get recepientId => text().nullable()();

  TextColumn get content => text()();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();
}
