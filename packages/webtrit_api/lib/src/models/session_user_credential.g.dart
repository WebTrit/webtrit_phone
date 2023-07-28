// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_user_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SessionUserCredential _$$_SessionUserCredentialFromJson(
        Map<String, dynamic> json) =>
    _$_SessionUserCredential(
      bundleId: json['bundle_id'] as String?,
      type: $enumDecode(_$AppTypeEnumMap, json['type']),
      identifier: json['identifier'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_SessionUserCredentialToJson(
        _$_SessionUserCredential instance) =>
    <String, dynamic>{
      'bundle_id': instance.bundleId,
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
