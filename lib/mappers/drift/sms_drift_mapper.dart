import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

typedef ConversationWithLastMessage = (SmsConversation, SmsMessage?);

mixin SmsDriftMapper {
  SmsConversation conversationFromDrift(SmsConversationData data) {
    return SmsConversation(
      id: data.id,
      firstPhoneNumber: data.firstPhoneNumber,
      secondPhoneNumber: data.secondPhoneNumber,
      createdAt: data.createdAtRemote,
      updatedAt: data.updatedAtRemote,
    );
  }

  ConversationWithLastMessage conversationWithLastMessageFromDrift(
      (SmsConversationData, (SmsMessageData, List<MessageAttachmentData>)?) data) {
    final lastMessageData = data.$2;
    return (conversationFromDrift(data.$1), lastMessageData != null ? messageFromDrift(lastMessageData) : null);
  }

  SmsConversationData conversationToDrift(SmsConversation chat) {
    return SmsConversationData(
      id: chat.id,
      firstPhoneNumber: chat.firstPhoneNumber,
      secondPhoneNumber: chat.secondPhoneNumber,
      createdAtRemote: chat.createdAt,
      updatedAtRemote: chat.updatedAt,
    );
  }

  MessageAttachment attachmentFromDrift(MessageAttachmentData att) {
    return MessageAttachment(id: att.id, fileName: att.fileName, filePath: att.filePath);
  }

  SmsMessage messageFromDrift((SmsMessageData, List<MessageAttachmentData>) data) {
    final (message, attachments) = data;
    return SmsMessage(
      id: message.id,
      idKey: message.idKey,
      externalId: message.externalId,
      conversationId: message.conversationId,
      fromPhoneNumber: message.fromPhoneNumber,
      toPhoneNumber: message.toPhoneNumber,
      sendingStatus: SmsSendingStatus.values.byName(message.sendingStatus.name),
      content: message.content,
      attachments: attachments.map(attachmentFromDrift).toList(),
      createdAt: DateTime.fromMicrosecondsSinceEpoch(message.createdAtRemoteUsec),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(message.updatedAtRemoteUsec),
      deletedAt: message.deletedAtRemoteUsec != null
          ? DateTime.fromMicrosecondsSinceEpoch(message.deletedAtRemoteUsec!)
          : null,
    );
  }

  MessageAttachmentData attachmentToDrift(MessageAttachment att) {
    return MessageAttachmentData(id: att.id, fileName: att.fileName, filePath: att.filePath);
  }

  (SmsMessageData, List<MessageAttachmentData>) messageToDrift(SmsMessage message) {
    return (
      SmsMessageData(
        id: message.id,
        idKey: message.idKey,
        externalId: message.externalId,
        conversationId: message.conversationId,
        fromPhoneNumber: message.fromPhoneNumber,
        toPhoneNumber: message.toPhoneNumber,
        sendingStatus: SmsSendingStatusEnum.values.byName(message.sendingStatus.name),
        content: message.content,
        createdAtRemoteUsec: message.createdAt.microsecondsSinceEpoch,
        updatedAtRemoteUsec: message.updatedAt.microsecondsSinceEpoch,
        deletedAtRemoteUsec: message.deletedAt?.microsecondsSinceEpoch,
      ),
      message.attachments.map(attachmentToDrift).toList()
    );
  }

  SmsSyncCursorType messageSyncCursorTypeEnumFromDrift(SmsSyncCursorTypeEnum type) {
    return SmsSyncCursorType.values.byName(type.name);
  }

  SmsSyncCursorTypeEnum messageSyncCursorTypeEnumToDrift(SmsSyncCursorType type) {
    return SmsSyncCursorTypeEnum.values.byName(type.name);
  }

  SmsMessageSyncCursor messageSyncCursorFromDrift(SmsMessageSyncCursorData data) {
    return SmsMessageSyncCursor(
      conversationId: data.conversationId,
      cursorType: messageSyncCursorTypeEnumFromDrift(data.cursorType),
      time: DateTime.fromMicrosecondsSinceEpoch(data.timestampUsec),
    );
  }

  SmsMessageSyncCursorData messageSyncCursorToDrift(SmsMessageSyncCursor cursor) {
    return SmsMessageSyncCursorData(
      conversationId: cursor.conversationId,
      cursorType: messageSyncCursorTypeEnumToDrift(cursor.cursorType),
      timestampUsec: cursor.time.microsecondsSinceEpoch,
    );
  }

  SmsMessageReadCursor messageReadCursorFromDrift(SmsMessageReadCursorData data) {
    return SmsMessageReadCursor(
      conversationId: data.conversationId,
      userId: data.userId,
      time: DateTime.fromMicrosecondsSinceEpoch(data.timestampUsec),
    );
  }

  SmsMessageReadCursorData messageReadCursorToDrift(SmsMessageReadCursor cursor) {
    return SmsMessageReadCursorData(
      conversationId: cursor.conversationId,
      userId: cursor.userId,
      timestampUsec: cursor.time.microsecondsSinceEpoch,
    );
  }
}
