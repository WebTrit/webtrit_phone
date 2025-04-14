import 'dart:convert';

import 'package:webtrit_phone/models/models.dart';

import 'message_attachment.dart';

class SmsMessageJsonMapper {
  static Map<String, dynamic> toMap(SmsMessage message) {
    return <String, dynamic>{
      'id': message.id,
      'idempotency_key': message.idKey,
      'external_id': message.externalId,
      'sms_conversation_id': message.conversationId,
      'from_phone_number': message.fromPhoneNumber,
      'to_phone_number': message.toPhoneNumber,
      'sending_status': message.sendingStatus.name,
      'content': message.content,
      'attachments': message.attachments.map((x) => MessageAttachmentJsonMapper.toMap(x)).toList(),
      'inserted_at': message.createdAt.toIso8601String(),
      'updated_at': message.updatedAt.toIso8601String(),
      'deleted_at': message.deletedAt?.toIso8601String(),
    };
  }

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
      attachments: map['attachments'] != null
          ? List<MessageAttachment>.from(
              (map['attachments'] as List<dynamic>)
                  .map<MessageAttachment>((x) => MessageAttachmentJsonMapper.fromMap(x as Map<String, dynamic>)),
            )
          : <MessageAttachment>[],
      createdAt: DateTime.parse(map['inserted_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      deletedAt: map['deleted_at'] != null ? DateTime.parse(map['deleted_at'] as String) : null,
    );
  }

  static String toJson(SmsMessage message) => json.encode(toMap(message));

  static SmsMessage fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
}

mixin SmsMessageJsonMapperMixin {
  smsMessagetoMap(SmsMessage message) => SmsMessageJsonMapper.toMap(message);
  smsMessagefromMap(Map<String, dynamic> map) => SmsMessageJsonMapper.fromMap(map);
  smsMessagetoJson(SmsMessage message) => SmsMessageJsonMapper.toJson(message);
  smsMessagefromJson(String source) => SmsMessageJsonMapper.fromJson(source);
}
