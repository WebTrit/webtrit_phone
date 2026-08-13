// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSession _$UserSessionFromJson(Map<String, dynamic> json) => UserSession(
  id: json['id'] as String,
  current: json['current'] as bool,
  status: $enumDecode(
    _$UserSessionStatusEnumMap,
    json['status'],
    unknownValue: UserSessionStatus.unknown,
  ),
  userAgent: json['user_agent'] as String?,
  ip: json['ip'] as String?,
  location: json['location'] as String?,
  lastActivityIp: json['last_activity_ip'] as String?,
  lastActivityLocation: json['last_activity_location'] as String?,
  appType: $enumDecodeNullable(_$AppTypeEnumMap, json['app_type']),
  appIdentifier: json['app_identifier'] as String?,
  appBundleId: json['app_bundle_id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  lastActivityAt: json['last_activity_at'] == null
      ? null
      : DateTime.parse(json['last_activity_at'] as String),
);

Map<String, dynamic> _$UserSessionToJson(UserSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'current': instance.current,
      'status': _$UserSessionStatusEnumMap[instance.status]!,
      'user_agent': instance.userAgent,
      'ip': instance.ip,
      'location': instance.location,
      'last_activity_ip': instance.lastActivityIp,
      'last_activity_location': instance.lastActivityLocation,
      'app_type': _$AppTypeEnumMap[instance.appType],
      'app_identifier': instance.appIdentifier,
      'app_bundle_id': instance.appBundleId,
      'created_at': instance.createdAt?.toIso8601String(),
      'last_activity_at': instance.lastActivityAt?.toIso8601String(),
    };

const _$UserSessionStatusEnumMap = {
  UserSessionStatus.unknown: 'unknown',
  UserSessionStatus.active: 'active',
  UserSessionStatus.inactive: 'inactive',
  UserSessionStatus.missing: 'missing',
  UserSessionStatus.expired: 'expired',
  UserSessionStatus.invalid: 'invalid',
  UserSessionStatus.error: 'error',
};

const _$AppTypeEnumMap = {
  AppType.smart: 'smart',
  AppType.web: 'web',
  AppType.linux: 'linux',
  AppType.macos: 'macos',
  AppType.windows: 'windows',
  AppType.android: 'android',
  AppType.androidHms: 'android_hms',
  AppType.ios: 'ios',
};
