// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_push_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppPushToken _$AppPushTokenFromJson(Map<String, dynamic> json) => AppPushToken(
  type: $enumDecode(_$AppPushTokenTypeEnumMap, json['type']),
  value: json['value'] as String,
  env: $enumDecodeNullable(_$AppPushTokenEnvEnumMap, json['env']),
);

Map<String, dynamic> _$AppPushTokenToJson(AppPushToken instance) =>
    <String, dynamic>{
      'type': _$AppPushTokenTypeEnumMap[instance.type]!,
      'value': instance.value,
      'env': _$AppPushTokenEnvEnumMap[instance.env],
    };

const _$AppPushTokenTypeEnumMap = {
  AppPushTokenType.fcm: 'fcm',
  AppPushTokenType.hms: 'hms',
  AppPushTokenType.apns: 'apns',
  AppPushTokenType.apkvoip: 'apkvoip',
};

const _$AppPushTokenEnvEnumMap = {
  AppPushTokenEnv.dev: 'dev',
  AppPushTokenEnv.prod: 'prod',
};
