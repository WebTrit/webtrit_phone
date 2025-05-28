// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SystemNotificationImpl _$$SystemNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$SystemNotificationImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      seen: json['seen'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      readAt: json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String),
    );

Map<String, dynamic> _$$SystemNotificationImplToJson(
        _$SystemNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'seen': instance.seen,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'read_at': instance.readAt?.toIso8601String(),
    };

_$SystemNotificationResponceImpl _$$SystemNotificationResponceImplFromJson(
        Map<String, dynamic> json) =>
    _$SystemNotificationResponceImpl(
      notifications: (json['notifications'] as List<dynamic>)
          .map((e) => SystemNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$SystemNotificationResponceImplToJson(
        _$SystemNotificationResponceImpl instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'total': instance.total,
    };
