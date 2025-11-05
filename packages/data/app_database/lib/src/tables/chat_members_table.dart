import 'package:app_database/src/tables/chats_table.dart';
import 'package:drift/drift.dart';

enum GroupAuthoritiesEnum { moderator, owner }

@DataClassName('ChatMemberData')
class ChatMembersTable extends Table {
  @override
  String get tableName => 'chat_members';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  IntColumn get chatId =>
      integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get userId => text()();

  TextColumn get groupAuthorities =>
      textEnum<GroupAuthoritiesEnum>().nullable()();
}
