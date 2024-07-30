// ignore_for_file: unused_element
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:logging/logging.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('ChatNotificationsService');

class ChatNotificationsService extends AutoRouterObserver {
  ChatNotificationsService(
    this.userId,
    this.chatsRepository,
    this.contactsRepository, {
    this.handleLocal = false,
    this.handleRemote = true,
  }) {
    _init();
  }

  final String userId;
  final ChatsRepository chatsRepository;
  final ContactsRepository contactsRepository;

  /// Whether to handle chat events from internal datasource and display it notifications from the app
  final bool handleLocal;

  /// Whether to handle foreground push notifications from fcm/apns and display it as notifications from the app
  final bool handleRemote;

  StreamSubscription? _eventsSub;

  // Vars used to skip notifications for chats that are opened in foreground
  int? _groupIdOpened;
  String? _dialogWithUserIdOpened;

  @override
  void didPush(Route route, Route? previousRoute) {
    final args = route.data?.route.args;
    if (args is ConversationScreenPageRouteArgs) {
      _dialogWithUserIdOpened = args.participantId;
    }
    if (args is GroupScreenPageRouteArgs) {
      _groupIdOpened = args.chatId;
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    final args = route.data?.route.args;
    if (args is ConversationScreenPageRouteArgs && args.participantId == _dialogWithUserIdOpened) {
      _dialogWithUserIdOpened = null;
    }
    if (args is GroupScreenPageRouteArgs && args.chatId == _groupIdOpened) {
      _groupIdOpened = null;
    }
    super.didPop(route, previousRoute);
  }

  void _init() async {
    _logger.info('Initialising...');
    _eventsSub = chatsRepository.eventBus.listen(_handleLocalEvent);
    LocalNotificationsBroker.chatActionsStream.listen(_notificationActionHandler);
    RemoteNotificationsBroker.chatForegroundMessagesStream.listen(_handleForegroundRemoteMessage);
    RemoteNotificationsBroker.chatOpenedMessagesStream.listen(_handleOpenedRemoteMessage);
  }

  Future<void> _handleLocalEvent(ChatsEvent e) async {
    // Skip handling local events if not needed
    if (!handleLocal) return;

    if (e is ChatMessageUpdate) {
      _logger.info('ChatMessageReceived: ${e.message}');
      final message = e.message;
      if (message.senderId == userId) return;

      if (message.viewedAt != null || message.deletedAt != null) {
        _logger.info('Dismiss local notification for message ${message.id}');
        _dismissLocalNotification(message.id);
        return;
      } else {
        _displayLocalNotification(message.chatId, message.senderId, message.id, message.content);
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
    // Skip handling remote messages if not needed
    if (!handleRemote) return;

    _logger.info('onMessageReceivedMethod');
    try {
      final chatId = int.tryParse(message.data['chat_id'] ?? '');
      final messageId = int.tryParse(message.data['message_id'] ?? '');
      final senderId = message.data['sender_id'];
      if (chatId == null || messageId == null || senderId == null) return;

      final title = message.notification?.title;
      final body = message.notification?.body;
      if (title == null || body == null) return;

      _displayRemoteNotification(messageId, chatId, senderId, title, body);
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
    if (chat == null) {
      await navigator?.context.router.root.navigate(
        const ChatsRouterPageRoute(
          children: [ChatListScreenPageRoute()],
        ),
      );
    } else {
      if (chat.type == ChatType.dialog) {
        final participant = chat.members.firstWhere((m) => m.userId != userId);
        await navigator?.context.router.root.navigate(
          ChatsRouterPageRoute(
            children: [const ChatListScreenPageRoute(), ConversationScreenPageRoute(participantId: participant.userId)],
          ),
        );
      } else {
        await navigator?.context.router.root.navigate(
          ChatsRouterPageRoute(
            children: [const ChatListScreenPageRoute(), GroupScreenPageRoute(chatId: chatId)],
          ),
        );
      }
    }
  }

  Future _displayLocalNotification(int chatId, String senderId, int messageId, String content) async {
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
          payload: {'chatId': chatId.toString()},
        ),
      );
    } catch (e) {
      _logger.severe('Error getting chat for message $messageId: $e');
    }
  }

  Future _displayRemoteNotification(int messageId, int chatId, String senderId, String title, String body) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: messageId,
        channelKey: 'chats_channel',
        actionType: ActionType.Default,
        title: title,
        body: body,
        displayOnForeground: _shouldSkipNotification(chatId, senderId) == false,
        payload: {'chatId': chatId.toString()},
      ),
    );
  }

  Future _dismissLocalNotification(int messageId) async {
    AwesomeNotifications().dismiss(messageId);
  }

  bool _shouldSkipNotification(int chatId, String participantId) {
    if (chatId == _groupIdOpened) {
      return true;
    } else if (participantId == _dialogWithUserIdOpened) {
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

  void dispose() {
    _logger.info('Disposing...');
    _eventsSub?.cancel();
  }
}
