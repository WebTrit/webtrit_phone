// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_voicemail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVoicemail _$UserVoicemailFromJson(Map<String, dynamic> json) => UserVoicemail(
  id: json['id'] as String,
  date: json['date'] as String,
  duration: (json['duration'] as num).toDouble(),
  sender: json['sender'] as String,
  receiver: json['receiver'] as String,
  seen: json['seen'] as bool,
  size: (json['size'] as num).toInt(),
  type: json['type'] as String,
  attachments: (json['attachments'] as List<dynamic>)
      .map((e) => UserVoicemailAttachment.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserVoicemailToJson(UserVoicemail instance) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date,
  'duration': instance.duration,
  'sender': instance.sender,
  'receiver': instance.receiver,
  'seen': instance.seen,
  'size': instance.size,
  'type': instance.type,
  'attachments': instance.attachments.map((e) => e.toJson()).toList(),
};

UserVoicemailAttachment _$UserVoicemailAttachmentFromJson(Map<String, dynamic> json) => UserVoicemailAttachment(
  filename: json['filename'] as String,
  size: (json['size'] as num).toInt(),
  type: json['type'] as String,
  subtype: json['subtype'] as String,
);

Map<String, dynamic> _$UserVoicemailAttachmentToJson(UserVoicemailAttachment instance) => <String, dynamic>{
  'filename': instance.filename,
  'size': instance.size,
  'type': instance.type,
  'subtype': instance.subtype,
};
