import 'dart:convert';

import 'package:webtrit_phone/models/messaging/chat/chat_message_read_cursor.dart';

class ChatMessageReadCursorJsonMapper {
  static Map<String, dynamic> toMap(ChatMessageReadCursor cursor) {
    return <String, dynamic>{
      'chat_id': cursor.chatId,
      'user_id': cursor.userId,
      'last_read_at': cursor.time.toIso8601String,
    };
  }

  static ChatMessageReadCursor fromMap(Map<String, dynamic> map) {
    return ChatMessageReadCursor(
      chatId: map['chat_id'] as int,
      userId: map['user_id'] as String,
      time: DateTime.parse(map['last_read_at'] as String),
    );
  }

  static String toJson(ChatMessageReadCursor cursor) => json.encode(toMap(cursor));

  static ChatMessageReadCursor fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
}

mixin ChatMessageReadCursorJsonMapperMixin {
  chatMessageReadCursorToMap(ChatMessageReadCursor cursor) => ChatMessageReadCursorJsonMapper.toMap(cursor);
  chatMessageReadCursorFromMap(Map<String, dynamic> map) => ChatMessageReadCursorJsonMapper.fromMap(map);
  chatMessageReadCursorToJson(ChatMessageReadCursor cursor) => ChatMessageReadCursorJsonMapper.toJson(cursor);
  chatMessageReadCursorFromJson(String source) => ChatMessageReadCursorJsonMapper.fromJson(source);
}
