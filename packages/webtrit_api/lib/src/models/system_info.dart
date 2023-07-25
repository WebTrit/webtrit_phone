import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

import 'converters/converters.dart';

part 'system_info.freezed.dart';

part 'system_info.g.dart';

@freezed
class SystemInfo with _$SystemInfo {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SystemInfo({
    required CoreInfo core,
    required PostgresInfo postgres,
    JanusInfo? janus,
    GorushInfo? gorush,
    AdapterInfo? adapter,
  }) = _SystemInfo;

  factory SystemInfo.fromJson(Map<String, Object?> json) => _$SystemInfoFromJson(json);
}

@freezed
class PostgresInfo with _$PostgresInfo {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PostgresInfo({
    @VersionConverter() Version? version,
  }) = _PostgresInfo;

  factory PostgresInfo.fromJson(Map<String, Object?> json) => _$PostgresInfoFromJson(json);
}

@freezed
class JanusInfo with _$JanusInfo {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory JanusInfo({
    Plugins? plugins,
    Transports? transports,
    @VersionConverter() Version? version,
  }) = _JanusInfo;

  factory JanusInfo.fromJson(Map<String, Object?> json) => _$JanusInfoFromJson(json);
}

@freezed
class Transports with _$Transports {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Transports({
    Websocket? websocket,
  }) = _Transports;

  factory Transports.fromJson(Map<String, Object?> json) => _$TransportsFromJson(json);
}

@freezed
class Websocket with _$Websocket {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Websocket({
    @VersionConverter() Version? version,
  }) = _Websocket;

  factory Websocket.fromJson(Map<String, Object?> json) => _$WebsocketFromJson(json);
}

@freezed
class Plugins with _$Plugins {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Plugins({
    SipVersion? sip,
  }) = _Plugins;

  factory Plugins.fromJson(Map<String, Object?> json) => _$PluginsFromJson(json);
}

@freezed
class SipVersion with _$SipVersion {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SipVersion({
    @VersionConverter() Version? version,
  }) = _SipVersion;

  factory SipVersion.fromJson(Map<String, Object?> json) => _$SipVersionFromJson(json);
}

@freezed
class GorushInfo with _$GorushInfo {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GorushInfo({
    @VersionConverter() Version? version,
  }) = _GorushInfo;

  factory GorushInfo.fromJson(Map<String, Object?> json) => _$GorushInfoFromJson(json);
}

@freezed
class CoreInfo with _$CoreInfo {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CoreInfo({
    @VersionConverter() required Version version,
  }) = _CoreInfo;

  factory CoreInfo.fromJson(Map<String, Object?> json) => _$CoreInfoFromJson(json);
}

@freezed
class AdapterInfo with _$AdapterInfo {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AdapterInfo({
    Map<String, dynamic>? custom,
    String? name,
    List<String>? supported,
    @VersionConverter() Version? version,
  }) = _AdapterInfo;

  factory AdapterInfo.fromJson(Map<String, Object?> json) => _$AdapterInfoFromJson(json);
}
