import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin ActiveMessagePushDriftMapper {
  ActiveMessagePush notificationFromDrift(ActiveMessageNotificationData data) {
    return ActiveMessagePush(
      notificationId: data.notificationId,
      messageId: data.messageId,
      conversationId: data.conversationId,
      title: data.title,
      body: data.body,
      time: data.time,
    );
  }

  ActiveMessageNotificationData notificationToDrift(ActiveMessagePush notification) {
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
