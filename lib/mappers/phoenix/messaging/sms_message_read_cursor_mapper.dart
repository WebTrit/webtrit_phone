import 'package:webtrit_phone/models/messaging/sms_conversation/sms_message_read_cursor.dart';

class SmsMessageReadCursorPhxMapper {
  static SmsMessageReadCursor fromMap(Map<String, dynamic> map) {
    return SmsMessageReadCursor(
      conversationId: map['sms_conversation_id'] as int,
      userId: map['user_id'] as String,
      time: DateTime.parse(map['last_read_at'] as String),
    );
  }
}

mixin SmsMessageReadCursorPhxMapperMixin {
  SmsMessageReadCursor fromMap(Map<String, dynamic> map) => SmsMessageReadCursorPhxMapper.fromMap(map);
}
