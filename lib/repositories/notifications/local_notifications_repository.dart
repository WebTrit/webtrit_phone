import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:webtrit_phone/push_notification/push_notifications.dart';

abstract class LocalNotificationRepository {
  /// Stream of chat notifications actions that were tapped or dismissed
  Stream<LocalNotificationActionDTO> get chatActionsStream;
  Future<void> pushChatMessageNotification(int id, String title, String body, Map<String, String> payload);
  Future<void> dissmissNotification(int id);
}

class LocalNotificationRepositoryFLNImpl implements LocalNotificationRepository {
  @override
  Stream<LocalNotificationActionDTO> get chatActionsStream {
    return LocalNotificationsBroker.chatActionsStream.map((action) {
      final payload = action.payload;
      return LocalNotificationActionDTO(
        id: action.id ?? -1,
        payload: payload != null ? json.decode(payload) : {},
        type: LocalNotificationActionType.tap,
      );
    });
  }

  @override
  Future<void> pushChatMessageNotification(int id, String title, String body, Map<String, String> payload) async {
    FlutterLocalNotificationsPlugin().show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'chats_channel',
          'chats channel',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.active,
        ),
      ),
      payload: const JsonEncoder().convert(payload),
    );
  }

  @override
  Future<void> dissmissNotification(int id) async {
    FlutterLocalNotificationsPlugin().cancel(id);
  }
}

enum LocalNotificationActionType { tap, dismiss, other }

class LocalNotificationActionDTO with EquatableMixin {
  final int id;
  final LocalNotificationActionType type;
  final Map<String, dynamic> payload;

  LocalNotificationActionDTO({
    required this.id,
    required this.type,
    required this.payload,
  });

  @override
  List<Object> get props => [id, type, payload];

  @override
  bool get stringify => true;
}
