import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/push_notification/push_notifications.dart';

abstract class RemoteNotificationRepository {
  /// Stream of chat notifications that were tapped and opened the app from a background or terminated state
  Stream<RemoteNotificationDTO> get chatOpenNotificationsStream;

  /// Stream of chat notifications that were received while the app was in the foreground
  Stream<RemoteNotificationDTO> get chatNotificationsStream;
}

class RemoteNotificationRepositoryFirebaseImpl implements RemoteNotificationRepository {
  @override
  Stream<RemoteNotificationDTO> get chatOpenNotificationsStream {
    return FirebaseNotificationsBroker.chatOpenedMessagesStream.map((message) {
      return RemoteNotificationDTO(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        data: message.data,
      );
    });
  }

  @override
  Stream<RemoteNotificationDTO> get chatNotificationsStream {
    return FirebaseNotificationsBroker.chatForegroundMessagesStream.map((message) {
      return RemoteNotificationDTO(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        data: message.data,
      );
    });
  }
}

class RemoteNotificationDTO with EquatableMixin {
  final String title;
  final String body;
  final Map<String, dynamic> data;

  RemoteNotificationDTO({required this.title, required this.body, required this.data});

  @override
  List<Object> get props => [title, body, data];

  @override
  bool get stringify => true;
}
