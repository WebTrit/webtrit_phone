// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SystemInfoImpl _$$SystemInfoImplFromJson(Map<String, dynamic> json) =>
    _$SystemInfoImpl(
      core: CoreInfo.fromJson(json['core'] as Map<String, dynamic>),
      postgres: PostgresInfo.fromJson(json['postgres'] as Map<String, dynamic>),
      adapter: json['adapter'] == null
          ? null
          : AdapterInfo.fromJson(json['adapter'] as Map<String, dynamic>),
      janus: json['janus'] == null
          ? null
          : JanusInfo.fromJson(json['janus'] as Map<String, dynamic>),
      gorush: json['gorush'] == null
          ? null
          : GorushInfo.fromJson(json['gorush'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SystemInfoImplToJson(_$SystemInfoImpl instance) =>
    <String, dynamic>{
      'core': instance.core,
      'postgres': instance.postgres,
      'adapter': instance.adapter,
      'janus': instance.janus,
      'gorush': instance.gorush,
    };

_$CoreInfoImpl _$$CoreInfoImplFromJson(Map<String, dynamic> json) =>
    _$CoreInfoImpl(
      version: const VersionConverter().fromJson(json['version'] as String),
    );

Map<String, dynamic> _$$CoreInfoImplToJson(_$CoreInfoImpl instance) =>
    <String, dynamic>{
      'version': const VersionConverter().toJson(instance.version),
    };

_$PostgresInfoImpl _$$PostgresInfoImplFromJson(Map<String, dynamic> json) =>
    _$PostgresInfoImpl(
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$PostgresInfoImplToJson(_$PostgresInfoImpl instance) =>
    <String, dynamic>{
      'version': instance.version,
    };

_$AdapterInfoImpl _$$AdapterInfoImplFromJson(Map<String, dynamic> json) =>
    _$AdapterInfoImpl(
      name: json['name'] as String?,
      version: json['version'] as String?,
      supported: (json['supported'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      custom: json['custom'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AdapterInfoImplToJson(_$AdapterInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'supported': instance.supported,
      'custom': instance.custom,
    };

_$JanusInfoImpl _$$JanusInfoImplFromJson(Map<String, dynamic> json) =>
    _$JanusInfoImpl(
      plugins: json['plugins'] == null
          ? null
          : Plugins.fromJson(json['plugins'] as Map<String, dynamic>),
      transports: json['transports'] == null
          ? null
          : Transports.fromJson(json['transports'] as Map<String, dynamic>),
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$JanusInfoImplToJson(_$JanusInfoImpl instance) =>
    <String, dynamic>{
      'plugins': instance.plugins,
      'transports': instance.transports,
      'version': instance.version,
    };

_$GorushInfoImpl _$$GorushInfoImplFromJson(Map<String, dynamic> json) =>
    _$GorushInfoImpl(
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$GorushInfoImplToJson(_$GorushInfoImpl instance) =>
    <String, dynamic>{
      'version': instance.version,
    };

_$TransportsImpl _$$TransportsImplFromJson(Map<String, dynamic> json) =>
    _$TransportsImpl(
      websocket: json['websocket'] == null
          ? null
          : Websocket.fromJson(json['websocket'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TransportsImplToJson(_$TransportsImpl instance) =>
    <String, dynamic>{
      'websocket': instance.websocket,
    };

_$WebsocketImpl _$$WebsocketImplFromJson(Map<String, dynamic> json) =>
    _$WebsocketImpl(
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$WebsocketImplToJson(_$WebsocketImpl instance) =>
    <String, dynamic>{
      'version': instance.version,
    };

_$PluginsImpl _$$PluginsImplFromJson(Map<String, dynamic> json) =>
    _$PluginsImpl(
      sip: json['sip'] == null
          ? null
          : SipVersion.fromJson(json['sip'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PluginsImplToJson(_$PluginsImpl instance) =>
    <String, dynamic>{
      'sip': instance.sip,
    };

_$SipVersionImpl _$$SipVersionImplFromJson(Map<String, dynamic> json) =>
    _$SipVersionImpl(
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$SipVersionImplToJson(_$SipVersionImpl instance) =>
    <String, dynamic>{
      'version': instance.version,
    };
