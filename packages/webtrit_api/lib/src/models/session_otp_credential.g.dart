// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_otp_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SessionOtpCredential _$$_SessionOtpCredentialFromJson(
        Map<String, dynamic> json) =>
    _$_SessionOtpCredential(
      type: $enumDecode(_$AppTypeEnumMap, json['type']),
      identifier: json['identifier'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$_SessionOtpCredentialToJson(
        _$_SessionOtpCredential instance) =>
    <String, dynamic>{
      'type': _$AppTypeEnumMap[instance.type]!,
      'identifier': instance.identifier,
      'phone': instance.phone,
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
