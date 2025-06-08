import 'package:webtrit_phone/models/chat_message.dart';

class ChatMessagePhxMapper {
  static ChatMessage fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as int,
      idKey: map['idempotency_key'] as String,
      senderId: map['sender_id'] as String,
      chatId: map['chat_id'] as int,
      replyToId: map['reply_to_id'] != null ? map['reply_to_id'] as int : null,
      forwardFromId: map['forwarded_from_id'] != null ? map['forwarded_from_id'] as int : null,
      authorId: map['author_id'] != null ? map['author_id'] as String : null,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      editedAt: map['edited_at'] != null ? DateTime.parse(map['edited_at'] as String) : null,
      deletedAt: map['deleted_at'] != null ? DateTime.parse(map['deleted_at'] as String) : null,
    );
  }
}

mixin class ChatMessagePhxMapperMixin {
  ChatMessage fromMap(Map<String, dynamic> map) => ChatMessagePhxMapper.fromMap(map);
}
