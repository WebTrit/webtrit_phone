// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_push_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppPushTokenImpl _$$AppPushTokenImplFromJson(Map<String, dynamic> json) =>
    _$AppPushTokenImpl(
      type: $enumDecode(_$AppPushTokenTypeEnumMap, json['type']),
      value: json['value'] as String,
    );

Map<String, dynamic> _$$AppPushTokenImplToJson(_$AppPushTokenImpl instance) =>
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
