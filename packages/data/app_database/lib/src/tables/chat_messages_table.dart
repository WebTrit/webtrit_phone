import 'package:app_database/src/tables/chats_table.dart';
import 'package:drift/drift.dart';

@DataClassName('ChatMessageData')
class ChatMessagesTable extends Table {
  @override
  String get tableName => 'chat_messages';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get idKey => text()();

  TextColumn get senderId => text()();

  IntColumn get chatId =>
      integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get replyToId => integer().nullable()();

  IntColumn get forwardFromId => integer().nullable()();

  TextColumn get authorId => text().nullable()();

  TextColumn get content => text()();

  IntColumn get createdAtRemoteUsec => integer()();

  IntColumn get updatedAtRemoteUsec => integer()();

  IntColumn get editedAtRemoteUsec => integer().nullable()();

  IntColumn get deletedAtRemoteUsec => integer().nullable()();
}
