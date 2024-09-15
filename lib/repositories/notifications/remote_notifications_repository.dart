import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/push_notification/push_notifications.dart';

abstract class RemoteNotificationRepository {
  /// Stream of messaging notifications that were tapped and opened the app from a background or terminated state
  Stream<RemoteNotificationDTO> get messagingOpenedNotifications;

  /// Stream of messaging notifications that were received while the app was in the foreground
  Stream<RemoteNotificationDTO> get messagingForegroundNotifications;
}

class RemoteNotificationRepositoryFirebaseImpl implements RemoteNotificationRepository {
  @override
  Stream<RemoteNotificationDTO> get messagingOpenedNotifications {
    return FirebaseNotificationsBroker.messagingOpenedNotifications.map((n) {
      return RemoteNotificationDTO(title: n.notification?.title, body: n.notification?.body, data: n.data);
    });
  }

  @override
  Stream<RemoteNotificationDTO> get messagingForegroundNotifications {
    return FirebaseNotificationsBroker.messagingForegroundNotifications.map((n) {
      return RemoteNotificationDTO(title: n.notification?.title, body: n.notification?.body, data: n.data);
    });
  }
}

class RemoteNotificationDTO with EquatableMixin {
  final String? title;
  final String? body;
  final Map<String, dynamic> data;

  RemoteNotificationDTO({this.title, this.body, required this.data});

  @override
  List<Object> get props => [title ?? 0, body ?? 0, data];

  @override
  bool get stringify => true;
}
