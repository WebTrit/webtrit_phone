import 'package:webtrit_phone/models/sms_conversation.dart';

class SmsConversationPhxMapper {
  static SmsConversation fromMap(Map<String, dynamic> map) {
    return SmsConversation(
      id: map['id'] as int,
      firstPhoneNumber: map['first_phone_number'] as String,
      secondPhoneNumber: map['second_phone_number'] as String,
      createdAt: DateTime.parse(map['inserted_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}

mixin SmsConversationPhxMapperMixin {
  SmsConversation fromMap(Map<String, dynamic> map) => SmsConversationPhxMapper.fromMap(map);
}
