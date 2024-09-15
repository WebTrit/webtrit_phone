import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/app_preferences.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('ChatNotificationsService');

class MessagingNotificationsService {
  MessagingNotificationsService(
    this.chatsRepository,
    this.smsRepository,
    this.contactsRepository,
    this.remoteNotificationRepository,
    this.localNotificationRepository,
    this.mainScreenRouteStateRepository, {
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
    // TODO: handle read cursor above displayed notifications and dismiss them
    // TODO: handle sms messages events
  }

  Future<void> _localActionHandler(LocalNotificationActionDTO action) async {
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

  Future<void> _handleForegroundNotification(RemoteNotificationDTO message) async {
    _logger.info('onMessageReceivedMethod');
    try {
      final title = message.title;
      final body = message.body;
      final messageId = int.tryParse(message.data['msg_id'] ?? message.data['chat_message_id'] ?? '');
      if (title == null || body == null || messageId == null) return;

      // TODO: remove fallback keys
      final chatId = int.tryParse(message.data['chat_id'] ?? '');
      final senderId = message.data['sender_id'] ?? message.data['chat_message_sender_id'];
      if (chatId != null && senderId != null) {
        _displayChatNotification(messageId, chatId, senderId, title, body);
      }

      final smsConversationId = int.tryParse(message.data['sms_conversation_id'] ?? '');
      final firstNumber = message.data['first_number'];
      final secondNumber = message.data['second_number'];
      if (smsConversationId != null && firstNumber != null && secondNumber != null) {
        _displaySmsNotification(messageId, smsConversationId, firstNumber, secondNumber, title, body);
      }

      _logger.info('Foreground message handle result: chatId - $chatId, smsConversationId- $smsConversationId');
    } on Exception catch (e) {
      _logger.severe('Error handling foreground remote message: $e');
    }
  }

  Future<void> _handleOpenedNotification(RemoteNotificationDTO message) async {
    _logger.info('onMessageReceivedMethod');
    try {
      final chatId = int.tryParse(message.data['chat_id'] ?? '');
      if (chatId != null) await _routeToChat(chatId);

      final smsConversationId = int.tryParse(message.data['sms_conversation_id'] ?? '');
      if (smsConversationId != null) await _routeToSmsConversation(smsConversationId);

      _logger.info('Opened message handle result: chatId - $chatId, smsConversationId- $smsConversationId');
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

  Future _displayChatNotification(int messageId, int chatId, String senderId, String title, String body) async {
    _logger.info('_displayChatNotification $messageId, $chatId, $senderId, $title, $body');
    if (_shouldSkipChatNotification(chatId, senderId)) return;

    localNotificationRepository.pusNotification(messageId, title, body, {
      'chatId': chatId.toString(),
      'senderId': senderId,
    });
  }

  Future _displaySmsNotification(
      int messageId, int conversationId, String firstNumber, String secondNumber, String title, String body) async {
    _logger.info('_displaySmsNotification $messageId, $conversationId, $firstNumber, $secondNumber, $title, $body');
    if (_shouldSkipSmsNotification(firstNumber, secondNumber)) return;

    localNotificationRepository.pusNotification(messageId, title, body, {
      'smsConversationId': conversationId.toString(),
      'firstNumber': firstNumber,
      'secondNumber': secondNumber,
    });
  }

  bool _shouldSkipChatNotification(int chatId, String participantId) {
    _logger.info('_shouldSkipChatNotification chat: $chatId participant: $participantId');
    final messagingTabActive = mainScreenRouteStateRepository.isMessagingTabActive();
    _logger.info('messagingTabActive: $messagingTabActive');
    final chatScreenActive = mainScreenRouteStateRepository.isChatScreenActive(chatId);
    _logger.info('chatScreen: $chatScreenActive');
    final conversationScreenActive = mainScreenRouteStateRepository.isConversationScreenActive(participantId);
    _logger.info('conversationScreen: $conversationScreenActive');

    // Skip if chats tab is active and chat screen inside
    if (messagingTabActive && chatScreenActive) return true;
    // Skip if chats tab is active and conversation screen inside
    if (messagingTabActive && conversationScreenActive) return true;

    return false;
  }

  bool _shouldSkipSmsNotification(String firstNumber, String secondNumber) {
    _logger.info('_shouldSkipSmsNotification firstNumber: $firstNumber second: $secondNumber');
    final messagingTabActive = mainScreenRouteStateRepository.isMessagingTabActive();
    _logger.info('messagingTabActive: $messagingTabActive');
    final smsConversationScreenActive =
        mainScreenRouteStateRepository.isSmsConversationScreenActive(firstNumber, secondNumber);
    _logger.info('smsConversationScreen: $smsConversationScreenActive');

    // Skip if chats tab is active and sms conversation screen inside
    if (messagingTabActive && smsConversationScreenActive) return true;

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
    for (var sub in _subs) {
      await sub.cancel();
    }
  }
}
