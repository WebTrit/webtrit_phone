import 'dart:convert';

import 'package:webtrit_phone/models/models.dart';

class SmsConversationJsonMapper {
  static Map<String, dynamic> toMap(SmsConversation conversation) {
    return <String, dynamic>{
      'id': conversation.id,
      'first_phone_number': conversation.firstPhoneNumber,
      'second_phone_number': conversation.secondPhoneNumber,
      'inserted_at': conversation.createdAt.toIso8601String(),
      'updated_at': conversation.updatedAt.toIso8601String(),
    };
  }

  static SmsConversation fromMap(Map<String, dynamic> map) {
    return SmsConversation(
      id: map['id'] as int,
      firstPhoneNumber: map['first_phone_number'] as String,
      secondPhoneNumber: map['second_phone_number'] as String,
      createdAt: DateTime.parse(map['inserted_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  static String toJson(SmsConversation conversation) => json.encode(toMap(conversation));

  static SmsConversation fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
}

mixin SmsConversationJsonMapperMixin {
  smsConversationtoMap(SmsConversation conversation) => SmsConversationJsonMapper.toMap(conversation);
  smsConversationfromMap(Map<String, dynamic> map) => SmsConversationJsonMapper.fromMap(map);
  smsConversationtoJson(SmsConversation conversation) => SmsConversationJsonMapper.toJson(conversation);
  smsConversationfromJson(String source) => SmsConversationJsonMapper.fromJson(source);
}
