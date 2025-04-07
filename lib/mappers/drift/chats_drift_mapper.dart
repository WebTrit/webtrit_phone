import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

typedef ChatWithLastMessage = (Chat, ChatMessage?);

mixin ChatsDriftMapper {
  Chat chatFromDrift((ChatData, List<ChatMemberData>) data) {
    final (chat, members) = data;
    return Chat(
      id: chat.id,
      type: ChatType.values.byName(chat.type.name),
      name: chat.name,
      createdAt: chat.createdAtRemote,
      updatedAt: chat.updatedAtRemote,
      members: members
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

  ChatWithLastMessage chatWithLastMessageFromDrift(
      (ChatData, List<ChatMemberData>, (ChatMessageData, List<MessageAttachmentData>)?) data) {
    final (chat, members, message) = data;
    return (chatFromDrift((chat, members)), message != null ? messageFromDrift(message) : null);
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

  MessageAttachment attachmentFromDrift(MessageAttachmentData att) {
    return MessageAttachment(id: att.id, fileName: att.fileName, filePath: att.filePath);
  }

  ChatMessage messageFromDrift((ChatMessageData, List<MessageAttachmentData>) data) {
    final (message, attachments) = data;

    return ChatMessage(
      id: message.id,
      idKey: message.idKey,
      senderId: message.senderId,
      chatId: message.chatId,
      replyToId: message.replyToId,
      forwardFromId: message.forwardFromId,
      authorId: message.authorId,
      content: message.content,
      attachments: attachments.map(attachmentFromDrift).toList(),
      createdAt: DateTime.fromMicrosecondsSinceEpoch(message.createdAtRemoteUsec),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(message.updatedAtRemoteUsec),
      editedAt:
          message.editedAtRemoteUsec != null ? DateTime.fromMicrosecondsSinceEpoch(message.editedAtRemoteUsec!) : null,
      deletedAt: message.deletedAtRemoteUsec != null
          ? DateTime.fromMicrosecondsSinceEpoch(message.deletedAtRemoteUsec!)
          : null,
    );
  }

  MessageAttachmentData attachmentToDrift(MessageAttachment att) {
    return MessageAttachmentData(id: att.id, fileName: att.fileName, filePath: att.filePath);
  }

  (ChatMessageData, List<MessageAttachmentData>) messageToDrift(ChatMessage message) {
    return (
      ChatMessageData(
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
      ),
      message.attachments.map(attachmentToDrift).toList()
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
