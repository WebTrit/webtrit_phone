// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_action_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserActionCredential _$$_UserActionCredentialFromJson(
        Map<String, dynamic> json) =>
    _$_UserActionCredential(
      type: $enumDecode(_$AppTypeEnumMap, json['type']),
      identifier: json['identifier'] as String,
      email: json['email'] as String,
      tenantId: json['tenant_id'] as String,
      action: json['action'] as String,
    );

Map<String, dynamic> _$$_UserActionCredentialToJson(
        _$_UserActionCredential instance) =>
    <String, dynamic>{
      'type': _$AppTypeEnumMap[instance.type]!,
      'identifier': instance.identifier,
      'email': instance.email,
      'tenant_id': instance.tenantId,
      'action': instance.action,
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
