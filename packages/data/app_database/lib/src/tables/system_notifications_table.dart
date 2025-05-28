import 'package:drift/drift.dart';

@DataClassName('SystemNotificationData')
class SystemNotificationsTable extends Table {
  @override
  String get tableName => 'system_notifications';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get title => text()();

  TextColumn get content => text()();

  BoolColumn get seen => boolean()();

  IntColumn get createdAtRemoteUsec => integer()();

  IntColumn get updatedAtRemoteUsec => integer()();
}
