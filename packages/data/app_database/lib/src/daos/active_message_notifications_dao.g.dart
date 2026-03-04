// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_message_notifications_dao.dart';

// ignore_for_file: type=lint
mixin _$ActiveMessageNotificationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ActiveMessageNotificationsTableTable get activeMessageNotificationsTable =>
      attachedDatabase.activeMessageNotificationsTable;
  ActiveMessageNotificationsDaoManager get managers =>
      ActiveMessageNotificationsDaoManager(this);
}

class ActiveMessageNotificationsDaoManager {
  final _$ActiveMessageNotificationsDaoMixin _db;
  ActiveMessageNotificationsDaoManager(this._db);
  $$ActiveMessageNotificationsTableTableTableManager
  get activeMessageNotificationsTable =>
      $$ActiveMessageNotificationsTableTableTableManager(
        _db.attachedDatabase,
        _db.activeMessageNotificationsTable,
      );
}
