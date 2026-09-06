// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ice_servers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IceServersResponse _$IceServersResponseFromJson(Map<String, dynamic> json) =>
    IceServersResponse(
      iceServers:
          (json['ice_servers'] as List<dynamic>?)
              ?.map((e) => IceServer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ttl: (json['ttl'] as num?)?.toInt(),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$IceServersResponseToJson(IceServersResponse instance) =>
    <String, dynamic>{
      'ice_servers': instance.iceServers.map((e) => e.toJson()).toList(),
      'ttl': instance.ttl,
      'expires_at': instance.expiresAt?.toIso8601String(),
    };

IceServer _$IceServerFromJson(Map<String, dynamic> json) => IceServer(
  urls:
      (json['urls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  username: json['username'] as String?,
  credential: json['credential'] as String?,
);

Map<String, dynamic> _$IceServerToJson(IceServer instance) => <String, dynamic>{
  'urls': instance.urls,
  'username': instance.username,
  'credential': instance.credential,
};
