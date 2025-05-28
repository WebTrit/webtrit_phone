import 'package:app_database/app_database.dart';
import 'package:webtrit_phone/models/system_notification.dart';

mixin SystemNotificationDriftMapper {
  SystemNotification systemNotificationFromDrift(SystemNotificationData data) {
    return SystemNotification(
      id: data.id,
      title: data.title,
      content: data.content,
      seen: data.seen,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(data.createdAtRemoteUsec),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(data.updatedAtRemoteUsec),
    );
  }

  SystemNotificationData systemNotificationToDrift(SystemNotification notification) {
    return SystemNotificationData(
      id: notification.id,
      title: notification.title,
      content: notification.content,
      seen: notification.seen,
      createdAtRemoteUsec: notification.createdAt.microsecondsSinceEpoch,
      updatedAtRemoteUsec: notification.updatedAt.microsecondsSinceEpoch,
    );
  }
}
