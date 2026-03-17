import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/common.dart';

part 'supported_feature.freezed.dart';

part 'supported_feature.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
sealed class SupportedFeature with _$SupportedFeature {
  const factory SupportedFeature.themeMode({@Default(ThemeModeConfig.system) ThemeModeConfig mode}) =
      SupportedThemeMode;

  const factory SupportedFeature.videoCall({@Default(true) bool enabled}) = SupportedVideoCall;

  /// Configuration for logging and RTC monitoring.
  ///
  /// [logLevel] controls the application log level. Defaults to 'INFO'.
  /// [checkIntervalSec] defines how often the [RtpTrafficMonitor] checks for traffic.
  /// Defaults to 15 seconds.
  const factory SupportedFeature.loggingConfig({@Default('INFO') String logLevel, @Default(15) int checkIntervalSec}) =
      SupportedLoggingConfig;

  const factory SupportedFeature.systemNotifications({@Default(true) bool enabled}) = SupportedSystemNotifications;

  const factory SupportedFeature.hybridPresence({@Default(true) bool enabled}) = SupportedHybridPresence;

  factory SupportedFeature.fromJson(Map<String, Object?> json) => _$SupportedFeatureFromJson(json);
}
