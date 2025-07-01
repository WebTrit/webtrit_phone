import 'package:drift/drift.dart';

import 'system_notifications_table.dart';

enum SnOutboxDataActionType { seen }

enum SnOutboxDataState { pending, sent, failed }

@DataClassName('SystemNotificationOutboxEntryData')
class SystemNotificationsOutboxTable extends Table {
  @override
  String get tableName => 'system_notifications_outbox';

  @override
  Set<Column> get primaryKey => {notificationId, actionType};

  IntColumn get notificationId => integer().references(SystemNotificationsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get actionType => textEnum<SnOutboxDataActionType>()();

  TextColumn get state => textEnum<SnOutboxDataState>()();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();
}
