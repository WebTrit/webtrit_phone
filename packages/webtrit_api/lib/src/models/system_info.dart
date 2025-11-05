import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

import 'converters/converters.dart';

part 'system_info.freezed.dart';

part 'system_info.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SystemInfo with _$SystemInfo {
  const SystemInfo(
      {required this.core,
      required this.postgres,
      this.adapter,
      this.janus,
      this.gorush});

  @override
  final CoreInfo core;

  @override
  final PostgresInfo postgres;

  @override
  final AdapterInfo? adapter;

  @override
  final JanusInfo? janus;

  @override
  final GorushInfo? gorush;

  factory SystemInfo.fromJson(Map<String, Object?> json) =>
      _$SystemInfoFromJson(json);

  Map<String, Object?> toJson() => _$SystemInfoToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CoreInfo with _$CoreInfo {
  const CoreInfo({@VersionConverter() required this.version});

  @override
  @VersionConverter()
  final Version version;

  factory CoreInfo.fromJson(Map<String, Object?> json) =>
      _$CoreInfoFromJson(json);

  Map<String, Object?> toJson() => _$CoreInfoToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PostgresInfo with _$PostgresInfo {
  const PostgresInfo({this.version});

  @override
  final String? version;

  factory PostgresInfo.fromJson(Map<String, Object?> json) =>
      _$PostgresInfoFromJson(json);

  Map<String, Object?> toJson() => _$PostgresInfoToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AdapterInfo with _$AdapterInfo {
  const AdapterInfo({this.name, this.version, this.supported, this.custom});

  @override
  final String? name;

  @override
  final String? version;

  @override
  final List<String>? supported;

  @override
  final Map<String, dynamic>? custom;

  factory AdapterInfo.fromJson(Map<String, Object?> json) =>
      _$AdapterInfoFromJson(json);

  Map<String, Object?> toJson() => _$AdapterInfoToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class JanusInfo with _$JanusInfo {
  const JanusInfo({this.plugins, this.transports, this.version});

  @override
  final Plugins? plugins;

  @override
  final Transports? transports;

  @override
  final String? version;

  factory JanusInfo.fromJson(Map<String, Object?> json) =>
      _$JanusInfoFromJson(json);

  Map<String, Object?> toJson() => _$JanusInfoToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class GorushInfo with _$GorushInfo {
  const GorushInfo({this.version});

  @override
  final String? version;

  factory GorushInfo.fromJson(Map<String, Object?> json) =>
      _$GorushInfoFromJson(json);

  Map<String, Object?> toJson() => _$GorushInfoToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Transports with _$Transports {
  const Transports({this.websocket});

  @override
  final Websocket? websocket;

  factory Transports.fromJson(Map<String, Object?> json) =>
      _$TransportsFromJson(json);

  Map<String, Object?> toJson() => _$TransportsToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Websocket with _$Websocket {
  const Websocket({this.version});

  @override
  final String? version;

  factory Websocket.fromJson(Map<String, Object?> json) =>
      _$WebsocketFromJson(json);

  Map<String, Object?> toJson() => _$WebsocketToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Plugins with _$Plugins {
  const Plugins({this.sip});

  @override
  final SipVersion? sip;

  factory Plugins.fromJson(Map<String, Object?> json) =>
      _$PluginsFromJson(json);

  Map<String, Object?> toJson() => _$PluginsToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SipVersion with _$SipVersion {
  const SipVersion({this.version});

  @override
  final String? version;

  factory SipVersion.fromJson(Map<String, Object?> json) =>
      _$SipVersionFromJson(json);

  Map<String, Object?> toJson() => _$SipVersionToJson(this);
}
