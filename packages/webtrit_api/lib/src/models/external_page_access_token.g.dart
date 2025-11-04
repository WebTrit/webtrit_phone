// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_page_access_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExternalPageAccessTokenImpl _$$ExternalPageAccessTokenImplFromJson(
  Map<String, dynamic> json,
) => _$ExternalPageAccessTokenImpl(
  accessToken: json['access_token'] as String,
  refreshToken: json['refresh_token'] as String,
  expiresAt: DateTime.parse(json['expires_at'] as String),
);

Map<String, dynamic> _$$ExternalPageAccessTokenImplToJson(
  _$ExternalPageAccessTokenImpl instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
  'expires_at': instance.expiresAt.toIso8601String(),
};
