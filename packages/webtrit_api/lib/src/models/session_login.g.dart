// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SessionLoginRequestToJson(
        SessionLoginRequest instance) =>
    <String, dynamic>{
      'type': _$AppTypeEnumMap[instance.type],
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

SessionLoginResponse _$SessionLoginResponseFromJson(Map<String, dynamic> json) {
  return SessionLoginResponse(
    token: json['token'] as String,
  );
}
