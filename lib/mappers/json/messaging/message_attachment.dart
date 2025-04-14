import 'dart:convert';

import 'package:webtrit_phone/models/models.dart';

class MessageAttachmentJsonMapper {
  static Map<String, dynamic> toMap(MessageAttachment attachment) {
    return <String, dynamic>{
      'id': attachment.id,
      'fileName': attachment.fileName,
      'filePath': attachment.filePath,
    };
  }

  static MessageAttachment fromMap(Map<String, dynamic> map) {
    return MessageAttachment(
      id: map['id'] as int,
      fileName: map['fileName'] as String,
      filePath: map['filePath'] as String,
    );
  }

  static String toJson(MessageAttachment attachment) => json.encode(toMap(attachment));
  static MessageAttachment fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
}

mixin MessageAttachmentJsonMapperMixin {
  messageAttachmentToMap(MessageAttachment attachment) => MessageAttachmentJsonMapper.toMap(attachment);
  messageAttachmentFromMap(Map<String, dynamic> map) => MessageAttachmentJsonMapper.fromMap(map);
  messageAttachmentToJson(MessageAttachment attachment) => MessageAttachmentJsonMapper.toJson(attachment);
  messageAttachmentFromJson(String source) => MessageAttachmentJsonMapper.fromJson(source);
}
