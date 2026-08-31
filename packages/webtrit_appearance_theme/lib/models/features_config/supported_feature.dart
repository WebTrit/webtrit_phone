import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/common.dart';

part 'supported_feature.freezed.dart';

part 'supported_feature.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
sealed class SupportedFeature with _$SupportedFeature {
  /// The discriminator, declared rather than left to freezed.
  ///
  /// Freezed writes a `$type` of its own and puts the value in the
  /// constructor's initialiser list, where the schema generator cannot see it:
  /// the parameter default it reads is `null`. Declared here it is an ordinary
  /// field with an ordinary default, so the generated schema states
  /// `{'type': 'string', 'default': 'solid'}` and no hand-written map has to
  /// repeat it.
  ///
  /// The wire is unchanged - the key is the union key, and freezed drops its
  /// own `$type` for a variant that declares one. What it costs is a parameter
  /// on every `when` and `map` callback, which is spelt `_` because inside a
  /// branch the value is the branch.
  const factory SupportedFeature.themeMode({
    @Default(ThemeModeConfig.system) ThemeModeConfig mode,
    @Default('themeMode') String type,
  }) =
      SupportedThemeMode;

  const factory SupportedFeature.videoCall({@Default(true) bool enabled, @Default('videoCall') String type}) =
      SupportedVideoCall;

  /// Configuration for logging and RTC monitoring.
  ///
  /// [logLevel] controls the application log level. Defaults to 'INFO'.
  /// [checkIntervalSec] defines how often the [RtpTrafficMonitor] checks for traffic.
  /// Defaults to 15 seconds.
  const factory SupportedFeature.loggingConfig({
    @Default('INFO') String logLevel,
    @Default(15) int checkIntervalSec,
    @Default(true) bool anonymizationEnabled,
    @Default('loggingConfig') String type,
  }) = SupportedLoggingConfig;

  const factory SupportedFeature.systemNotifications({
    @Default(true) bool enabled,
    @Default('systemNotifications') String type,
  }) = SupportedSystemNotifications;

  const factory SupportedFeature.hybridPresence({
    @Default(true) bool enabled,
    @Default('hybridPresence') String type,
  }) = SupportedHybridPresence;

  /// Call Pull video handling. [videoStrategy] selects how the pull of a video
  /// call is handled; parsed by the app into a CallPullVideoStrategy. Defaults to
  /// 'softMute' (the no-backend strategy). Other values: 'hideVideo', 'mirror'.
  const factory SupportedFeature.callPull({
    @Default('softMute') String videoStrategy,
    @Default('callPull') String type,
  }) = SupportedCallPull;

  factory SupportedFeature.fromJson(Map<String, Object?> json) => _$SupportedFeatureFromJson(json);
}
