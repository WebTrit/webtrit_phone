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

  ConversationWithLastMessage conversationWithLastMessageFromDrift((SmsConversationData, SmsMessageData?) data) {
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

  SmsMessage messageFromDrift(SmsMessageData data) {
    return SmsMessage(
      id: data.id,
      idKey: data.idKey,
      externalId: data.externalId,
      conversationId: data.conversationId,
      fromPhoneNumber: data.fromPhoneNumber,
      toPhoneNumber: data.toPhoneNumber,
      sendingStatus: SmsSendingStatus.values.byName(data.sendingStatus.name),
      content: data.content,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(data.createdAtRemoteUsec),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(data.updatedAtRemoteUsec),
      deletedAt:
          data.deletedAtRemoteUsec != null ? DateTime.fromMicrosecondsSinceEpoch(data.deletedAtRemoteUsec!) : null,
    );
  }

  SmsMessageData messageToDrift(SmsMessage message) {
    return SmsMessageData(
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
}
