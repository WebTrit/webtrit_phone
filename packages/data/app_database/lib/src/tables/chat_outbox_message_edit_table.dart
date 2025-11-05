import 'package:app_database/src/tables/chats_table.dart';
import 'package:drift/drift.dart';

@DataClassName('ChatOutboxMessageEditData')
class ChatOutboxMessageEditTable extends Table {
  @override
  String get tableName => 'chat_outbox_message_edits';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get idKey => text()();

  IntColumn get chatId => integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get newContent => text()();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();
}
