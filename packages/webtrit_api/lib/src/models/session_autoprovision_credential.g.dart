// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_autoprovision_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionAutoProvisionCredential _$SessionAutoProvisionCredentialFromJson(
  Map<String, dynamic> json,
) => SessionAutoProvisionCredential(
  bundleId: json['bundle_id'] as String?,
  type: $enumDecode(_$AppTypeEnumMap, json['type']),
  identifier: json['identifier'] as String,
  configToken: json['config_token'] as String,
);

Map<String, dynamic> _$SessionAutoProvisionCredentialToJson(
  SessionAutoProvisionCredential instance,
) => <String, dynamic>{
  'bundle_id': instance.bundleId,
  'type': _$AppTypeEnumMap[instance.type]!,
  'identifier': instance.identifier,
  'config_token': instance.configToken,
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
