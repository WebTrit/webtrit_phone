// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_user_credential_number.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionUserCredentialNumberImpl _$$SessionUserCredentialNumberImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionUserCredentialNumberImpl(
      bundleId: json['bundle_id'] as String?,
      type: $enumDecode(_$AppTypeEnumMap, json['type']),
      identifier: json['identifier'] as String,
      phoneNumber: json['phone_number'] as String,
    );

Map<String, dynamic> _$$SessionUserCredentialNumberImplToJson(
        _$SessionUserCredentialNumberImpl instance) =>
    <String, dynamic>{
      'bundle_id': instance.bundleId,
      'type': _$AppTypeEnumMap[instance.type]!,
      'identifier': instance.identifier,
      'phone_number': instance.phoneNumber,
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
