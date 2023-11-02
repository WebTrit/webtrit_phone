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
    String? version,
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
    String? version,
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
    String? version,
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
    String? version,
  }) = _SipVersion;

  factory SipVersion.fromJson(Map<String, Object?> json) => _$SipVersionFromJson(json);
}

@freezed
class GorushInfo with _$GorushInfo {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GorushInfo({
    String? version,
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
  const AdapterInfo._();

  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AdapterInfo({
    String? name,
    String? version,
    @Default([]) List<RawLoginType> supported,
    Map<String, dynamic>? custom,
  }) = _AdapterInfo;

  factory AdapterInfo.fromJson(Map<String, Object?> json) => _$AdapterInfoFromJson(json);

  List<SupportedLoginType> get commonSupported {
    final commonSupportedList = supported
        .map((type) {
          switch (type) {
            case RawLoginType.passwordSignin:
              return SupportedLoginType.passwordSignIn;
            case RawLoginType.otpSignin:
              return SupportedLoginType.otpSignIn;
            default:
              return null;
          }
        })
        .nonNulls
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return commonSupportedList;
  }
}

enum RawLoginType {
  passwordSignin,
  recordings,
  callHistory,
  otpSignin,
  extensions,
  signup,
  // ignore: constant_identifier_names
  cta_list;
}

enum SupportedLoginType {
  otpSignIn,
  passwordSignIn,
}
