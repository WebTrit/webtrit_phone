import 'dart:convert';

import 'package:webtrit_phone/models/models.dart';

class SmsMessageReadCursorJsonMapper {
  static Map<String, dynamic> toMap(SmsMessageReadCursor cursor) {
    return <String, dynamic>{
      'sms_conversation_id': cursor.conversationId,
      'user_id': cursor.userId,
      'last_read_at': cursor.time.toIso8601String,
    };
  }

  static SmsMessageReadCursor fromMap(Map<String, dynamic> map) {
    return SmsMessageReadCursor(
      conversationId: map['sms_conversation_id'] as int,
      userId: map['user_id'] as String,
      time: DateTime.parse(map['last_read_at'] as String),
    );
  }

  static String toJson(SmsMessageReadCursor cursor) => json.encode(toMap(cursor));

  static SmsMessageReadCursor fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
}

mixin SmsMessageReadCursorJsonMapperMixin {
  smsMessageReadCursorToMap(SmsMessageReadCursor cursor) => SmsMessageReadCursorJsonMapper.toMap(cursor);
  smsMessageReadCursorFromMap(Map<String, dynamic> map) => SmsMessageReadCursorJsonMapper.fromMap(map);
  smsMessageReadCursorToJson(SmsMessageReadCursor cursor) => SmsMessageReadCursorJsonMapper.toJson(cursor);
  smsMessageReadCursorFromJson(String source) => SmsMessageReadCursorJsonMapper.fromJson(source);
}
