// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_voicemail_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserVoicemailListResponseImpl _$$UserVoicemailListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$UserVoicemailListResponseImpl(
  hasNewMessages: json['has_new_messages'] as bool,
  items: (json['items'] as List<dynamic>)
      .map((e) => UserVoicemailItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$UserVoicemailListResponseImplToJson(
  _$UserVoicemailListResponseImpl instance,
) => <String, dynamic>{
  'has_new_messages': instance.hasNewMessages,
  'items': instance.items,
};

_$UserVoicemailItemImpl _$$UserVoicemailItemImplFromJson(
  Map<String, dynamic> json,
) => _$UserVoicemailItemImpl(
  id: json['id'] as String,
  date: json['date'] as String,
  duration: (json['duration'] as num).toDouble(),
  seen: json['seen'] as bool,
  size: (json['size'] as num).toInt(),
  type: json['type'] as String,
);

Map<String, dynamic> _$$UserVoicemailItemImplToJson(
  _$UserVoicemailItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date,
  'duration': instance.duration,
  'seen': instance.seen,
  'size': instance.size,
  'type': instance.type,
};
