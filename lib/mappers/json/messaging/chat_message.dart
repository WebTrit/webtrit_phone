import 'dart:convert';

import 'package:webtrit_phone/models/models.dart';
import 'message_attachment.dart';

class ChatMessageJsonMapper {
  static Map<String, dynamic> toMap(ChatMessage message) {
    return <String, dynamic>{
      'id': message.id,
      'idempotency_key': message.idKey,
      'sender_id': message.senderId,
      'chat_id': message.chatId,
      'reply_to_id': message.replyToId,
      'forwarded_from_id': message.forwardFromId,
      'author_id': message.authorId,
      'content': message.content,
      'attachments': message.attachments.map((x) => MessageAttachmentJsonMapper.toMap(x)).toList(),
      'created_at': message.createdAt.toIso8601String(),
      'updated_at': message.updatedAt.toIso8601String(),
      'edited_at': message.editedAt?.toIso8601String(),
      'deleted_at': message.deletedAt?.toIso8601String(),
    };
  }

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
      attachments: map['attachments'] != null
          ? List<MessageAttachment>.from(
              (map['attachments'] as List<dynamic>)
                  .map<MessageAttachment>((x) => MessageAttachmentJsonMapper.fromMap(x as Map<String, dynamic>)),
            )
          : <MessageAttachment>[],
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      editedAt: map['edited_at'] != null ? DateTime.parse(map['edited_at'] as String) : null,
      deletedAt: map['deleted_at'] != null ? DateTime.parse(map['deleted_at'] as String) : null,
    );
  }

  static String toJson(ChatMessage message) => json.encode(toMap(message));

  static ChatMessage fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
}

mixin ChatMessageJsonMapperMixin {
  chatMessagetoMap(ChatMessage message) => ChatMessageJsonMapper.toMap(message);
  chatMessagefromMap(Map<String, dynamic> map) => ChatMessageJsonMapper.fromMap(map);
  chatMessagetoJson(ChatMessage message) => ChatMessageJsonMapper.toJson(message);
  chatMessagefromJson(String source) => ChatMessageJsonMapper.fromJson(source);
}
