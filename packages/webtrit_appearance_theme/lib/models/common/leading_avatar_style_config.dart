import 'package:freezed_annotation/freezed_annotation.dart';

import 'icon_data_config.dart';
import 'text_style_config.dart';

part 'leading_avatar_style_config.freezed.dart';

part 'leading_avatar_style_config.g.dart';

/// Top-level style config for the LeadingAvatar widget.
/// All colors are hex strings (e.g., "#RRGGBB" or "#AARRGGBB").
/// Nulls mean "use theme defaults" (e.g., ColorScheme.secondaryContainer).
@freezed
class LeadingAvatarStyleConfig with _$LeadingAvatarStyleConfig {
  @JsonSerializable(explicitToJson: true)
  const factory LeadingAvatarStyleConfig({
    /// Circle background color. Defaults to theme.secondaryContainer when null.
    String? backgroundColor,

    /// Avatar radius (defaults to 20.0 in widget if null).
    double? radius,

    /// Text style for initials fallback.
    TextStyleConfig? initialsTextStyle,

    /// Placeholder icon when no username/thumbnail is available.
    IconDataConfig? placeholderIcon,

    /// Loading overlay appearance.
    LoadingOverlayStyleConfig? loading,

    /// "Smart" badge indicator appearance.
    SmartIndicatorStyleConfig? smartIndicator,

    /// Registered/unregistered badge appearance.
    RegisteredBadgeStyleConfig? registeredBadge,
  }) = _LeadingAvatarStyleConfig;

  factory LeadingAvatarStyleConfig.fromJson(Map<String, dynamic> json) => _$LeadingAvatarStyleConfigFromJson(json);
}

/// Loading overlay style shown while avatar data is unavailable.
@freezed
class LoadingOverlayStyleConfig with _$LoadingOverlayStyleConfig {
  const factory LoadingOverlayStyleConfig({
    /// Whether the overlay should be shown by default (widget may still override).
    @Default(false) bool showByDefault,

    /// Uniform padding around the progress indicator. Defaults to 2.0 in widget.
    double? paddingAll,

    /// CircularProgressIndicator stroke width (defaults to 1.0 in widget).
    double? strokeWidth,
  }) = _LoadingOverlayStyleConfig;

  factory LoadingOverlayStyleConfig.fromJson(Map<String, dynamic> json) => _$LoadingOverlayStyleConfigFromJson(json);
}

/// Appearance of the "smart" indicator (top-left small circle with icon).
@freezed
class SmartIndicatorStyleConfig with _$SmartIndicatorStyleConfig {
  const factory SmartIndicatorStyleConfig({
    /// Background color of the smart indicator circle.
    String? backgroundColor,

    /// Icon displayed inside the smart indicator.
    IconDataConfig? icon,

    /// Size factor relative to avatar diameter (widget uses ~0.4 by default).
    double? sizeFactor,
  }) = _SmartIndicatorStyleConfig;

  factory SmartIndicatorStyleConfig.fromJson(Map<String, dynamic> json) => _$SmartIndicatorStyleConfigFromJson(json);
}

/// Appearance of the registered/unregistered status badge (bottom-right).
@freezed
class RegisteredBadgeStyleConfig with _$RegisteredBadgeStyleConfig {
  const factory RegisteredBadgeStyleConfig({
    /// Color used when `registered == true`.
    String? registeredColor,

    /// Color used when `registered == false`.
    String? unregisteredColor,

    /// Size factor relative to avatar diameter (widget uses ~0.2 by default).
    double? sizeFactor,
  }) = _RegisteredBadgeStyleConfig;

  factory RegisteredBadgeStyleConfig.fromJson(Map<String, dynamic> json) => _$RegisteredBadgeStyleConfigFromJson(json);
}
