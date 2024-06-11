// ignore_for_file: unused_element, unused_field

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

class LocalChatRepository {
  LocalChatRepository({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;
  ChatsDao get _chatsDao => _appDatabase.chatsDao;

  Future<List<Chat>> getChats() async {
    final chatsData = await _chatsDao.getAllChatsWithMembers();
    return chatsData.map(_chatFromDrift).toList();
  }

  Stream<List<Chat>> watchChats() {
    return _chatsDao.watchAllChatsWithMembers().map((chatsData) {
      return chatsData.map(_chatFromDrift).toList();
    });
  }

  Future<void> upsertChat(Chat chat) async {
    final chatData = _chatDataFromChat(chat);
    final membersData = chat.members.map(_chatMemberDataFromChatMember).toList();

    await _chatsDao.upsertChat(chatData);
    for (final memberData in membersData) {
      await _chatsDao.upsertChatMember(memberData);
    }
  }

  Future<List<ChatMessage>> getLastMessages(int chatId, {int limit = 100}) async {
    final messagesData = await _chatsDao.getLastMessages(chatId, limit: limit);
    return messagesData.map(_chatMessageFromDrift).toList();
  }

  Future<List<ChatMessage>> getMessageHistory(int chatId, DateTime from, DateTime to) async {
    final messagesData = await _chatsDao.getMessageHistory(chatId, from, to);
    return messagesData.map(_chatMessageFromDrift).toList();
  }

  Stream<List<ChatMessage>> watchLastMessageUpdates(int chatId, {int limit = 100}) {
    return _chatsDao.watchLastMessageUpdates(chatId, limit: limit).map((messagesData) {
      return messagesData.map(_chatMessageFromDrift).toList();
    });
  }

  Future<void> upsertMessage(ChatMessage message) async {
    await _chatsDao.upsertChatMessage(_chatMessageDataFromChatMessage(message));
  }

  Future<void> wipeStaleDeletedData() async {
    await _chatsDao.wipeStaleDeletedChatMessagesData();
    await _chatsDao.wipeStaleDeletedChatsData();
  }

  Future<void> wipeData() async {
    await _chatsDao.wipeChatsData();
  }

  Chat _chatFromDrift(ChatDataWithMembers data) {
    final chatData = data.chatData;
    final chatMembers = data.members;

    return Chat(
      id: chatData.id,
      type: ChatType.values.byName(chatData.type.name),
      name: chatData.name,
      creatorId: chatData.creatorId,
      createdAt: chatData.createdAtRemote,
      updatedAt: chatData.updatedAtRemote,
      deletedAt: chatData.deletedAtRemote,
      members: chatMembers
          .map(
            (e) => ChatMember(
              chatId: e.chatId,
              userId: e.userId,
              joinedAt: e.joinedAt,
              leftAt: e.leftAt,
              blockedAt: e.blockedAt,
            ),
          )
          .toList(),
    );
  }

  ChatData _chatDataFromChat(Chat chat) {
    return ChatData(
      id: chat.id,
      type: ChatTypeEnum.values.byName(chat.type.name),
      name: chat.name,
      creatorId: chat.creatorId,
      createdAtRemote: chat.createdAt,
      updatedAtRemote: chat.updatedAt,
      deletedAtRemote: chat.deletedAt,
    );
  }

  ChatMemberData _chatMemberDataFromChatMember(ChatMember chatMember) {
    return ChatMemberData(
      chatId: chatMember.chatId,
      userId: chatMember.userId,
      joinedAt: chatMember.joinedAt,
      leftAt: chatMember.leftAt,
      blockedAt: chatMember.blockedAt,
    );
  }

  ChatMessage _chatMessageFromDrift(ChatMessageData data) {
    return ChatMessage(
      id: data.id,
      senderId: data.senderId,
      chatId: data.chatId,
      replyToId: data.replyToId,
      forwardFromId: data.forwardFromId,
      authorId: data.authorId,
      viaSms: data.viaSms,
      smsOutState: data.smsOutState != null ? SmsOutState.values.byName(data.smsOutState!.name) : null,
      smsNumber: data.smsNumber,
      content: data.content,
      createdAt: data.createdAtRemote,
      updatedAt: data.updatedAtRemote,
      deletedAt: data.deletedAtRemote,
    );
  }

  ChatMessageData _chatMessageDataFromChatMessage(ChatMessage message) {
    return ChatMessageData(
      id: message.id,
      senderId: message.senderId,
      chatId: message.chatId,
      replyToId: message.replyToId,
      forwardFromId: message.forwardFromId,
      authorId: message.authorId,
      viaSms: message.viaSms,
      smsOutState: message.smsOutState != null ? SmsOutStateEnum.values.byName(message.smsOutState!.name) : null,
      smsNumber: message.smsNumber,
      content: message.content,
      createdAtRemote: message.createdAt,
      updatedAtRemote: message.updatedAt,
      deletedAtRemote: message.deletedAt,
    );
  }
}
