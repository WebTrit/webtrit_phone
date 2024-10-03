import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

// TODO: handle sms events
// TODO: add notifications tracking system for manage background notifications
// TODO: handle read cursor above displayed notifications and dismiss them

final _logger = Logger('MessagingNotificationsService');

class MessagingNotificationsService {
  MessagingNotificationsService(
    this.chatsRepository,
    this.smsRepository,
    this.contactsRepository,
    this.remoteNotificationRepository,
    this.localNotificationRepository,
    this.mainScreenRouteStateRepository,
    this.mainShellRouteStateRepository, {
    required this.openChatList,
    required this.openChat,
    required this.openConversation,
    required this.openSmsConversation,
  });

  final ChatsRepository chatsRepository;
  final SmsRepository smsRepository;
  final ContactsRepository contactsRepository;
  final RemoteNotificationRepository remoteNotificationRepository;
  final LocalNotificationRepository localNotificationRepository;
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
    _subs.add(localNotificationRepository.messagingActions.listen(_localActionHandler));
    _subs.add(remoteNotificationRepository.messagingOpenedNotifications.listen(_handleOpenedNotification));
    _subs.add(remoteNotificationRepository.messagingForegroundNotifications.listen(_handleForegroundNotification));
  }

  Future<void> _handleMessagingChatsEvents(ChatsEvent e) async {
    if (e is ChatMessageUpdate) {
      final message = e.message;
      if (_userId == null) return;
      if (message.senderId == _userId) return;

      if (message.deletedAt != null) {
        _dismissNotification(message.id);
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

      if (notification is ChatsNotification) {
        final chat = await _tryGetChat(notification.chatId);
        if (chat != null && _shouldSkipChatNotification(chat)) return;

        final localNotification = AppLocalNotification(
          notification.messageId,
          notification.title!,
          notification.body!,
          payload: {'chatId': notification.chatId.toString()},
        );
        localNotificationRepository.displayNotification(localNotification);
      }

      if (notification is SmsNotification) {
        final conversation = await _tryGetSmsConversation(notification.conversationId);
        if (conversation != null && _shouldSkipSmsNotification(conversation)) return;

        final localNotification = AppLocalNotification(
          notification.messageId,
          notification.title!,
          notification.body!,
          payload: {'smsConversationId': notification.conversationId.toString()},
        );
        localNotificationRepository.displayNotification(localNotification);
      }
    } on Exception catch (e) {
      _logger.severe('Error handling foreground remote message: $e');
    }
  }

  Future<void> _handleOpenedNotification(AppRemoteNotification notification) async {
    _logger.info('onMessageReceivedMethod');
    try {
      if (notification is ChatsNotification) await _routeToChat(notification.chatId);
      if (notification is SmsNotification) await _routeToSmsConversation(notification.conversationId);
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
      if (_userId == null) return openChatList();
      final participant = chat.members.firstWhere((m) => m.userId != _userId);
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
      final participantId = chat.members.firstWhere((m) => m.userId != _userId).userId;
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

  Future _dismissNotification(int messageId) async {
    localNotificationRepository.dissmissNotification(messageId);
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

  String? get _userId => AppPreferences().getChatUserId();

  Future<void> dispose() async {
    _logger.info('Disposing...');
    // ignore: avoid_function_literals_in_foreach_calls
    _subs.forEach((sub) => sub.cancel());
  }
}
