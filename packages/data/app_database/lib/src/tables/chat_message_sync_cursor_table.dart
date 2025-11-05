import 'package:app_database/src/tables/chats_table.dart';
import 'package:drift/drift.dart';

enum MessageSyncCursorTypeEnum { oldest, newest }

@DataClassName('ChatMessageSyncCursorData')
class ChatMessageSyncCursorTable extends Table {
  @override
  String get tableName => 'chat_message_sync_cursors';

  @override
  Set<Column> get primaryKey => {chatId, cursorType};

  IntColumn get chatId =>
      integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get cursorType => textEnum<MessageSyncCursorTypeEnum>()();

  IntColumn get timestampUsec => integer()();
}
