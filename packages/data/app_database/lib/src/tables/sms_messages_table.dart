import 'package:app_database/src/tables/sms_conversations_table.dart';
import 'package:drift/drift.dart';

enum SmsSendingStatusEnum { waiting, sent, failed, delivered }

@DataClassName('SmsMessageData')
class SmsMessagesTable extends Table {
  @override
  String get tableName => 'sms_messages';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get idKey => text()();

  TextColumn get externalId => text().nullable()();

  IntColumn get conversationId => integer().references(SmsConversationsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get fromPhoneNumber => text()();

  TextColumn get toPhoneNumber => text()();

  TextColumn get sendingStatus => textEnum<SmsSendingStatusEnum>()();

  TextColumn get content => text()();

  IntColumn get createdAtRemoteUsec => integer()();

  IntColumn get updatedAtRemoteUsec => integer()();

  IntColumn get deletedAtRemoteUsec => integer().nullable()();
}
