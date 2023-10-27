// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SystemInfo _$$_SystemInfoFromJson(Map<String, dynamic> json) =>
    _$_SystemInfo(
      core: CoreInfo.fromJson(json['core'] as Map<String, dynamic>),
      postgres: PostgresInfo.fromJson(json['postgres'] as Map<String, dynamic>),
      janus: json['janus'] == null
          ? null
          : JanusInfo.fromJson(json['janus'] as Map<String, dynamic>),
      gorush: json['gorush'] == null
          ? null
          : GorushInfo.fromJson(json['gorush'] as Map<String, dynamic>),
      adapter: json['adapter'] == null
          ? null
          : AdapterInfo.fromJson(json['adapter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SystemInfoToJson(_$_SystemInfo instance) =>
    <String, dynamic>{
      'core': instance.core,
      'postgres': instance.postgres,
      'janus': instance.janus,
      'gorush': instance.gorush,
      'adapter': instance.adapter,
    };

_$_PostgresInfo _$$_PostgresInfoFromJson(Map<String, dynamic> json) =>
    _$_PostgresInfo(
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$_PostgresInfoToJson(_$_PostgresInfo instance) =>
    <String, dynamic>{
      'version': instance.version,
    };

_$_JanusInfo _$$_JanusInfoFromJson(Map<String, dynamic> json) => _$_JanusInfo(
      plugins: json['plugins'] == null
          ? null
          : Plugins.fromJson(json['plugins'] as Map<String, dynamic>),
      transports: json['transports'] == null
          ? null
          : Transports.fromJson(json['transports'] as Map<String, dynamic>),
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$_JanusInfoToJson(_$_JanusInfo instance) =>
    <String, dynamic>{
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

_$_GorushInfo _$$_GorushInfoFromJson(Map<String, dynamic> json) =>
    _$_GorushInfo(
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$_GorushInfoToJson(_$_GorushInfo instance) =>
    <String, dynamic>{
      'version': instance.version,
    };

_$_CoreInfo _$$_CoreInfoFromJson(Map<String, dynamic> json) => _$_CoreInfo(
      version: const VersionConverter().fromJson(json['version'] as String),
    );

Map<String, dynamic> _$$_CoreInfoToJson(_$_CoreInfo instance) =>
    <String, dynamic>{
      'version': const VersionConverter().toJson(instance.version),
    };

_$_AdapterInfo _$$_AdapterInfoFromJson(Map<String, dynamic> json) =>
    _$_AdapterInfo(
      name: json['name'] as String?,
      version: json['version'] as String?,
      supported: (json['supported'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$LoginTypeEnumMap, e))
              .toList() ??
          const [LoginType.otpSignin],
      custom: json['custom'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_AdapterInfoToJson(_$_AdapterInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'supported':
          instance.supported.map((e) => _$LoginTypeEnumMap[e]!).toList(),
      'custom': instance.custom,
    };

const _$LoginTypeEnumMap = {
  LoginType.passwordSignin: 'passwordSignin',
  LoginType.recordings: 'recordings',
  LoginType.callHistory: 'callHistory',
  LoginType.otpSignin: 'otpSignin',
  LoginType.extensions: 'extensions',
  LoginType.signup: 'signup',
  LoginType.cta_list: 'cta_list',
};
