import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/chats/components/chats_outbox_drift_mapper.dart';

Logger _logger = Logger('ChatsOutboxRepository');

class ChatsOutboxRepository with ChatsOutboxDriftMapper {
  ChatsOutboxRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;
  ChatsDao get _chatsDao => _appDatabase.chatsDao;

  Future<List<ChatOutboxMessageEntry>> getChatOutboxMessages() async {
    final entriesData = await _chatsDao.getChatOutboxMessages();
    return entriesData.map(chatOutboxMessageEntryFromDrift).toList();
  }

  Stream<List<ChatOutboxMessageEntry>> watchChatOutboxMessages() {
    return _chatsDao.watchChatOutboxMessages().map((entriesData) {
      return entriesData.map(chatOutboxMessageEntryFromDrift).toList();
    });
  }

  Future<int> upsertOutboxMessage(ChatOutboxMessageEntry entry) {
    final entryData = chatOutboxMessageDataFromChatOutboxMessageEntry(entry);
    return _chatsDao.upsertChatOutboxMessage(entryData);
  }

  Future<int> deleteOutboxMessage(String idKey) {
    return _chatsDao.deleteChatOutboxMessage(idKey);
  }

  Future<List<ChatOutboxMessageEditEntry>> getChatOutboxMessageEdits() async {
    final entriesData = await _chatsDao.getChatOutboxMessageEdits();
    return entriesData.map(chatOutboxMessageEditEntryFromDrift).toList();
  }

  Stream<List<ChatOutboxMessageEditEntry>> watchChatOutboxMessageEdits() {
    return _chatsDao.watchChatOutboxMessageEdits().map((entriesData) {
      return entriesData.map(chatOutboxMessageEditEntryFromDrift).toList();
    });
  }

  Future<int> upsertOutboxMessageEdit(ChatOutboxMessageEditEntry entry) {
    final entryData = chatOutboxMessageEditDataFromChatOutboxMessageEditEntry(entry);
    return _chatsDao.upsertChatOutboxMessageEdit(entryData);
  }

  Future<int> deleteOutboxMessageEdit(int id) {
    return _chatsDao.deleteChatOutboxMessageEdit(id);
  }

  Future<List<ChatOutboxMessageDeleteEntry>> getChatOutboxMessageDeletes() async {
    final entriesData = await _chatsDao.getChatOutboxMessageDeletes();
    return entriesData.map(chatOutboxMessageDeleteEntryFromDrift).toList();
  }

  Stream<List<ChatOutboxMessageDeleteEntry>> watchChatOutboxMessageDeletes() {
    return _chatsDao.watchChatOutboxMessageDeletes().map((entriesData) {
      return entriesData.map(chatOutboxMessageDeleteEntryFromDrift).toList();
    });
  }

  Future<int> upsertOutboxMessageDelete(ChatOutboxMessageDeleteEntry entry) {
    final entryData = chatOutboxMessageDeleteDataFromChatOutboxMessageDeleteEntry(entry);
    return _chatsDao.upsertChatOutboxMessageDelete(entryData);
  }

  Future<int> deleteOutboxMessageDelete(int id) {
    return _chatsDao.deleteChatOutboxMessageDelete(id);
  }

  Future<List<ChatOutboxMessageViewEntry>> getChatOutboxMessageViews() async {
    final entriesData = await _chatsDao.getChatOutboxMessageViews();
    return entriesData.map(chatOutboxMessageViewEntryFromDrift).toList();
  }

  Stream<List<ChatOutboxMessageViewEntry>> watchChatOutboxMessageViews() {
    return _chatsDao.watchChatOutboxMessageViews().map((entriesData) {
      return entriesData.map(chatOutboxMessageViewEntryFromDrift).toList();
    });
  }

  Future<int> upsertOutboxMessageView(ChatOutboxMessageViewEntry entry) {
    final entryData = chatOutboxMessageViewDataFromChatOutboxMessageViewEntry(entry);
    return _chatsDao.upsertChatOutboxMessageView(entryData);
  }

  Future<int> deleteOutboxMessageView(int id) {
    return _chatsDao.deleteChatOutboxMessageView(id);
  }

  Future<void> wipeOutboxData() async {
    await _chatsDao.wipeOutboxMessagesData();
  }
}
