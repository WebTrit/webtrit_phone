import 'package:freezed_annotation/freezed_annotation.dart';

part 'color_scheme.config.freezed.dart';

part 'color_scheme.config.g.dart';

@Freezed()
class ColorSchemeConfig with _$ColorSchemeConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ColorSchemeConfig({
    @Default('#F95A14') String seedColor,
    @Default(ColorSchemeOverride()) ColorSchemeOverride colorSchemeOverride,
  }) = _ColorSchemeConfig;

  factory ColorSchemeConfig.fromJson(Map<String, dynamic> json) => _$ColorSchemeConfigFromJson(json);
}

@Freezed()
class ColorSchemeOverride with _$ColorSchemeOverride {
  @JsonSerializable(explicitToJson: true)
  const factory ColorSchemeOverride({
    @Default('#5CACE3') String primary,
    @Default('#FFFFFF') String onPrimary,
    @Default('#B9E3F9') String primaryContainer,
    @Default('#123752') String onPrimaryContainer,
    @Default('#A5C6E4') String primaryFixed,
    @Default('#75A1C5') String primaryFixedDim,
    @Default('#092D4A') String onPrimaryFixed,
    @Default('#A5C6E4') String onPrimaryFixedVariant,
    @Default('#123752') String secondary,
    @Default('#FFFFFF') String onSecondary,
    @Default('#EEF3F6') String secondaryContainer,
    @Default('#1F618F') String onSecondaryContainer,
    @Default('#848581') String secondaryFixed,
    @Default('#4C4D4A') String secondaryFixedDim,
    @Default('#30302F') String onSecondaryFixed,
    @Default('#848581') String onSecondaryFixedVariant,
    @Default('#75B943') String tertiary,
    @Default('#FFFFFF') String onTertiary,
    @Default('#E1F7C1') String tertiaryContainer,
    @Default('#2E5200') String onTertiaryContainer,
    @Default('#B8E078') String tertiaryFixed,
    @Default('#8CC14E') String tertiaryFixedDim,
    @Default('#224400') String onTertiaryFixed,
    @Default('#B8E078') String onTertiaryFixedVariant,
    @Default('#E74C3C') String error,
    @Default('#FFFFFF') String onError,
    @Default('#F5B7B1') String errorContainer,
    @Default('#8B1E13') String onErrorContainer,
    @Default('#4C4D4A') String outline,
    @Default('#CDCFC9') String outlineVariant,
    @Default('#EEF3F6') String surface,
    @Default('#30302F') String onSurface,
    @Default('#DDE0E3') String surfaceDim,
    @Default('#FFFFFF') String surfaceBright,
    @Default('#F8FBFD') String surfaceContainerLowest,
    @Default('#F0F3F5') String surfaceContainerLow,
    @Default('#EEF3F6') String surfaceContainer,
    @Default('#E2E6E9') String surfaceContainerHigh,
    @Default('#DDE0E3') String surfaceContainerHighest,
    @Default('#848581') String onSurfaceVariant,
    @Default('#30302F') String inverseSurface,
    @Default('#EEF3F6') String onInverseSurface,
    @Default('#1F618F') String inversePrimary,
    @Default('#000000') String shadow,
    @Default('#000000') String scrim,
    @Default('#F95A14') String surfaceTint,
  }) = _ColorSchemeOverride;

  factory ColorSchemeOverride.fromJson(Map<String, dynamic> json) => _$ColorSchemeOverrideFromJson(json);
}
