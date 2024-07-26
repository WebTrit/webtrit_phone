import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('ChatNotificationsService');

class ChatNotificationsService extends AutoRouterObserver {
  ChatNotificationsService(
    this.userId,
    this.chatsRepository,
    this.contactsRepository,
  ) {
    _init();
  }

  final String userId;
  final ChatsRepository chatsRepository;
  final ContactsRepository contactsRepository;
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
    _eventsSub = chatsRepository.eventBus.listen(_handleEvent);
    AwesomeNotifications().setListeners(onActionReceivedMethod: _notificationActionHandler);
  }

  Future<void> _handleEvent(ChatsEvent e) async {
    if (e is ChatMessageUpdate) {
      _logger.info('ChatMessageReceived: ${e.message}');
      final message = e.message;
      if (message.senderId == userId) return;

      if (message.viewedAt != null) {
        _logger.info('Dismiss notification for viewed message ${message.id}');
        AwesomeNotifications().dismiss(message.id);
        return;
      }
      if (message.deletedAt != null) {
        _logger.info('Dismiss notification for deleted message ${message.id}');
        AwesomeNotifications().dismiss(message.id);
        return;
      }

      bool shouldDisplayOnForeground = true;
      // Do not display notification if the chat is opened
      if (message.chatId == _groupIdOpened) {
        _logger.info('Skip notification for opened group ${message.chatId}');
        shouldDisplayOnForeground = false;
      } else if (message.senderId == _dialogWithUserIdOpened) {
        _logger.info('Skip notification for opened dialog with ${message.senderId}');
        shouldDisplayOnForeground = false;
      }
      try {
        final chat = await chatsRepository.getChat(message.chatId);
        final contact = await contactsRepository.getContactBySource(ContactSourceType.external, message.senderId);

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: message.id,
            channelKey: 'chats_channel',
            actionType: ActionType.Default,
            title: chat.type == ChatType.dialog ? contact?.name ?? message.senderId : chat.name,
            body: chat.type == ChatType.dialog
                ? message.content
                : '${contact?.name ?? message.senderId}: ${message.content}',
            displayOnForeground: shouldDisplayOnForeground,
            payload: {'chatId': message.chatId.toString()},
          ),
        );
      } catch (e) {
        _logger.severe('Error getting chat for message ${message.id}: $e');
      }

      _logger.info('Notification created for message ${message.id}');
    }
  }

  /// TODO; make static
  Future<void> _notificationActionHandler(ReceivedAction action) async {
    _logger.info('onActionReceivedMethod');
    try {
      final payload = action.payload;
      if (payload == null) return;
      final chatId = int.tryParse(payload['chatId'] ?? '');
      if (chatId == null) return;
      final chat = await chatsRepository.getChat(chatId);
      if (chat.type == ChatType.dialog) {
        final participant = chat.members.firstWhere((m) => m.userId != userId);
        navigator?.context.router.root.navigate(ChatsRouterPageRoute(children: [
          const ChatListScreenPageRoute(),
          ConversationScreenPageRoute(participantId: participant.userId),
        ]));
      } else {
        navigator?.context.router.root.navigate(ChatsRouterPageRoute(children: [
          const ChatListScreenPageRoute(),
          GroupScreenPageRoute(chatId: chat.id),
        ]));
      }
    } on Exception catch (e) {
      _logger.severe('Error handling notification action: $e');
    }
  }

  void dispose() {
    _logger.info('Disposing...');
    _eventsSub?.cancel();
  }
}
