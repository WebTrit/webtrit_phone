import 'package:drift/drift.dart';

enum ChatTypeEnum { direct, group }

@DataClassName('ChatData')
class ChatsTable extends Table {
  @override
  String get tableName => 'chats';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get type => textEnum<ChatTypeEnum>()();

  TextColumn get name => text().nullable()();

  DateTimeColumn get createdAtRemote => dateTime()();

  DateTimeColumn get updatedAtRemote => dateTime()();
}
