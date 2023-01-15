// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_push_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppPushToken _$$_AppPushTokenFromJson(Map<String, dynamic> json) =>
    _$_AppPushToken(
      type: $enumDecode(_$AppPushTokenTypeEnumMap, json['type']),
      value: json['value'] as String,
    );

Map<String, dynamic> _$$_AppPushTokenToJson(_$_AppPushToken instance) =>
    <String, dynamic>{
      'type': _$AppPushTokenTypeEnumMap[instance.type]!,
      'value': instance.value,
    };

const _$AppPushTokenTypeEnumMap = {
  AppPushTokenType.fcm: 'fcm',
  AppPushTokenType.hms: 'hms',
  AppPushTokenType.apns: 'apns',
  AppPushTokenType.apkvoip: 'apkvoip',
};
