import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/common.dart';

part 'supported_feature.freezed.dart';

part 'supported_feature.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
sealed class SupportedFeature with _$SupportedFeature {
  const factory SupportedFeature.themeMode({@Default(ThemeModeConfig.system) ThemeModeConfig mode}) =
      SupportedThemeMode;

  const factory SupportedFeature.videoCall({@Default(true) bool enabled}) = SupportedVideoCall;

  factory SupportedFeature.fromJson(Map<String, Object?> json) => _$SupportedFeatureFromJson(json);
}
