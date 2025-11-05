import 'package:freezed_annotation/freezed_annotation.dart';

import 'icon_data_config.dart';
import 'padding_config.dart';
import 'text_style_config.dart';

part 'leading_avatar_style_config.freezed.dart';

part 'leading_avatar_style_config.g.dart';

/// Top-level style config for the LeadingAvatar widget.
/// All colors are hex strings (e.g., "#RRGGBB" or "#AARRGGBB").
/// Nulls mean "use theme defaults" (e.g., ColorScheme.secondaryContainer).
@freezed
@JsonSerializable(explicitToJson: true)
class LeadingAvatarStyleConfig with _$LeadingAvatarStyleConfig {
  /// Creates a [LeadingAvatarStyleConfig].
  const LeadingAvatarStyleConfig({
    /// Circle background color. Defaults to theme.secondaryContainer when null.
    this.backgroundColor,

    /// Avatar radius (defaults to 20.0 in widget if null).
    this.radius,

    /// Text style for initials fallback.
    this.initialsTextStyle,

    /// Placeholder icon when no username/thumbnail is available.
    this.placeholderIcon,

    /// Loading overlay appearance.
    this.loading,

    /// "Smart" badge indicator appearance.
    this.smartIndicator,

    /// Registered/unregistered badge appearance.
    this.registeredBadge,

    /// Presence badge appearance.
    this.presenceBadge,
  });

  /// Circle background color. Defaults to theme.secondaryContainer when null.
  @override
  final String? backgroundColor;

  /// Avatar radius (defaults to 20.0 in widget if null).
  @override
  final double? radius;

  /// Text style for initials fallback.
  @override
  final TextStyleConfig? initialsTextStyle;

  /// Placeholder icon when no username/thumbnail is available.
  @override
  final IconDataConfig? placeholderIcon;

  /// Loading overlay appearance.
  @override
  final LoadingOverlayStyleConfig? loading;

  /// "Smart" badge indicator appearance.
  @override
  final SmartIndicatorStyleConfig? smartIndicator;

  /// Registered/unregistered badge appearance.
  @override
  final RegisteredBadgeStyleConfig? registeredBadge;

  /// Presence badge appearance.
  @override
  final PresenceBadgeStyleConfig? presenceBadge;

  factory LeadingAvatarStyleConfig.fromJson(Map<String, Object?> json) =>
      _$LeadingAvatarStyleConfigFromJson(json);

  Map<String, Object?> toJson() => _$LeadingAvatarStyleConfigToJson(this);
}

/// Loading overlay style shown while avatar data is unavailable.
@freezed
@JsonSerializable()
class LoadingOverlayStyleConfig with _$LoadingOverlayStyleConfig {
  /// Creates a [LoadingOverlayStyleConfig].
  const LoadingOverlayStyleConfig({
    /// Whether the overlay should be shown by default (widget may still override).
    this.showByDefault = false,

    /// Padding around the loading indicator.
    this.padding = PaddingConfig.default2,

    /// CircularProgressIndicator stroke width (defaults to 1.0 in widget).
    this.strokeWidth,
  });

  /// Whether the overlay should be shown by default (widget may still override).
  @override
  final bool showByDefault;

  /// Padding around the loading indicator.
  @override
  final PaddingConfig padding;

  /// CircularProgressIndicator stroke width (defaults to 1.0 in widget).
  @override
  final double? strokeWidth;

  factory LoadingOverlayStyleConfig.fromJson(Map<String, Object?> json) =>
      _$LoadingOverlayStyleConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoadingOverlayStyleConfigToJson(this);
}

/// Appearance of the "smart" indicator (top-left small circle with icon).
@freezed
@JsonSerializable()
class SmartIndicatorStyleConfig with _$SmartIndicatorStyleConfig {
  /// Creates a [SmartIndicatorStyleConfig].
  const SmartIndicatorStyleConfig({
    /// Background color of the smart indicator circle.
    this.backgroundColor,

    /// Icon displayed inside the smart indicator.
    this.icon,

    /// Size factor relative to avatar diameter (widget uses ~0.4 by default).
    this.sizeFactor,
  });

  /// Background color of the smart indicator circle.
  @override
  final String? backgroundColor;

  /// Icon displayed inside the smart indicator.
  @override
  final IconDataConfig? icon;

  /// Size factor relative to avatar diameter (widget uses ~0.4 by default).
  @override
  final double? sizeFactor;

  factory SmartIndicatorStyleConfig.fromJson(Map<String, Object?> json) =>
      _$SmartIndicatorStyleConfigFromJson(json);

  Map<String, Object?> toJson() => _$SmartIndicatorStyleConfigToJson(this);
}

/// Appearance of the registered/unregistered status badge (bottom-right).
@freezed
@JsonSerializable()
class RegisteredBadgeStyleConfig with _$RegisteredBadgeStyleConfig {
  /// Creates a [RegisteredBadgeStyleConfig].
  const RegisteredBadgeStyleConfig({
    /// Color used when `registered == true`.
    this.registeredColor,

    /// Color used when `registered == false`.
    this.unregisteredColor,

    /// Size factor relative to avatar diameter (widget uses ~0.2 by default).
    this.sizeFactor,
  });

  /// Color used when `registered == true`.
  @override
  final String? registeredColor;

  /// Color used when `registered == false`.
  @override
  final String? unregisteredColor;

  /// Size factor relative to avatar diameter (widget uses ~0.2 by default).
  @override
  final double? sizeFactor;

  factory RegisteredBadgeStyleConfig.fromJson(Map<String, Object?> json) =>
      _$RegisteredBadgeStyleConfigFromJson(json);

  Map<String, Object?> toJson() => _$RegisteredBadgeStyleConfigToJson(this);
}

/// Appearance of the presence status badge (bottom-right).
@freezed
@JsonSerializable()
class PresenceBadgeStyleConfig with _$PresenceBadgeStyleConfig {
  /// Creates a [PresenceBadgeStyleConfig].
  const PresenceBadgeStyleConfig({
    /// Color used when presence is "available" (e.g., online, idle).
    this.availableColor,

    /// Color used when presence is "unavailable" (e.g., offline, busy).
    this.unavailableColor,

    /// Size factor relative to avatar diameter (widget uses ~0.325 by default).
    this.sizeFactor,
  });

  /// Color used when presence is "available" (e.g., online, idle).
  @override
  final String? availableColor;

  /// Color used when presence is "unavailable" (e.g., offline, busy).
  @override
  final String? unavailableColor;

  /// Size factor relative to avatar diameter (widget uses ~0.325 by default).
  @override
  final double? sizeFactor;

  factory PresenceBadgeStyleConfig.fromJson(Map<String, Object?> json) =>
      _$PresenceBadgeStyleConfigFromJson(json);

  Map<String, Object?> toJson() => _$PresenceBadgeStyleConfigToJson(this);
}
