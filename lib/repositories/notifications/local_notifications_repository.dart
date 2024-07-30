import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/bootstrap.dart';

abstract class LocalNotificationRepository {
  /// Stream of chat notifications actions that were tapped or dismissed
  Stream<LocalNotificationActionDTO> get chatActionsStream;
  Future<void> pushChatMessageNotification(int id, String title, String body, Map<String, String> payload);
  Future<void> dissmissNotification(int id);
}

class LocalNotificationRepositoryAwesomeImpl implements LocalNotificationRepository {
  @override
  Stream<LocalNotificationActionDTO> get chatActionsStream {
    return AwesomeNotificationsBroker.chatActionsStream.map((action) {
      return LocalNotificationActionDTO(
        id: action.id ?? -1,
        payload: action.payload ?? {},
        type: () {
          switch (action.actionType) {
            case ActionType.Default:
              return LocalNotificationActionType.tap;
            case ActionType.DismissAction:
              return LocalNotificationActionType.dismiss;
            default:
              return LocalNotificationActionType.other;
          }
        }(),
      );
    });
  }

  @override
  Future<void> pushChatMessageNotification(int id, String title, String body, Map<String, String> payload) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'chats_channel',
        actionType: ActionType.Default,
        title: title,
        body: body,
        payload: payload,
      ),
    );
  }

  @override
  Future<void> dissmissNotification(int id) async {
    AwesomeNotifications().dismiss(id);
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
