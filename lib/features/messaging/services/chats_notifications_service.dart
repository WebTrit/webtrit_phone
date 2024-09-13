import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('ChatNotificationsService');

class ChatsNotificationsService {
  ChatsNotificationsService(
    this.chatsRepository,
    this.contactsRepository,
    this.remoteNotificationRepository,
    this.localNotificationRepository,
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
  final RemoteNotificationRepository remoteNotificationRepository;
  final LocalNotificationRepository localNotificationRepository;
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
    _subs.add(localNotificationRepository.chatActionsStream.listen(_notificationActionHandler));
    _subs.add(remoteNotificationRepository.chatNotificationsStream.listen(_handleForegroundRemoteNotification));
    _subs.add(remoteNotificationRepository.chatOpenNotificationsStream.listen(_handleOpenedRemoteNotification));
  }

  Future<void> _handleLocalEvent(ChatsEvent e) async {
    // TODO: handle read cursor above displayed notifications and dismiss them
    if (e is ChatMessageUpdate) {
      final message = e.message;
      if (message.senderId == userId) return;

      if (message.deletedAt != null) {
        _dismissNotification(message.id);
      } else {
        _displayNotificationFromEvent(message.chatId, message.senderId, message.id, message.content);
      }
    }
  }

  Future<void> _notificationActionHandler(LocalNotificationActionDTO action) async {
    _logger.info('onActionReceivedMethod');
    try {
      final payload = action.payload;
      final chatId = int.tryParse(payload['chatId'] ?? '');
      if (chatId == null) return;

      await _routeToChat(chatId);
    } on Exception catch (e) {
      _logger.severe('Error handling notification action: $e');
    }
  }

  Future<void> _handleForegroundRemoteNotification(RemoteNotificationDTO message) async {
    _logger.info('onMessageReceivedMethod');
    try {
      // TODO: remove fallback keys
      final chatId = int.tryParse(message.data['chat_id'] ?? '');
      final messageId = int.tryParse(message.data['msg_id'] ?? message.data['chat_message_id'] ?? '');
      final senderId = message.data['sender_id'] ?? message.data['chat_message_sender_id'];
      if (chatId == null || messageId == null || senderId == null) return;

      final title = message.title;
      final body = message.body;
      if (title.isEmpty || body.isEmpty) return;

      _displayNotificationFromRemote(messageId, chatId, senderId, title, body);
    } on Exception catch (e) {
      _logger.severe('Error handling foreground remote message: $e');
    }
  }

  Future<void> _handleOpenedRemoteNotification(RemoteNotificationDTO message) async {
    _logger.info('onMessageReceivedMethod');
    try {
      final chatId = int.tryParse(message.data['chat_id'] ?? '');
      if (chatId == null) return;

      _logger.info('Opening chat $chatId');
      await _routeToChat(chatId);
    } on Exception catch (e) {
      _logger.severe('Error handling foreground remote message: $e');
    }
  }

  Future<void> _routeToChat(int chatId) async {
    final chat = await tryGetChat(chatId);
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

  Future _displayNotificationFromEvent(int chatId, String senderId, int messageId, String content) async {
    if (!handleLocal) return;
    if (_shouldSkipNotification(chatId, senderId)) return;

    try {
      final chat = await tryGetChat(chatId);
      if (chat == null) return;
      final contact = await contactsRepository.getContactBySource(ContactSourceType.external, senderId);

      localNotificationRepository.pushChatMessageNotification(
        messageId,
        chat.type == ChatType.dialog ? contact?.name ?? senderId : chat.name ?? 'Message',
        chat.type == ChatType.dialog ? content : '${contact?.name ?? senderId}: $content',
        {'chatId': chatId.toString()},
      );
    } catch (e) {
      _logger.severe('Error getting chat for message $messageId: $e');
    }
  }

  Future _displayNotificationFromRemote(int messageId, int chatId, String senderId, String title, String body) async {
    if (!handleRemote) return;
    if (_shouldSkipNotification(chatId, senderId)) return;

    localNotificationRepository.pushChatMessageNotification(
      messageId,
      title,
      body,
      {'chatId': chatId.toString()},
    );
  }

  Future _dismissNotification(int messageId) async {
    localNotificationRepository.dissmissNotification(messageId);
  }

  bool _shouldSkipNotification(int chatId, String participantId) {
    final chatsTabActive = mainScreenRouteStateRepository.isChatsTabActive();

    // Skip if chats tab is active and chat screen inside
    final chatScreenActive = mainScreenRouteStateRepository.isChatScreenActive(chatId);
    if (chatScreenActive && chatsTabActive) return true;

    // Skip if chats tab is active and conversation screen inside
    final conversationScreenActive = mainScreenRouteStateRepository.isConversationScreenActive(participantId);
    if (conversationScreenActive && chatsTabActive) return true;

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
