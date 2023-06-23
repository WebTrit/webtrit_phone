// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_signup_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserSignupCredentials _$$_UserSignupCredentialsFromJson(
        Map<String, dynamic> json) =>
    _$_UserSignupCredentials(
      type: $enumDecode(_$AppTypeEnumMap, json['type']),
      identifier: json['identifier'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_UserSignupCredentialsToJson(
        _$_UserSignupCredentials instance) =>
    <String, dynamic>{
      'type': _$AppTypeEnumMap[instance.type]!,
      'identifier': instance.identifier,
      'email': instance.email,
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
