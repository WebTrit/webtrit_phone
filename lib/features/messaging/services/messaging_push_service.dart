// ignore_for_file: unused_element
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('MessagingNotificationsService');

class MessagingPushService {
  MessagingPushService(
    this.userId,
    this.chatsRepository,
    this.smsRepository,
    this.contactsRepository,
    this.remotePushRepository,
    this.localPushRepository,
    this.activeMessagePushsRepository,
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
  final RemotePushRepository remotePushRepository;
  final LocalPushRepository localPushRepository;
  final ActiveMessagePushsRepository activeMessagePushsRepository;
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
    _subs.add(localPushRepository.messagingActions.listen(_localActionHandler));
    _subs.add(remotePushRepository.messagingOpenedPushs.listen(_handleOpenedPush));
    _subs.add(remotePushRepository.messagingForegroundPushs.listen(_handleForegroundPush));
  }

  Future<void> _handleMessagingChatsEvents(ChatsEvent e) async {
    final notifications = await activeMessagePushsRepository.getAllByConversation(e.chatId);

    // Dismiss notifications if message was deleted
    if (e is ChatMessageUpdate && e.message.deletedAt != null) {
      final notification = notifications.firstWhereOrNull((n) => n.messageId == e.message.id);
      if (notification != null) {
        await activeMessagePushsRepository.deleteByMessage(e.message.id);
        await _dismissByContent(notification.title, notification.body);
      }
    }

    // Dismiss all notifications if chat was removed
    if (e is ChatRemove) {
      await activeMessagePushsRepository.deleteByConversation(e.chatId);
      for (final notification in notifications) {
        await _dismissByContent(notification.title, notification.body);
      }
    }

    // Dismiss notifications if user readed all messages in given chat
    // independant of from what device he did it
    if (e is ChatReadCursorUpdate && e.cursor.userId == userId) {
      await activeMessagePushsRepository.deleteByConversation(e.chatId);
      for (final notification in notifications) {
        await _dismissByContent(notification.title, notification.body);
      }
    }
  }

  Future<void> _handleMessagingSmsEvents(SmsEvent e) async {
    final notifications = await activeMessagePushsRepository.getAllByConversation(e.conversationId);

    // Dismiss notifications if message was deleted
    if (e is SmsMessageUpdate && e.message.deletedAt != null) {
      final notification = notifications.firstWhereOrNull((n) => n.messageId == e.message.id);
      if (notification != null) {
        await activeMessagePushsRepository.deleteByMessage(e.message.id);
        await _dismissByContent(notification.title, notification.body);
      }
    }

    // Dismiss all notifications if conversation was removed
    if (e is SmsConversationRemove) {
      await activeMessagePushsRepository.deleteByConversation(e.conversationId);
      for (final notification in notifications) {
        await _dismissByContent(notification.title, notification.body);
      }
    }

    // Dismiss notifications if user readed all messages in given conversation
    // independant of from what device he did it
    if (e is SmsReadCursorUpdate && e.cursor.userId == userId) {
      await activeMessagePushsRepository.deleteByConversation(e.conversationId);
      for (final notification in notifications) {
        await _dismissByContent(notification.title, notification.body);
      }
    }
  }

  Future<void> _localActionHandler(AppLocalPushAction action) async {
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

  Future<void> _handleForegroundPush(AppRemotePush notification) async {
    _logger.info('onMessageReceivedMethod');
    try {
      if (notification.title == null || notification.body == null) return;

      if (notification is ChatsMessagePush) {
        final chat = await _tryGetChat(notification.conversationId);
        if (chat != null && _shouldSkipChatPush(chat)) return;

        final localPush = AppLocalPush(
          notification.messageId,
          notification.title!,
          notification.body!,
          payload: {
            'source': kLocalPushSourceSystemNotification,
            'chatId': notification.conversationId.toString(),
          },
        );
        localPushRepository.displayPush(localPush);

        final activeMessagePush = ActiveMessagePush(
          notificationId: notification.id,
          messageId: notification.messageId,
          conversationId: notification.conversationId,
          title: notification.title!,
          body: notification.body!,
          time: DateTime.now(),
        );
        activeMessagePushsRepository.set(activeMessagePush);
      }

      if (notification is SmsMessagePush) {
        final conversation = await _tryGetSmsConversation(notification.conversationId);
        if (conversation != null && _shouldSkipSmsPush(conversation)) return;

        final localPush = AppLocalPush(
          notification.messageId,
          notification.title!,
          notification.body!,
          payload: {
            'source': kLocalPushSourceSystemNotification,
            'smsConversationId': notification.conversationId.toString(),
          },
        );
        localPushRepository.displayPush(localPush);

        final activeMessagePush = ActiveMessagePush(
          notificationId: notification.id,
          messageId: notification.messageId,
          conversationId: notification.conversationId,
          title: notification.title!,
          body: notification.body!,
          time: DateTime.now(),
        );

        activeMessagePushsRepository.set(activeMessagePush);
      }
    } on Exception catch (e) {
      _logger.severe('Error handling foreground remote message: $e');
    }
  }

  Future<void> _handleOpenedPush(AppRemotePush notification) async {
    _logger.info('onMessageReceivedMethod');
    try {
      if (notification is ChatsMessagePush) await _routeToChat(notification.conversationId);
      if (notification is SmsMessagePush) await _routeToSmsConversation(notification.conversationId);
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

    if (chat.type == ChatType.direct) {
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

  bool _shouldSkipChatPush(Chat chat) {
    final chatType = chat.type;
    final chatId = chat.id;
    _logger.info('_shouldSkipChatPush chat: $chatId type: $chatType');

    String? participantId;
    if (chatType == ChatType.direct) {
      participantId = chat.members.firstWhere((m) => m.userId != userId).userId;
    }

    final chatScreenActive = mainShellRouteStateRepository.isChatConversationScreenActive(chatId, participantId);
    _logger.info('chatScreenActive: $chatScreenActive');
    if (chatScreenActive) return true;

    return false;
  }

  bool _shouldSkipSmsPush(SmsConversation conversation) {
    final firstNumber = conversation.firstPhoneNumber;
    final secondNumber = conversation.secondPhoneNumber;
    _logger.info('_shouldSkipSmsPush firstNumber: $firstNumber second: $secondNumber');

    final smsConversationScreenActive =
        mainShellRouteStateRepository.isSmsConversationScreenActive(firstNumber, secondNumber);
    _logger.info('smsConversationScreen: $smsConversationScreenActive');
    if (smsConversationScreenActive) return true;

    return false;
  }

  Future _dismissById(int messageId) async {
    await localPushRepository.dissmissById(messageId);
  }

  Future _dismissByContent(String title, String body) async {
    await localPushRepository.dismissByContent(title, body);
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
