// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserActionDataImpl _$$UserActionDataImplFromJson(Map<String, dynamic> json) =>
    _$UserActionDataImpl(
      status: json['status'] as String?,
      message: json['message'] as String?,
      tenantId: json['tenant_id'] as String?,
      userId: json['user_id'] as String?,
      convertPbxUrl: json['convert_pbx_url'] as String?,
      apiToken: json['api_token'] as String?,
      tokenExpires: json['token_expires'] as String?,
      inviteFriendsUrl: json['invite_friends_url'] as String?,
    );

Map<String, dynamic> _$$UserActionDataImplToJson(
        _$UserActionDataImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'tenant_id': instance.tenantId,
      'user_id': instance.userId,
      'convert_pbx_url': instance.convertPbxUrl,
      'api_token': instance.apiToken,
      'token_expires': instance.tokenExpires,
      'invite_friends_url': instance.inviteFriendsUrl,
    };
