// ignore_for_file: unused_element
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('ChatNotificationsService');

class ChatNotificationsService {
  ChatNotificationsService(
    this.chatsRepository,
    this.contactsRepository,
    this.mainScreenRouteStateRepository, {
    required this.openChatList,
    required this.openChat,
    required this.openConversation,
    this.handleLocal = false,
    this.handleRemote = true,
  });

  late final String userId;
  final ChatsRepository chatsRepository;
  final ContactsRepository contactsRepository;
  final MainScreenRouteStateRepository mainScreenRouteStateRepository;

  /// Whether to handle foreground chat events from internal datasource and display it notifications from the app
  final bool handleLocal;

  /// Whether to handle foreground push notifications from fcm/apns and display it as notifications from the app
  final bool handleRemote;

  final Function openChatList;
  final Function(int chatId) openChat;
  final Function(String participantId) openConversation;

  final List<StreamSubscription> _subs = [];

  void init(String userId) async {
    _logger.info('Initialising...');
    this.userId = userId;
    _subs.add(chatsRepository.eventBus.listen(_handleLocalEvent));
    _subs.add(LocalNotificationsBroker.chatActionsStream.listen(_notificationActionHandler));
    _subs.add(RemoteNotificationsBroker.chatForegroundMessagesStream.listen(_handleForegroundRemoteMessage));
    _subs.add(RemoteNotificationsBroker.chatOpenedMessagesStream.listen(_handleOpenedRemoteMessage));
  }

  Future<void> _handleLocalEvent(ChatsEvent e) async {
    if (e is ChatMessageUpdate) {
      _logger.info('ChatMessageReceived: ${e.message}');
      final message = e.message;
      if (message.senderId == userId) return;

      if (message.viewedAt != null || message.deletedAt != null) {
        _logger.info('Dismiss notification for message ${message.id}');
        _dismissNotification(message.id);
        return;
      } else {
        _displayNotificationFromEvent(message.chatId, message.senderId, message.id, message.content);
        _logger.info('Notification created for message ${message.id}');
      }
    }
  }

  Future<void> _notificationActionHandler(ReceivedAction action) async {
    _logger.info('onActionReceivedMethod');
    try {
      final payload = action.payload;
      final chatId = int.tryParse(payload?['chatId'] ?? '');
      if (chatId == null) return;

      await _routeToChat(chatId);
    } on Exception catch (e) {
      _logger.severe('Error handling notification action: $e');
    }
  }

  Future<void> _handleForegroundRemoteMessage(RemoteMessage message) async {
    _logger.info('onMessageReceivedMethod');
    try {
      final chatId = int.tryParse(message.data['chat_id'] ?? '');
      final messageId = int.tryParse(message.data['message_id'] ?? '');
      final senderId = message.data['sender_id'];
      if (chatId == null || messageId == null || senderId == null) return;

      final title = message.notification?.title;
      final body = message.notification?.body;
      if (title == null || body == null) return;

      _displayNotificationFromRemote(messageId, chatId, senderId, title, body);
    } on Exception catch (e) {
      _logger.severe('Error handling foreground remote message: $e');
    }
  }

  Future<void> _handleOpenedRemoteMessage(RemoteMessage message) async {
    _logger.info('onMessageReceivedMethod');
    try {
      final chatId = int.tryParse(message.data['chat_id'] ?? '');
      if (chatId == null) return;

      await _routeToChat(chatId);
    } on Exception catch (e) {
      _logger.severe('Error handling foreground remote message: $e');
    }
  }

  Future<void> _routeToChat(int chatId) async {
    final chat = await tryGetChat(chatId);

    if (chat == null) return openChatList();

    if (chat.type == ChatType.dialog) {
      final participant = chat.members.firstWhere((m) => m.userId != userId);
      return openConversation(participant.userId);
    }

    return openChat(chatId);
  }

  Future _displayNotificationFromEvent(int chatId, String senderId, int messageId, String content) async {
    if (!handleLocal) return;
    try {
      final chat = await tryGetChat(chatId);
      if (chat == null) return;
      final contact = await contactsRepository.getContactBySource(ContactSourceType.external, senderId);

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: messageId,
          channelKey: 'chats_channel',
          actionType: ActionType.Default,
          title: chat.type == ChatType.dialog ? contact?.name ?? senderId : chat.name,
          body: chat.type == ChatType.dialog ? content : '${contact?.name ?? senderId}: $content',
          displayOnForeground: _shouldSkipNotification(chatId, senderId) == false,
          displayOnBackground: false,
          payload: {'chatId': chatId.toString()},
        ),
      );
    } catch (e) {
      _logger.severe('Error getting chat for message $messageId: $e');
    }
  }

  Future _displayNotificationFromRemote(int messageId, int chatId, String senderId, String title, String body) async {
    if (!handleRemote) return;
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: messageId,
        channelKey: 'chats_channel',
        actionType: ActionType.Default,
        title: title,
        body: body,
        displayOnForeground: _shouldSkipNotification(chatId, senderId) == false,
        displayOnBackground: false,
        payload: {'chatId': chatId.toString()},
      ),
    );
  }

  Future _dismissNotification(int messageId) async {
    AwesomeNotifications().dismiss(messageId);
  }

  bool _shouldSkipNotification(int chatId, String participantId) {
    final routeArgs = mainScreenRouteStateRepository.lastRouteArgs;

    if (routeArgs is GroupScreenPageRouteArgs && routeArgs.chatId == chatId) {
      return true;
    }
    if (routeArgs is ConversationScreenPageRouteArgs && routeArgs.participantId == participantId) {
      return true;
    }
    return false;
  }

  Future<Chat?> tryGetChat(int chatId) async {
    try {
      return await chatsRepository.getChat(chatId);
    } catch (e) {
      _logger.severe('Error getting chat for message $chatId: $e');
    }
    return null;
  }

  Future<void> dispose() async {
    _logger.info('Disposing...');
    for (var sub in _subs) {
      await sub.cancel();
    }
  }
}



  // TODO: 
  //  - decouple from approuter
  //  - decouple from AwesomeNotifications
  //  - decouple from FirebaseMessaging