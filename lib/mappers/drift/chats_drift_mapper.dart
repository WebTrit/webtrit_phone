import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

typedef ChatWithLastMessage = (Chat, ChatMessage?);

mixin ChatsDriftMapper {
  Chat chatFromDrift(ChatDataWithMembers data) {
    final chatData = data.chatData;
    final chatMembers = data.members;

    return Chat(
      id: chatData.id,
      type: ChatType.values.byName(chatData.type.name),
      name: chatData.name,
      createdAt: chatData.createdAtRemote,
      updatedAt: chatData.updatedAtRemote,
      members: chatMembers
          .map(
            (e) => ChatMember(
              id: e.id,
              chatId: e.chatId,
              userId: e.userId,
              groupAuthorities: e.groupAuthorities != null
                  ? GroupAuthorities.values.byName(e.groupAuthorities!.name)
                  : null,
            ),
          )
          .toList(),
    );
  }

  ChatWithLastMessage chatWithLastMessageFromDrift((ChatDataWithMembers, ChatMessageData?) data) {
    final lastMessageData = data.$2;
    return (chatFromDrift(data.$1), lastMessageData != null ? messageFromDrift(lastMessageData) : null);
  }

  ChatData chatToDrift(Chat chat) {
    return ChatData(
      id: chat.id,
      type: ChatTypeEnum.values.byName(chat.type.name),
      name: chat.name,
      createdAtRemote: chat.createdAt,
      updatedAtRemote: chat.updatedAt,
    );
  }

  ChatMemberData chatMemberToDrift(ChatMember chatMember) {
    return ChatMemberData(
      id: chatMember.id,
      chatId: chatMember.chatId,
      userId: chatMember.userId,
      groupAuthorities: chatMember.groupAuthorities != null
          ? GroupAuthoritiesEnum.values.byName(chatMember.groupAuthorities!.name)
          : null,
    );
  }

  ChatMessage messageFromDrift(ChatMessageData data) {
    return ChatMessage(
      id: data.id,
      idKey: data.idKey,
      senderId: data.senderId,
      chatId: data.chatId,
      replyToId: data.replyToId,
      forwardFromId: data.forwardFromId,
      authorId: data.authorId,
      content: data.content,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(data.createdAtRemoteUsec),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(data.updatedAtRemoteUsec),
      editedAt: data.editedAtRemoteUsec != null ? DateTime.fromMicrosecondsSinceEpoch(data.editedAtRemoteUsec!) : null,
      deletedAt: data.deletedAtRemoteUsec != null
          ? DateTime.fromMicrosecondsSinceEpoch(data.deletedAtRemoteUsec!)
          : null,
    );
  }

  ChatMessageData messageToDrift(ChatMessage message) {
    return ChatMessageData(
      id: message.id,
      idKey: message.idKey,
      senderId: message.senderId,
      chatId: message.chatId,
      replyToId: message.replyToId,
      forwardFromId: message.forwardFromId,
      authorId: message.authorId,
      content: message.content,
      createdAtRemoteUsec: message.createdAt.microsecondsSinceEpoch,
      updatedAtRemoteUsec: message.updatedAt.microsecondsSinceEpoch,
      editedAtRemoteUsec: message.editedAt?.microsecondsSinceEpoch,
      deletedAtRemoteUsec: message.deletedAt?.microsecondsSinceEpoch,
    );
  }

  MessageSyncCursorType messageSyncCursorTypeFromDrift(MessageSyncCursorTypeEnum type) {
    return MessageSyncCursorType.values.byName(type.name);
  }

  MessageSyncCursorTypeEnum messageSyncCursorTypeToDrift(MessageSyncCursorType type) {
    return MessageSyncCursorTypeEnum.values.byName(type.name);
  }

  ChatMessageSyncCursor messageSyncCursorFromDrift(ChatMessageSyncCursorData data) {
    return ChatMessageSyncCursor(
      chatId: data.chatId,
      cursorType: messageSyncCursorTypeFromDrift(data.cursorType),
      time: DateTime.fromMicrosecondsSinceEpoch(data.timestampUsec),
    );
  }

  ChatMessageSyncCursorData messageSyncCursorToDrift(ChatMessageSyncCursor cursor) {
    return ChatMessageSyncCursorData(
      chatId: cursor.chatId,
      cursorType: messageSyncCursorTypeToDrift(cursor.cursorType),
      timestampUsec: cursor.time.microsecondsSinceEpoch,
    );
  }

  ChatMessageReadCursor messageReadCursorFromDrift(ChatMessageReadCursorData data) {
    return ChatMessageReadCursor(
      chatId: data.chatId,
      userId: data.userId,
      time: DateTime.fromMicrosecondsSinceEpoch(data.timestampUsec),
    );
  }

  ChatMessageReadCursorData messageReadCursorToDrift(ChatMessageReadCursor cursor) {
    return ChatMessageReadCursorData(
      chatId: cursor.chatId,
      userId: cursor.userId,
      timestampUsec: cursor.time.microsecondsSinceEpoch,
    );
  }
}
