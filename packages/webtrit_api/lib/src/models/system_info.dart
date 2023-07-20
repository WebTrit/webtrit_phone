import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

import 'converters/converters.dart';

part 'system_info.freezed.dart';

part 'system_info.g.dart';

@freezed
class SystemInfo with _$SystemInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SystemInfo({
    Adapter? adapter,
    Core? core,
    Gorush? gorush,
    Janus? janus,
    Postgres? postgres,
  }) = _SystemInfo;

  factory SystemInfo.fromJson(Map<String, Object?> json) => _$SystemInfoFromJson(json);
}

@freezed
class Postgres with _$Postgres {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Postgres({
    String? version,
  }) = _Postgres;

  factory Postgres.fromJson(Map<String, Object?> json) => _$PostgresFromJson(json);
}

@freezed
class Janus with _$Janus {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Janus({
    Plugins? plugins,
    Transports? transports,
    String? version,
  }) = _Janus;

  factory Janus.fromJson(Map<String, Object?> json) => _$JanusFromJson(json);
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
class Gorush with _$Gorush {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Gorush({
    String? version,
  }) = _Gorush;

  factory Gorush.fromJson(Map<String, Object?> json) => _$GorushFromJson(json);
}

@freezed
class Core with _$Core {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Core({
    @VersionConverter() required Version version,
  }) = _Core;

  factory Core.fromJson(Map<String, Object?> json) => _$CoreFromJson(json);
}

@freezed
class Adapter with _$Adapter {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Adapter({
    Custom? custom,
    String? name,
    List<String>? supported,
    String? version,
  }) = _Adapter;

  factory Adapter.fromJson(Map<String, Object?> json) => _$AdapterFromJson(json);
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
