import 'package:drift/drift.dart';

@DataClassName('ActiveMessageNotificationData')
class ActiveMessageNotificationsTable extends Table {
  @override
  String get tableName => 'active_messaging_notifications';

  @override
  Set<Column> get primaryKey => {notificationId};

  TextColumn get notificationId => text()();

  IntColumn get messageId => integer()();

  IntColumn get conversationId => integer()();

  TextColumn get title => text()();

  TextColumn get body => text()();

  DateTimeColumn get time => dateTime()();
}
