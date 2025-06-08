import 'package:webtrit_phone/models/sms_message.dart';

class SmsMessagePhxMapper {
  static SmsMessage fromMap(Map<String, dynamic> map) {
    return SmsMessage(
      id: map['id'] as int,
      idKey: map['idempotency_key'] as String,
      externalId: map['external_id'] != null ? map['external_id'] as String : null,
      conversationId: map['sms_conversation_id'] as int,
      fromPhoneNumber: map['from_phone_number'] as String,
      toPhoneNumber: map['to_phone_number'] as String,
      sendingStatus: SmsSendingStatus.values.byName(map['sending_status'] as String),
      content: map['content'] as String,
      createdAt: DateTime.parse(map['inserted_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      deletedAt: map['deleted_at'] != null ? DateTime.parse(map['deleted_at'] as String) : null,
    );
  }
}

mixin class SmsMessageMapperPhxMixin {
  SmsMessage fromMap(Map<String, dynamic> map) => SmsMessagePhxMapper.fromMap(map);
}
