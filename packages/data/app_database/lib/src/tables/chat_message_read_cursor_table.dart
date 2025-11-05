import 'package:app_database/src/tables/chats_table.dart';
import 'package:drift/drift.dart';

@DataClassName('ChatMessageReadCursorData')
class ChatMessageReadCursorTable extends Table {
  @override
  String get tableName => 'chat_message_read_cursors';

  @override
  Set<Column> get primaryKey => {chatId, userId};

  IntColumn get chatId =>
      integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get userId => text()();

  IntColumn get timestampUsec => integer()();
}
