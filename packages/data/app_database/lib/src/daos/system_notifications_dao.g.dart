// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_notifications_dao.dart';

// ignore_for_file: type=lint
mixin _$SystemNotificationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SystemNotificationsTableTable get systemNotificationsTable =>
      attachedDatabase.systemNotificationsTable;
  $SystemNotificationsOutboxTableTable get systemNotificationsOutboxTable =>
      attachedDatabase.systemNotificationsOutboxTable;
  SystemNotificationsDaoManager get managers =>
      SystemNotificationsDaoManager(this);
}

class SystemNotificationsDaoManager {
  final _$SystemNotificationsDaoMixin _db;
  SystemNotificationsDaoManager(this._db);
  $$SystemNotificationsTableTableTableManager get systemNotificationsTable =>
      $$SystemNotificationsTableTableTableManager(
        _db.attachedDatabase,
        _db.systemNotificationsTable,
      );
  $$SystemNotificationsOutboxTableTableTableManager
  get systemNotificationsOutboxTable =>
      $$SystemNotificationsOutboxTableTableTableManager(
        _db.attachedDatabase,
        _db.systemNotificationsOutboxTable,
      );
}
