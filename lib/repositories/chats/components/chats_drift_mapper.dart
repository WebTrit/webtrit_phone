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
      creatorId: chatData.creatorId,
      createdAt: chatData.createdAtRemote,
      updatedAt: chatData.updatedAtRemote,
      deletedAt: chatData.deletedAtRemote,
      members: chatMembers
          .map(
            (e) => ChatMember(
              id: e.id,
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

  ChatData chatDataFromChat(Chat chat) {
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

  ChatMemberData chatMemberDataFromChatMember(ChatMember chatMember) {
    return ChatMemberData(
      id: chatMember.id,
      chatId: chatMember.chatId,
      userId: chatMember.userId,
      joinedAt: chatMember.joinedAt,
      leftAt: chatMember.leftAt,
      blockedAt: chatMember.blockedAt,
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
      editedAt: data.editedAt,
      createdAt: data.createdAtRemote,
      updatedAt: data.updatedAtRemote,
      deletedAt: data.deletedAtRemote,
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
      editedAt: message.editedAt,
      createdAtRemote: message.createdAt,
      updatedAtRemote: message.updatedAt,
      deletedAtRemote: message.deletedAt,
    );
  }
}
