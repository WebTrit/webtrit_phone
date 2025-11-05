// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemInfo _$SystemInfoFromJson(Map<String, dynamic> json) => SystemInfo(
  core: CoreInfo.fromJson(json['core'] as Map<String, dynamic>),
  postgres: PostgresInfo.fromJson(json['postgres'] as Map<String, dynamic>),
  adapter: json['adapter'] == null ? null : AdapterInfo.fromJson(json['adapter'] as Map<String, dynamic>),
  janus: json['janus'] == null ? null : JanusInfo.fromJson(json['janus'] as Map<String, dynamic>),
  gorush: json['gorush'] == null ? null : GorushInfo.fromJson(json['gorush'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SystemInfoToJson(SystemInfo instance) => <String, dynamic>{
  'core': instance.core.toJson(),
  'postgres': instance.postgres.toJson(),
  'adapter': instance.adapter?.toJson(),
  'janus': instance.janus?.toJson(),
  'gorush': instance.gorush?.toJson(),
};

CoreInfo _$CoreInfoFromJson(Map<String, dynamic> json) =>
    CoreInfo(version: const VersionConverter().fromJson(json['version'] as String));

Map<String, dynamic> _$CoreInfoToJson(CoreInfo instance) => <String, dynamic>{
  'version': const VersionConverter().toJson(instance.version),
};

PostgresInfo _$PostgresInfoFromJson(Map<String, dynamic> json) => PostgresInfo(version: json['version'] as String?);

Map<String, dynamic> _$PostgresInfoToJson(PostgresInfo instance) => <String, dynamic>{'version': instance.version};

AdapterInfo _$AdapterInfoFromJson(Map<String, dynamic> json) => AdapterInfo(
  name: json['name'] as String?,
  version: json['version'] as String?,
  supported: (json['supported'] as List<dynamic>?)?.map((e) => e as String).toList(),
  custom: json['custom'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AdapterInfoToJson(AdapterInfo instance) => <String, dynamic>{
  'name': instance.name,
  'version': instance.version,
  'supported': instance.supported,
  'custom': instance.custom,
};

JanusInfo _$JanusInfoFromJson(Map<String, dynamic> json) => JanusInfo(
  plugins: json['plugins'] == null ? null : Plugins.fromJson(json['plugins'] as Map<String, dynamic>),
  transports: json['transports'] == null ? null : Transports.fromJson(json['transports'] as Map<String, dynamic>),
  version: json['version'] as String?,
);

Map<String, dynamic> _$JanusInfoToJson(JanusInfo instance) => <String, dynamic>{
  'plugins': instance.plugins?.toJson(),
  'transports': instance.transports?.toJson(),
  'version': instance.version,
};

GorushInfo _$GorushInfoFromJson(Map<String, dynamic> json) => GorushInfo(version: json['version'] as String?);

Map<String, dynamic> _$GorushInfoToJson(GorushInfo instance) => <String, dynamic>{'version': instance.version};

Transports _$TransportsFromJson(Map<String, dynamic> json) => Transports(
  websocket: json['websocket'] == null ? null : Websocket.fromJson(json['websocket'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TransportsToJson(Transports instance) => <String, dynamic>{
  'websocket': instance.websocket?.toJson(),
};

Websocket _$WebsocketFromJson(Map<String, dynamic> json) => Websocket(version: json['version'] as String?);

Map<String, dynamic> _$WebsocketToJson(Websocket instance) => <String, dynamic>{'version': instance.version};

Plugins _$PluginsFromJson(Map<String, dynamic> json) =>
    Plugins(sip: json['sip'] == null ? null : SipVersion.fromJson(json['sip'] as Map<String, dynamic>));

Map<String, dynamic> _$PluginsToJson(Plugins instance) => <String, dynamic>{'sip': instance.sip?.toJson()};

SipVersion _$SipVersionFromJson(Map<String, dynamic> json) => SipVersion(version: json['version'] as String?);

Map<String, dynamic> _$SipVersionToJson(SipVersion instance) => <String, dynamic>{'version': instance.version};
