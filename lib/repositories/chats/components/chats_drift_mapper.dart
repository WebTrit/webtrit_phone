import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin ChatsDriftMapper {
  Chat chatFromDrift(ChatDataWithMembers data) {
    final chatData = data.chatData;
    final chatMembers = data.members;

    return Chat(
      id: chatData.id,
      type: ChatType.values.byName(chatData.type.name),
      name: chatData.name,
      insertedAt: chatData.insertedAtRemote,
      updatedAt: chatData.updatedAtRemote,
      members: chatMembers
          .map(
            (e) => ChatMember(
              id: e.id,
              chatId: e.chatId,
              userId: e.userId,
              groupAuthorities:
                  e.groupAuthorities != null ? GroupAuthorities.values.byName(e.groupAuthorities!.name) : null,
            ),
          )
          .toList(),
    );
  }

  (Chat chat, ChatMessage? message) chatWithLastMessageFromDrift((ChatDataWithMembers, ChatMessageData?) data) {
    final lastMessageData = data.$2;
    return (chatFromDrift(data.$1), lastMessageData != null ? chatMessageFromDrift(lastMessageData) : null);
  }

  ChatData chatDataFromChat(Chat chat) {
    return ChatData(
      id: chat.id,
      type: ChatTypeEnum.values.byName(chat.type.name),
      name: chat.name,
      insertedAtRemote: chat.insertedAt,
      updatedAtRemote: chat.updatedAt,
    );
  }

  ChatMemberData chatMemberDataFromChatMember(ChatMember chatMember) {
    return ChatMemberData(
      id: chatMember.id,
      chatId: chatMember.chatId,
      userId: chatMember.userId,
      groupAuthorities: chatMember.groupAuthorities != null
          ? GroupAuthoritiesEnum.values.byName(chatMember.groupAuthorities!.name)
          : null,
    );
  }

  ChatMessage chatMessageFromDrift(ChatMessageData data) {
    return ChatMessage(
      id: data.id,
      idKey: data.idKey,
      senderId: data.senderId,
      chatId: data.chatId,
      replyToId: data.replyToId,
      forwardFromId: data.forwardFromId,
      authorId: data.authorId,
      viaSms: data.viaSms,
      smsOutState: data.smsOutState != null ? SmsOutState.values.byName(data.smsOutState!.name) : null,
      smsNumber: data.smsNumber,
      content: data.content,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(data.createdAtRemoteUsec),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(data.updatedAtRemoteUsec),
      editedAt: data.editedAtRemoteUsec != null ? DateTime.fromMicrosecondsSinceEpoch(data.editedAtRemoteUsec!) : null,
      deletedAt:
          data.deletedAtRemoteUsec != null ? DateTime.fromMicrosecondsSinceEpoch(data.deletedAtRemoteUsec!) : null,
    );
  }

  ChatMessageData chatMessageDataFromChatMessage(ChatMessage message) {
    return ChatMessageData(
      id: message.id,
      idKey: message.idKey,
      senderId: message.senderId,
      chatId: message.chatId,
      replyToId: message.replyToId,
      forwardFromId: message.forwardFromId,
      authorId: message.authorId,
      viaSms: message.viaSms,
      smsOutState: message.smsOutState != null ? SmsOutStateEnum.values.byName(message.smsOutState!.name) : null,
      smsNumber: message.smsNumber,
      content: message.content,
      createdAtRemoteUsec: message.createdAt.microsecondsSinceEpoch,
      updatedAtRemoteUsec: message.updatedAt.microsecondsSinceEpoch,
      editedAtRemoteUsec: message.editedAt?.microsecondsSinceEpoch,
      deletedAtRemoteUsec: message.deletedAt?.microsecondsSinceEpoch,
    );
  }

  MessageSyncCursorType chatMessageSyncCursorTypeFromDrift(MessageSyncCursorTypeEnum type) {
    return MessageSyncCursorType.values.byName(type.name);
  }

  MessageSyncCursorTypeEnum chatMessageSyncCursorTypeEnumFromDrift(MessageSyncCursorType type) {
    return MessageSyncCursorTypeEnum.values.byName(type.name);
  }

  ChatMessageSyncCursor chatMessageSyncCursorFromDrift(ChatMessageSyncCursorData data) {
    return ChatMessageSyncCursor(
      chatId: data.chatId,
      cursorType: chatMessageSyncCursorTypeFromDrift(data.cursorType),
      time: DateTime.fromMicrosecondsSinceEpoch(data.timestampUsec),
    );
  }

  ChatMessageSyncCursorData chatMessageSyncCursorDataFromChatMessageSyncCursor(ChatMessageSyncCursor cursor) {
    return ChatMessageSyncCursorData(
      chatId: cursor.chatId,
      cursorType: chatMessageSyncCursorTypeEnumFromDrift(cursor.cursorType),
      timestampUsec: cursor.time.microsecondsSinceEpoch,
    );
  }

  ChatMessageReadCursor chatMessageReadCursorFromDrift(ChatMessageReadCursorData data) {
    return ChatMessageReadCursor(
      chatId: data.chatId,
      userId: data.userId,
      time: DateTime.fromMicrosecondsSinceEpoch(data.timestampUsec),
    );
  }

  ChatMessageReadCursorData chatMessageReadCursorDataFromChatMessageReadCursor(ChatMessageReadCursor cursor) {
    return ChatMessageReadCursorData(
      chatId: cursor.chatId,
      userId: cursor.userId,
      timestampUsec: cursor.time.microsecondsSinceEpoch,
    );
  }
}
