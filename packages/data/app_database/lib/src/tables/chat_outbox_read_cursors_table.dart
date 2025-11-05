import 'package:app_database/src/tables/chats_table.dart';
import 'package:drift/drift.dart';

@DataClassName('ChatOutboxReadCursorData')
class ChatOutboxReadCursorsTable extends Table {
  @override
  String get tableName => 'chat_outbox_read_cursors';

  @override
  Set<Column> get primaryKey => {chatId};

  IntColumn get chatId =>
      integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get timestampUsec => integer()();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();
}
