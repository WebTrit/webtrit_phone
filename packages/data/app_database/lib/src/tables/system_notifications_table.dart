import 'package:drift/drift.dart';

enum SystemNotificationType { announcement, promotion, security, system }

@DataClassName('SystemNotificationData')
class SystemNotificationsTable extends Table {
  @override
  String get tableName => 'system_notifications';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get title => text()();

  TextColumn get content => text()();

  TextColumn get type => textEnum<SystemNotificationType>()();

  BoolColumn get seen => boolean()();

  IntColumn get createdAtRemoteUsec => integer()();

  IntColumn get updatedAtRemoteUsec => integer()();
}
