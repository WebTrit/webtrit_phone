// ignore_for_file: unused_element
import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('MessagingNotificationsService');

class MessagingNotificationsService {
  MessagingNotificationsService(
    this.userId,
    this.chatsRepository,
    this.smsRepository,
    this.contactsRepository,
    this.remoteNotificationRepository,
    this.localNotificationRepository,
    this.activeMessageNotificationsRepository,
    this.mainScreenRouteStateRepository,
    this.mainShellRouteStateRepository,
    this.openChatList,
    this.openChat,
    this.openConversation,
    this.openSmsConversation,
  );

  final String userId;
  final ChatsRepository chatsRepository;
  final SmsRepository smsRepository;
  final ContactsRepository contactsRepository;
  final RemoteNotificationRepository remoteNotificationRepository;
  final LocalNotificationRepository localNotificationRepository;
  final ActiveMessageNotificationsRepository activeMessageNotificationsRepository;
  final MainScreenRouteStateRepository mainScreenRouteStateRepository;
  final MainShellRouteStateRepository mainShellRouteStateRepository;

  final Function openChatList;
  final Function(int chatId) openChat;
  final Function(String participantId) openConversation;
  final Function(String firstNumber, String secondNumber) openSmsConversation;

  final List<StreamSubscription> _subs = [];

  void init() async {
    _logger.info('Initialising...');
    _subs.add(chatsRepository.eventBus.listen(_handleMessagingChatsEvents));
    _subs.add(smsRepository.eventBus.listen(_handleMessagingSmsEvents));
    _subs.add(localNotificationRepository.messagingActions.listen(_localActionHandler));
    _subs.add(remoteNotificationRepository.messagingOpenedNotifications.listen(_handleOpenedNotification));
    _subs.add(remoteNotificationRepository.messagingForegroundNotifications.listen(_handleForegroundNotification));
  }

  Future<void> _handleMessagingChatsEvents(ChatsEvent e) async {
    final notifications = await activeMessageNotificationsRepository.getAllByConversation(e.chatId);
    _logger.info('Active push notifications: $notifications');

    // Dismiss notifications if message was deleted
    if (e is ChatMessageUpdate && e.message.deletedAt != null) {
      for (final notification in notifications) {
        if (notification.messageId == e.message.id) {
          await _dismissByContent(notification.title, notification.body);
        }
        await activeMessageNotificationsRepository.deleteByMessage(e.message.id);
      }
    }

    // Dismiss notifications if chat was removed
    if (e is ChatRemove) {
      for (final notification in notifications) {
        if (notification.conversationId == e.chatId) {
          await _dismissByContent(notification.title, notification.body);
        }
        await activeMessageNotificationsRepository.deleteByConversation(e.chatId);
      }
    }

    // Dismiss notifications if user readed messages from given chat
    // independant of from what device he did it
    if (e is ChatReadCursorUpdate && e.cursor.userId == userId) {
      for (final notification in notifications) {
        await _dismissByContent(notification.title, notification.body);
        await activeMessageNotificationsRepository.deleteByNotification(notification.notificationId);
      }
    }
  }

  Future<void> _handleMessagingSmsEvents(SmsEvent e) async {
    final notifications = await activeMessageNotificationsRepository.getAllByConversation(e.conversationId);
    _logger.info('Active push notifications: $notifications');

    // Dismiss notifications if message was deleted
    if (e is SmsMessageUpdate && e.message.deletedAt != null) {
      for (final notification in notifications) {
        if (notification.messageId == e.message.id) {
          await _dismissByContent(notification.title, notification.body);
        }
        await activeMessageNotificationsRepository.deleteByMessage(e.message.id);
      }
    }

    // Dismiss notifications if chat was removed
    if (e is SmsConversationRemove) {
      for (final notification in notifications) {
        if (notification.conversationId == e.conversationId) {
          await _dismissByContent(notification.title, notification.body);
        }
        await activeMessageNotificationsRepository.deleteByConversation(e.conversationId);
      }
    }

    // Dismiss notifications if user readed messages from given chat
    // independant of from what device he did it
    if (e is SmsReadCursorUpdate && e.cursor.userId == userId) {
      for (final notification in notifications) {
        await _dismissByContent(notification.title, notification.body);
        await activeMessageNotificationsRepository.deleteByNotification(notification.notificationId);
      }
    }
  }

  Future<void> _localActionHandler(AppLocalNotificationAction action) async {
    _logger.info('onActionReceivedMethod');
    try {
      final chatId = int.tryParse(action.payload['chatId'] ?? '');
      if (chatId != null) await _routeToChat(chatId);

      final conversationId = int.tryParse(action.payload['smsConversationId'] ?? '');
      if (conversationId != null) await _routeToSmsConversation(conversationId);

      _logger.info('Action handle result: chatId - $chatId, conversationId- $conversationId');
    } on Exception catch (e) {
      _logger.severe('Error handling notification action: $e');
    }
  }

  Future<void> _handleForegroundNotification(AppRemoteNotification notification) async {
    _logger.info('onMessageReceivedMethod');
    try {
      if (notification.title == null || notification.body == null) return;

      if (notification is ChatsMessageNotification) {
        final chat = await _tryGetChat(notification.conversationId);
        if (chat != null && _shouldSkipChatNotification(chat)) return;

        final localNotification = AppLocalNotification(
          notification.messageId,
          notification.title!,
          notification.body!,
          payload: {'chatId': notification.conversationId.toString()},
        );
        localNotificationRepository.displayNotification(localNotification);

        final activeMessageNotification = ActiveMessageNotification(
          notificationId: notification.id,
          messageId: notification.messageId,
          conversationId: notification.conversationId,
          title: notification.title!,
          body: notification.body!,
          time: DateTime.now(),
        );
        activeMessageNotificationsRepository.set(activeMessageNotification);
      }

      if (notification is SmsMessageNotification) {
        final conversation = await _tryGetSmsConversation(notification.conversationId);
        if (conversation != null && _shouldSkipSmsNotification(conversation)) return;

        final localNotification = AppLocalNotification(
          notification.messageId,
          notification.title!,
          notification.body!,
          payload: {'smsConversationId': notification.conversationId.toString()},
        );
        localNotificationRepository.displayNotification(localNotification);

        final activeMessageNotification = ActiveMessageNotification(
          notificationId: notification.id,
          messageId: notification.messageId,
          conversationId: notification.conversationId,
          title: notification.title!,
          body: notification.body!,
          time: DateTime.now(),
        );

        activeMessageNotificationsRepository.set(activeMessageNotification);
      }
    } on Exception catch (e) {
      _logger.severe('Error handling foreground remote message: $e');
    }
  }

  Future<void> _handleOpenedNotification(AppRemoteNotification notification) async {
    _logger.info('onMessageReceivedMethod');
    try {
      if (notification is ChatsMessageNotification) await _routeToChat(notification.conversationId);
      if (notification is SmsMessageNotification) await _routeToSmsConversation(notification.conversationId);
    } on Exception catch (e) {
      _logger.severe('Error handling foreground remote message: $e');
    }
  }

  Future<void> _routeToChat(int chatId) async {
    final chat = await _tryGetChat(chatId);
    _logger.info('Found chat: $chat');

    if (chat == null) return openChatList();

    if (chat.type == ChatType.group) {
      _logger.info('Opening chat $chatId');
      return openChat(chatId);
    }

    if (chat.type == ChatType.dialog) {
      final participant = chat.members.firstWhere((m) => m.userId != userId);
      _logger.info('Opening conversation with $participant');
      return openConversation(participant.userId);
    }
  }

  Future<void> _routeToSmsConversation(int conversationId) async {
    final conversation = await _tryGetSmsConversation(conversationId);
    _logger.info('Found sms conversation: $conversation');

    if (conversation == null) return openChatList();
    final firstNumber = conversation.firstPhoneNumber;
    final secondNumber = conversation.secondPhoneNumber;

    _logger.info('Opening sms conversation with $firstNumber and $secondNumber');
    openSmsConversation(firstNumber, secondNumber);
  }

  bool _shouldSkipChatNotification(Chat chat) {
    final chatType = chat.type;
    final chatId = chat.id;
    _logger.info('_shouldSkipChatNotification chat: $chatId type: $chatType');

    if (chatType == ChatType.group) {
      final groupScreenActive = mainShellRouteStateRepository.isGroupScreenActive(chat.id);
      _logger.info('groupScreenActive: $groupScreenActive');
      if (groupScreenActive) return true;
    }

    if (chatType == ChatType.dialog) {
      final participantId = chat.members.firstWhere((m) => m.userId != userId).userId;
      final conversationScreenActive = mainShellRouteStateRepository.isConversationScreenActive(participantId);
      _logger.info('conversationScreenActive: $conversationScreenActive');
      if (conversationScreenActive) return true;
    }

    return false;
  }

  bool _shouldSkipSmsNotification(SmsConversation conversation) {
    final firstNumber = conversation.firstPhoneNumber;
    final secondNumber = conversation.secondPhoneNumber;
    _logger.info('_shouldSkipSmsNotification firstNumber: $firstNumber second: $secondNumber');

    final smsConversationScreenActive =
        mainShellRouteStateRepository.isSmsConversationScreenActive(firstNumber, secondNumber);
    _logger.info('smsConversationScreen: $smsConversationScreenActive');
    if (smsConversationScreenActive) return true;

    return false;
  }

  Future _dismissById(int messageId) async {
    localNotificationRepository.dissmissById(messageId);
  }

  Future _dismissByContent(String title, String body) async {
    localNotificationRepository.dismissByContent(title, body);
  }

  Future<Chat?> _tryGetChat(int chatId) async {
    try {
      return await chatsRepository.getChat(chatId);
    } catch (e) {
      _logger.severe('Error getting chat for message $chatId: $e');
    }
    return null;
  }

  Future<SmsConversation?> _tryGetSmsConversation(int conversationId) async {
    try {
      return await smsRepository.getConversation(conversationId);
    } catch (e) {
      _logger.severe('Error getting sms conversation $conversationId');
    }
    return null;
  }

  Future<void> dispose() async {
    _logger.info('Disposing...');
    // ignore: avoid_function_literals_in_foreach_calls
    _subs.forEach((sub) => sub.cancel());
  }
}
