// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_otp_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionOtpCredentialImpl _$$SessionOtpCredentialImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionOtpCredentialImpl(
      bundleId: json['bundle_id'] as String?,
      type: $enumDecode(_$AppTypeEnumMap, json['type']),
      identifier: json['identifier'] as String,
      userRef: json['user_ref'] as String,
    );

Map<String, dynamic> _$$SessionOtpCredentialImplToJson(
        _$SessionOtpCredentialImpl instance) =>
    <String, dynamic>{
      'bundle_id': instance.bundleId,
      'type': _$AppTypeEnumMap[instance.type]!,
      'identifier': instance.identifier,
      'user_ref': instance.userRef,
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
