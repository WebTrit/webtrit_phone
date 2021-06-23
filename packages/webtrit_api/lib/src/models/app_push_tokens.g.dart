// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_push_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AppCreatePushTokenRequestToJson(
        AppCreatePushTokenRequest instance) =>
    <String, dynamic>{
      'type': _$PushTokenTypeEnumMap[instance.type],
      'value': instance.value,
    };

const _$PushTokenTypeEnumMap = {
  PushTokenType.fcm: 'fcm',
  PushTokenType.hms: 'hms',
  PushTokenType.apns: 'apns',
  PushTokenType.apkvoip: 'apkvoip',
};
