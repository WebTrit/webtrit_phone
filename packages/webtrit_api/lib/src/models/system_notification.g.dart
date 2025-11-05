// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemNotification _$SystemNotificationFromJson(Map<String, dynamic> json) =>
    SystemNotification(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      seen: json['seen'] as bool,
      type: $enumDecode(_$SystemNotificationTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      readAt: json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String),
    );

Map<String, dynamic> _$SystemNotificationToJson(SystemNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'seen': instance.seen,
      'type': _$SystemNotificationTypeEnumMap[instance.type]!,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'read_at': instance.readAt?.toIso8601String(),
    };

const _$SystemNotificationTypeEnumMap = {
  SystemNotificationType.announcement: 'announcement',
  SystemNotificationType.promotion: 'promotion',
  SystemNotificationType.security: 'security',
  SystemNotificationType.system: 'system',
};

SystemNotificationResponce _$SystemNotificationResponceFromJson(
  Map<String, dynamic> json,
) =>
    SystemNotificationResponce(
      items: (json['items'] as List<dynamic>)
          .map((e) => SystemNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SystemNotificationResponceToJson(
  SystemNotificationResponce instance,
) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
