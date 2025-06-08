import 'package:webtrit_phone/models/messaging/chat_conversation/chat_message_read_cursor.dart';

class ChatMessageReadCursorPhxMapper {
  static ChatMessageReadCursor fromMap(Map<String, dynamic> map) {
    return ChatMessageReadCursor(
      chatId: map['chat_id'] as int,
      userId: map['user_id'] as String,
      time: DateTime.parse(map['last_read_at'] as String),
    );
  }
}

mixin ChatMessageReadCursorPhxMapperMixin {
  ChatMessageReadCursor fromMap(Map<String, dynamic> map) => ChatMessageReadCursorPhxMapper.fromMap(map);
}
