import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin ActiveMessageNotificationDriftMapper {
  ActiveMessageNotification notificationFromDrift(ActiveMessageNotificationData data) {
    return ActiveMessageNotification(
      notificationId: data.notificationId,
      messageId: data.messageId,
      conversationId: data.conversationId,
      title: data.title,
      body: data.body,
      time: data.time,
    );
  }

  ActiveMessageNotificationData notificationToDrift(ActiveMessageNotification notification) {
    return ActiveMessageNotificationData(
      notificationId: notification.notificationId,
      messageId: notification.messageId,
      conversationId: notification.conversationId,
      title: notification.title,
      body: notification.body,
      time: notification.time,
    );
  }
}
