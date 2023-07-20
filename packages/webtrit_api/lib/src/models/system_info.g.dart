// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SystemInfo _$$_SystemInfoFromJson(Map<String, dynamic> json) =>
    _$_SystemInfo(
      adapter: json['adapter'] == null
          ? null
          : Adapter.fromJson(json['adapter'] as Map<String, dynamic>),
      core: json['core'] == null
          ? null
          : Core.fromJson(json['core'] as Map<String, dynamic>),
      gorush: json['gorush'] == null
          ? null
          : Gorush.fromJson(json['gorush'] as Map<String, dynamic>),
      janus: json['janus'] == null
          ? null
          : Janus.fromJson(json['janus'] as Map<String, dynamic>),
      postgres: json['postgres'] == null
          ? null
          : Postgres.fromJson(json['postgres'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SystemInfoToJson(_$_SystemInfo instance) =>
    <String, dynamic>{
      'adapter': instance.adapter,
      'core': instance.core,
      'gorush': instance.gorush,
      'janus': instance.janus,
      'postgres': instance.postgres,
    };

_$_Postgres _$$_PostgresFromJson(Map<String, dynamic> json) => _$_Postgres(
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$_PostgresToJson(_$_Postgres instance) =>
    <String, dynamic>{
      'version': instance.version,
    };

_$_Janus _$$_JanusFromJson(Map<String, dynamic> json) => _$_Janus(
      plugins: json['plugins'] == null
          ? null
          : Plugins.fromJson(json['plugins'] as Map<String, dynamic>),
      transports: json['transports'] == null
          ? null
          : Transports.fromJson(json['transports'] as Map<String, dynamic>),
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$_JanusToJson(_$_Janus instance) => <String, dynamic>{
      'plugins': instance.plugins,
      'transports': instance.transports,
      'version': instance.version,
    };

_$_Transports _$$_TransportsFromJson(Map<String, dynamic> json) =>
    _$_Transports(
      websocket: json['websocket'] == null
          ? null
          : Websocket.fromJson(json['websocket'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TransportsToJson(_$_Transports instance) =>
    <String, dynamic>{
      'websocket': instance.websocket,
    };

_$_Websocket _$$_WebsocketFromJson(Map<String, dynamic> json) => _$_Websocket(
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$_WebsocketToJson(_$_Websocket instance) =>
    <String, dynamic>{
      'version': instance.version,
    };

_$_Plugins _$$_PluginsFromJson(Map<String, dynamic> json) => _$_Plugins(
      sip: json['sip'] == null
          ? null
          : SipVersion.fromJson(json['sip'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PluginsToJson(_$_Plugins instance) =>
    <String, dynamic>{
      'sip': instance.sip,
    };

_$_SipVersion _$$_SipVersionFromJson(Map<String, dynamic> json) =>
    _$_SipVersion(
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$_SipVersionToJson(_$_SipVersion instance) =>
    <String, dynamic>{
      'version': instance.version,
    };

_$_Gorush _$$_GorushFromJson(Map<String, dynamic> json) => _$_Gorush(
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$_GorushToJson(_$_Gorush instance) => <String, dynamic>{
      'version': instance.version,
    };

_$_Core _$$_CoreFromJson(Map<String, dynamic> json) => _$_Core(
      version: const VersionConverter().fromJson(json['version'] as String),
    );

Map<String, dynamic> _$$_CoreToJson(_$_Core instance) => <String, dynamic>{
      'version': const VersionConverter().toJson(instance.version),
    };

_$_Adapter _$$_AdapterFromJson(Map<String, dynamic> json) => _$_Adapter(
      custom: json['custom'] == null
          ? null
          : Custom.fromJson(json['custom'] as Map<String, dynamic>),
      name: json['name'] as String?,
      supported: (json['supported'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$_AdapterToJson(_$_Adapter instance) =>
    <String, dynamic>{
      'custom': instance.custom,
      'name': instance.name,
      'supported': instance.supported,
      'version': instance.version,
    };

_$_Custom _$$_CustomFromJson(Map<String, dynamic> json) => _$_Custom(
      additionalProp1: json['additional_prop1'] as String?,
      additionalProp2: json['additional_prop2'] as String?,
      additionalProp3: json['additional_prop3'] as String?,
    );

Map<String, dynamic> _$$_CustomToJson(_$_Custom instance) => <String, dynamic>{
      'additional_prop1': instance.additionalProp1,
      'additional_prop2': instance.additionalProp2,
      'additional_prop3': instance.additionalProp3,
    };
