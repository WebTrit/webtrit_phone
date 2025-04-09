import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

class ChatsRepository with ChatsDriftMapper {
  ChatsRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;
  ChatsDao get _chatsDao => _appDatabase.chatsDao;

  final StreamController<ChatsEvent> _eventBus = StreamController.broadcast();
  Stream<ChatsEvent> get eventBus => _eventBus.stream;
  _addEvent(ChatsEvent event) => _eventBus.add(event);

  Future<Chat?> getChat(int chatId) async {
    final chatData = await _chatsDao.getChatWithMembers(chatId);
    if (chatData == null) return null;
    return chatFromDrift(chatData);
  }

  Future<List<Chat>> getChats() async {
    final chatsData = await _chatsDao.getAllChatsWithMembers();
    return chatsData.map(chatFromDrift).toList();
  }

  Future<List<(Chat, ChatMessage?)>> getChatsWithLastMessages() async {
    final chatsData = await _chatsDao.getAllChatsWithMembersAndLastMessage();
    return chatsData.map((data) => chatWithLastMessageFromDrift(data)).toList();
  }

  Future<List<int>> getChatIds() async {
    return _chatsDao.getChatIds();
  }

  Future<int?> findDialogId(String participantId) {
    return _chatsDao.findDialogId(participantId);
  }

  Future<void> upsertChat(Chat chat) async {
    final chatData = chatToDrift(chat);
    final membersData = chat.members.map(chatMemberToDrift).toList();
    _chatsDao.upsertChatWithMembers(chatData, membersData);
    _addEvent(ChatUpdate(chat));
  }

  Future<void> deleteChatById(int chatId) async {
    await _chatsDao.deleteChatById(chatId);
    _addEvent(ChatRemove(chatId));
  }

  Future<ChatMessage?> getMessageById(int messageId) async {
    final messageData = await _chatsDao.getMessageById(messageId);
    return messageData != null ? messageFromDrift(messageData) : null;
  }

  Future<List<ChatMessage>> getMessageHistory(int chatId, {DateTime? from, DateTime? to, int limit = 100}) async {
    final messagesData = await _chatsDao.getMessageHistory(chatId, from: from, to: to, limit: limit);
    return messagesData.map(messageFromDrift).toList();
  }

  Future<void> upsertMessage(ChatMessage message, {bool silent = false}) async {
    await _chatsDao.upsertChatMessage(messageToDrift(message));
    if (!silent) _addEvent(ChatMessageUpdate(message));
  }

  Future<void> upsertMessages(Iterable<ChatMessage> messages, {bool silent = false}) async {
    await _chatsDao.upsertChatMessages(messages.map(messageToDrift));
    if (!silent) {
      for (final message in messages) {
        _addEvent(ChatMessageUpdate(message));
      }
    }
  }

  Future<ChatMessageSyncCursor?> getChatMessageSyncCursor(int chatId, MessageSyncCursorType cursorType) async {
    final type = messageSyncCursorTypeToDrift(cursorType);
    final data = await _chatsDao.getChatMessageSyncCursor(chatId, type);
    if (data != null) return messageSyncCursorFromDrift(data);
    return null;
  }

  Future<void> upsertChatMessageSyncCursor(ChatMessageSyncCursor cursor) async {
    final data = messageSyncCursorToDrift(cursor);
    await _chatsDao.upsertChatMessageSyncCursor(data);
  }

  Future<ChatMessageReadCursor?> getChatMessageReadCursor(int chatId, String userId) async {
    final data = await _chatsDao.getChatMessageReadCursor(chatId, userId);
    if (data != null) return messageReadCursorFromDrift(data);
    return null;
  }

  Stream<List<ChatMessageReadCursor>> watchChatMessageReadCursors(int chatId) {
    return _chatsDao.watchChatMessageReadCursors(chatId).map((data) => data.map(messageReadCursorFromDrift).toList());
  }

  Future<void> upsertChatMessageReadCursor(ChatMessageReadCursor cursor) async {
    final data = ChatMessageReadCursorData(
      chatId: cursor.chatId,
      userId: cursor.userId,
      timestampUsec: cursor.time.microsecondsSinceEpoch,
    );
    final inserted = await _chatsDao.upsertChatMessageReadCursor(data);
    if (inserted != null) _addEvent(ChatReadCursorUpdate(cursor));
  }

  Future<Map<int, int>> unreadedCountPerChat(String userId) {
    return _chatsDao.unreadedCountPerChat(userId);
  }

  Future<List<MessageAttachment>> getAttachmentsForLastMessages(int chatId, {int msgLimit = 10}) async {
    final messagesData = await _chatsDao.getAttachmentsForLastMessages(chatId, msgLimit);
    return messagesData.map(attachmentFromDrift).toList();
  }

  Future<void> wipeStaleDeletedData() async {
    await _chatsDao.wipeStaleDeletedChatMessagesData();
  }

  Future<void> wipeChatsData() async {
    await _chatsDao.wipeChatsData();
  }
}
