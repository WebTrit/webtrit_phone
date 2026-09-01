import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/common.dart';

part 'supported_feature.freezed.dart';

part 'supported_feature.g.dart';

/// One entry of `AppConfig.supported`: a feature the deployment turns on, off,
/// or configures.
///
/// Written as a sealed base with a class per feature rather than as a freezed
/// union - see [PageBackground] for why. A new feature needs a redirecting
/// factory and a `fromJson` branch; the schema follows on its own.
sealed class SupportedFeature {
  const SupportedFeature();

  const factory SupportedFeature.themeMode({ThemeModeConfig mode, String type}) = SupportedThemeMode;

  const factory SupportedFeature.videoCall({bool enabled, String type}) = SupportedVideoCall;

  const factory SupportedFeature.loggingConfig({
    String logLevel,
    int checkIntervalSec,
    bool anonymizationEnabled,
    String type,
  }) = SupportedLoggingConfig;

  const factory SupportedFeature.systemNotifications({bool enabled, String type}) = SupportedSystemNotifications;

  const factory SupportedFeature.hybridPresence({bool enabled, String type}) = SupportedHybridPresence;

  const factory SupportedFeature.callPull({String videoStrategy, String type}) = SupportedCallPull;

  factory SupportedFeature.fromJson(Map<String, Object?> json) => switch (json['type']) {
    'themeMode' => SupportedThemeMode.fromJson(json),
    'videoCall' => SupportedVideoCall.fromJson(json),
    'loggingConfig' => SupportedLoggingConfig.fromJson(json),
    'systemNotifications' => SupportedSystemNotifications.fromJson(json),
    'hybridPresence' => SupportedHybridPresence.fromJson(json),
    'callPull' => SupportedCallPull.fromJson(json),
    final unknown => throw CheckedFromJsonException(json, 'type', 'SupportedFeature', 'Invalid union type "$unknown"!'),
  };

  Map<String, Object?> toJson();
}

/// Which theme mode the app starts in, and whether a person may change it.
@freezed
@JsonSerializable(explicitToJson: true, createJsonSchema: true)
class SupportedThemeMode extends SupportedFeature with _$SupportedThemeMode {
  const SupportedThemeMode({this.mode = ThemeModeConfig.system, this.type = 'themeMode'});

  @override
  final ThemeModeConfig mode;

  /// The discriminator. Always `themeMode`.
  @override
  final String type;

  factory SupportedThemeMode.fromJson(Map<String, Object?> json) => _$SupportedThemeModeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$SupportedThemeModeToJson(this);

  static const Map<String, Object?> jsonSchema = _$SupportedThemeModeJsonSchema;
}

/// Whether a call may carry video.
@freezed
@JsonSerializable(explicitToJson: true, createJsonSchema: true)
class SupportedVideoCall extends SupportedFeature with _$SupportedVideoCall {
  const SupportedVideoCall({this.enabled = true, this.type = 'videoCall'});

  @override
  final bool enabled;

  /// The discriminator. Always `videoCall`.
  @override
  final String type;

  factory SupportedVideoCall.fromJson(Map<String, Object?> json) => _$SupportedVideoCallFromJson(json);

  @override
  Map<String, Object?> toJson() => _$SupportedVideoCallToJson(this);

  static const Map<String, Object?> jsonSchema = _$SupportedVideoCallJsonSchema;
}

/// Logging and RTC monitoring.
@freezed
@JsonSerializable(explicitToJson: true, createJsonSchema: true)
class SupportedLoggingConfig extends SupportedFeature with _$SupportedLoggingConfig {
  const SupportedLoggingConfig({
    this.logLevel = 'INFO',
    this.checkIntervalSec = 15,
    this.anonymizationEnabled = true,
    this.type = 'loggingConfig',
  });

  /// The application log level.
  @override
  final String logLevel;

  /// How often the RTP traffic monitor checks for traffic, in seconds.
  @override
  final int checkIntervalSec;

  @override
  final bool anonymizationEnabled;

  /// The discriminator. Always `loggingConfig`.
  @override
  final String type;

  factory SupportedLoggingConfig.fromJson(Map<String, Object?> json) => _$SupportedLoggingConfigFromJson(json);

  @override
  Map<String, Object?> toJson() => _$SupportedLoggingConfigToJson(this);

  static const Map<String, Object?> jsonSchema = _$SupportedLoggingConfigJsonSchema;
}

/// Whether the app raises system notifications.
@freezed
@JsonSerializable(explicitToJson: true, createJsonSchema: true)
class SupportedSystemNotifications extends SupportedFeature with _$SupportedSystemNotifications {
  const SupportedSystemNotifications({this.enabled = true, this.type = 'systemNotifications'});

  @override
  final bool enabled;

  /// The discriminator. Always `systemNotifications`.
  @override
  final String type;

  factory SupportedSystemNotifications.fromJson(Map<String, Object?> json) =>
      _$SupportedSystemNotificationsFromJson(json);

  @override
  Map<String, Object?> toJson() => _$SupportedSystemNotificationsToJson(this);

  static const Map<String, Object?> jsonSchema = _$SupportedSystemNotificationsJsonSchema;
}

/// Whether presence is read from both the SIP line and the messaging service.
@freezed
@JsonSerializable(explicitToJson: true, createJsonSchema: true)
class SupportedHybridPresence extends SupportedFeature with _$SupportedHybridPresence {
  const SupportedHybridPresence({this.enabled = true, this.type = 'hybridPresence'});

  @override
  final bool enabled;

  /// The discriminator. Always `hybridPresence`.
  @override
  final String type;

  factory SupportedHybridPresence.fromJson(Map<String, Object?> json) => _$SupportedHybridPresenceFromJson(json);

  @override
  Map<String, Object?> toJson() => _$SupportedHybridPresenceToJson(this);

  static const Map<String, Object?> jsonSchema = _$SupportedHybridPresenceJsonSchema;
}

/// How the pull of a video call is handled.
@freezed
@JsonSerializable(explicitToJson: true, createJsonSchema: true)
class SupportedCallPull extends SupportedFeature with _$SupportedCallPull {
  const SupportedCallPull({this.videoStrategy = 'softMute', this.type = 'callPull'});

  /// Parsed by the app into a call-pull video strategy. `softMute` is the one
  /// that needs no backend; the others are `hideVideo` and `mirror`.
  @override
  final String videoStrategy;

  /// The discriminator. Always `callPull`.
  @override
  final String type;

  factory SupportedCallPull.fromJson(Map<String, Object?> json) => _$SupportedCallPullFromJson(json);

  @override
  Map<String, Object?> toJson() => _$SupportedCallPullToJson(this);

  static const Map<String, Object?> jsonSchema = _$SupportedCallPullJsonSchema;
}
