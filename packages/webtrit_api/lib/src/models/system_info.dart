import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

import 'converters/converters.dart';

part 'system_info.freezed.dart';

part 'system_info.g.dart';

@freezed
class SystemInfo with _$SystemInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SystemInfo({
    AdapterInfo? adapter,
    CoreInfo? core,
    GorushInfo? gorush,
    JanusInfo? janus,
    PostgresInfo? postgres,
  }) = _SystemInfo;

  factory SystemInfo.fromJson(Map<String, Object?> json) => _$SystemInfoFromJson(json);
}

@freezed
class PostgresInfo with _$PostgresInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PostgresInfo({
    String? version,
  }) = _PostgresInfo;

  factory PostgresInfo.fromJson(Map<String, Object?> json) => _$PostgresInfoFromJson(json);
}

@freezed
class JanusInfo with _$JanusInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory JanusInfo({
    Plugins? plugins,
    Transports? transports,
    String? version,
  }) = _JanusInfo;

  factory JanusInfo.fromJson(Map<String, Object?> json) => _$JanusInfoFromJson(json);
}

@freezed
class Transports with _$Transports {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Transports({
    Websocket? websocket,
  }) = _Transports;

  factory Transports.fromJson(Map<String, Object?> json) => _$TransportsFromJson(json);
}

@freezed
class Websocket with _$Websocket {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Websocket({
    String? version,
  }) = _Websocket;

  factory Websocket.fromJson(Map<String, Object?> json) => _$WebsocketFromJson(json);
}

@freezed
class Plugins with _$Plugins {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Plugins({
    SipVersion? sip,
  }) = _Plugins;

  factory Plugins.fromJson(Map<String, Object?> json) => _$PluginsFromJson(json);
}

@freezed
class SipVersion with _$SipVersion {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SipVersion({
    String? version,
  }) = _SipVersion;

  factory SipVersion.fromJson(Map<String, Object?> json) => _$SipVersionFromJson(json);
}

@freezed
class GorushInfo with _$GorushInfo{
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GorushInfo({
    String? version,
  }) = _GorushInfo;

  factory GorushInfo.fromJson(Map<String, Object?> json) => _$GorushInfoFromJson(json);
}

@freezed
class CoreInfo with _$CoreInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CoreInfo({
    @VersionConverter() required Version version,
  }) = _CoreInfo;

  factory CoreInfo.fromJson(Map<String, Object?> json) => _$CoreInfoFromJson(json);
}

@freezed
class AdapterInfo with _$AdapterInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AdapterInfo({
    Custom? custom,
    String? name,
    List<String>? supported,
    String? version,
  }) = _AdapterInfo;

  factory AdapterInfo.fromJson(Map<String, Object?> json) => _$AdapterInfoFromJson(json);
}

@freezed
class Custom with _$Custom {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Custom({
    String? additionalProp1,
    String? additionalProp2,
    String? additionalProp3,
  }) = _Custom;

  factory Custom.fromJson(Map<String, Object?> json) => _$CustomFromJson(json);
}
