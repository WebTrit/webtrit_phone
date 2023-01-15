// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_otp_credential_demo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SessionOtpCredentialDemo _$$_SessionOtpCredentialDemoFromJson(
        Map<String, dynamic> json) =>
    _$_SessionOtpCredentialDemo(
      type: $enumDecode(_$AppTypeEnumMap, json['type']),
      identifier: json['identifier'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_SessionOtpCredentialDemoToJson(
        _$_SessionOtpCredentialDemo instance) =>
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
