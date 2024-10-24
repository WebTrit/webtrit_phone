import 'package:drift/drift.dart';

@DataClassName('SmsConversationData')
class SmsConversationsTable extends Table {
  @override
  String get tableName => 'sms_conversations';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get firstPhoneNumber => text()();

  TextColumn get secondPhoneNumber => text()();

  DateTimeColumn get createdAtRemote => dateTime()();

  DateTimeColumn get updatedAtRemote => dateTime()();
}
