// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_login_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionLoginCredentialImpl _$$SessionLoginCredentialImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionLoginCredentialImpl(
      bundleId: json['bundle_id'] as String?,
      type: $enumDecode(_$AppTypeEnumMap, json['type']),
      identifier: json['identifier'] as String,
      login: json['login'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$SessionLoginCredentialImplToJson(
        _$SessionLoginCredentialImpl instance) =>
    <String, dynamic>{
      'bundle_id': instance.bundleId,
      'type': _$AppTypeEnumMap[instance.type]!,
      'identifier': instance.identifier,
      'login': instance.login,
      'password': instance.password,
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
