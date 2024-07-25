import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'components/chats_events.dart';
import 'components/chats_drift_mapper.dart';

Logger _logger = Logger('ChatsRepository');

class ChatsRepository with ChatsDriftMapper {
  ChatsRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;
  ChatsDao get _chatsDao => _appDatabase.chatsDao;

  final StreamController<ChatsEvent> _eventBus = StreamController.broadcast();
  Stream<ChatsEvent> get eventBus => _eventBus.stream;
  _addEvent(ChatsEvent event) => _eventBus.add(event);

  Future<Chat> getChat(int chatId) async {
    final chatData = await _chatsDao.getChatWithMembers(chatId);
    return chatFromDrift(chatData);
  }

  Future<List<Chat>> getChats() async {
    final chatsData = await _chatsDao.getAllChatsWithMembers();
    return chatsData.map(chatFromDrift).toList();
  }

  Future<List<int>> getChatIds() async {
    return _chatsDao.getChatIds();
  }

  Future<int?> findDialogId(String participantId) {
    return _chatsDao.findDialogId(participantId);
  }

  Future<void> upsertChat(Chat chat) async {
    final chatData = chatDataFromChat(chat);
    final membersData = chat.members.map(chatMemberDataFromChatMember).toList();
    final chatDataWithMembers = ChatDataWithMembers(chatData, membersData);
    _chatsDao.upsertChatWithMembers(chatDataWithMembers);
    _addEvent(ChatUpdate(chat));
  }

  Future<void> deleteChatById(int chatId) async {
    await _chatsDao.deleteChatById(chatId);
    _addEvent(ChatRemove(chatId));
  }

  Future<ChatMessage?> getMessageById(int messageId) async {
    final messageData = await _chatsDao.getChatMessageById(messageId);
    return messageData != null ? chatMessageFromDrift(messageData) : null;
  }

  Future<List<ChatMessage>> getMessageHistory(int chatId, {DateTime? from, DateTime? to, int limit = 100}) async {
    final messagesData = await _chatsDao.getMessageHistory(chatId, from: from, to: to, limit: limit);
    return messagesData.map(chatMessageFromDrift).toList();
  }

  Future<void> upsertMessage(ChatMessage message, {bool silent = false}) async {
    try {
      await _chatsDao.upsertChatMessage(chatMessageDataFromChatMessage(message));
      if (!silent) _addEvent(ChatMessageUpdate(message));
    } on Exception catch (e) {
      _logger.warning('upsertMessage failed, retrying', e);
      // Drift lock exception handling, coz cant import [DriftRemoteException]
      await Future.delayed(const Duration(milliseconds: 100));
      await upsertMessage(message, silent: silent);
    }
  }

  Future<void> updateViews(List<int> messageIds, DateTime viewedAt) async {
    final messages = await _chatsDao.updateViews(messageIds, viewedAt);
    for (final message in messages) {
      _addEvent(ChatMessageUpdate(chatMessageFromDrift(message)));
    }
  }

  Stream<int> unreadMessagesCount(int chatId, String userId) {
    return _chatsDao.unreadMessagesCount(chatId, userId);
  }

  Stream<int> chatsWithUnreadedMessagesCount(String userId) {
    return _chatsDao.chatsWithUnreadedMessagesCount(userId);
  }

  Future<void> insertHistoryPage(List<ChatMessage> messages) async {
    for (final message in messages) {
      await upsertMessage(message, silent: true);
    }
  }

  Future<int> deleteOutboxMessageDelete(int id) {
    return _chatsDao.deleteChatOutboxMessageDelete(id);
  }

  Future<ChatMessageSyncCursor?> getChatMessageSyncCursor(int chatId, MessageSyncCursorType cursorType) async {
    final type = chatMessageSyncCursorTypeEnumFromDrift(cursorType);
    final data = await _chatsDao.getChatMessageSyncCursor(chatId, type);
    if (data != null) return chatMessageSyncCursorFromDrift(data);
    return null;
  }

  Future<void> upsertChatMessageSyncCursor(ChatMessageSyncCursor cursor) async {
    final data = chatMessageSyncCursorDataFromChatMessageSyncCursor(cursor);
    await _chatsDao.upsertChatMessageSyncCursor(data);
  }

  Future<void> wipeStaleDeletedData() async {
    await _chatsDao.wipeStaleDeletedChatMessagesData();
  }

  Future<void> wipeChatsData() async {
    await _chatsDao.wipeChatsData();
  }
}
