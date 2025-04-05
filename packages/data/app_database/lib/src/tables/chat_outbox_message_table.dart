import 'package:app_database/src/tables/chats_table.dart';
import 'package:drift/drift.dart';

@DataClassName('ChatOutboxMessageData')
class ChatOutboxMessageTable extends Table {
  @override
  String get tableName => 'chat_outbox_messages';

  @override
  Set<Column> get primaryKey => {idKey};

  TextColumn get idKey => text()();

  IntColumn get chatId => integer().nullable().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get participantId => text().nullable()();

  IntColumn get replyToId => integer().nullable()();

  IntColumn get forwardFromId => integer().nullable()();

  TextColumn get authorId => text().nullable()();

  TextColumn get content => text()();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();

  TextColumn get failureCode => text().nullable()();
}
