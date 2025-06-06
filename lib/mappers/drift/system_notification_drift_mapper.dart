import 'package:app_database/app_database.dart' as db;

import 'package:webtrit_phone/models/system_notification.dart';

mixin SystemNotificationDriftMapper {
  SystemNotification systemNotificationFromDrift(db.SystemNotificationData data) {
    return SystemNotification(
      id: data.id,
      title: data.title,
      content: data.content,
      seen: data.seen,
      type: SystemNotificationType.values.byName(data.type.name),
      createdAt: DateTime.fromMicrosecondsSinceEpoch(data.createdAtRemoteUsec),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(data.updatedAtRemoteUsec),
    );
  }

  db.SystemNotificationData systemNotificationToDrift(SystemNotification notification) {
    return db.SystemNotificationData(
      id: notification.id,
      title: notification.title,
      content: notification.content,
      seen: notification.seen,
      type: db.SystemNotificationType.values.byName(notification.type.name),
      createdAtRemoteUsec: notification.createdAt.microsecondsSinceEpoch,
      updatedAtRemoteUsec: notification.updatedAt.microsecondsSinceEpoch,
    );
  }
}
