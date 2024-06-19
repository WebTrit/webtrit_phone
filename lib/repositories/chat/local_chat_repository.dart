import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'components/chats_event.dart';
import 'components/drift_mapper.dart';

Logger _logger = Logger('LocalChatRepository');

class LocalChatRepository with ChatsDriftMapper {
  LocalChatRepository({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

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

  Stream<List<Chat>> watchChats() {
    return _chatsDao.watchAllChatsWithMembers().map((chatsData) {
      return chatsData.map(chatFromDrift).toList();
    });
  }

  Future<List<int>> getActiveChatIds() async {
    return _chatsDao.getActiveChatIds();
  }

  Future<int?> findDialogId(String participantId) {
    return _chatsDao.findDialogId(participantId);
  }

  Future<DateTime?> getLastChatUpdate() async {
    return _chatsDao.lastChatUpdatedAt();
  }

  Future<void> upsertChat(Chat chat) async {
    try {
      final chatData = chatDataFromChat(chat);
      final membersData = chat.members.map(chatMemberDataFromChatMember).toList();

      await _chatsDao.upsertChat(chatData);
      for (final memberData in membersData) {
        await _chatsDao.upsertChatMember(memberData);
      }
      _addEvent(ChatUpdate(chat));
    } on Exception catch (e) {
      _logger.warning('upsertChat failed, retrying', e);
      // Drift lock exception handling, coz cant import [DriftRemoteException]
      await Future.delayed(const Duration(milliseconds: 100));
      await upsertChat(chat);
    }
  }

  Future<List<ChatMessage>> getLastMessages(int chatId, {int limit = 100}) async {
    final messagesData = await _chatsDao.getLastMessages(chatId, limit: limit);
    return messagesData.map(chatMessageFromDrift).toList();
  }

  Future<List<ChatMessage>> getMessageHistory(int chatId, DateTime from, DateTime to) async {
    final messagesData = await _chatsDao.getMessageHistory(chatId, from, to);
    return messagesData.map(chatMessageFromDrift).toList();
  }

  Stream<List<ChatMessage>> watchLastMessageUpdates(int chatId, {int limit = 100}) {
    return _chatsDao.watchLastMessageUpdates(chatId, limit: limit).map((messagesData) {
      return messagesData.map(chatMessageFromDrift).toList();
    });
  }

  Future<void> upsertMessage(ChatMessage message) async {
    try {
      await _chatsDao.upsertChatMessage(chatMessageDataFromChatMessage(message));
      _addEvent(ChatMessageUpdate(message));
    } on Exception catch (e) {
      _logger.warning('upsertMessage failed, retrying', e);
      // Drift lock exception handling, coz cant import [DriftRemoteException]
      await Future.delayed(const Duration(milliseconds: 100));
      await upsertMessage(message);
    }
  }

  Future<DateTime?> lastChatMessageUpdatedAt(int chatId) async {
    return _chatsDao.lastChatMessageUpdatedAt(chatId);
  }

  Future<void> wipeStaleDeletedData() async {
    await _chatsDao.wipeStaleDeletedChatMessagesData();
    await _chatsDao.wipeStaleDeletedChatsData();
  }

  Future<void> wipeData() async {
    await _chatsDao.wipeChatsData();
  }
}
