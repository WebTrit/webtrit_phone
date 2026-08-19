import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'presence_badge_style.dart';
import 'registered_badge_style.dart';
import 'smart_indicator_style.dart';

class LeadingAvatarStyle with Diagnosticable {
  const LeadingAvatarStyle({
    this.backgroundColor,
    this.radius,
    this.initialsTextStyle,
    this.placeholderIcon,
    this.loadingOverlay,
    this.smartIndicator,
    this.registeredBadge,
    this.presenceBadge,
    this.nameColors,
  });

  /// Circle background; falls back to ColorScheme.secondaryContainer when null.
  final Color? backgroundColor;

  /// Avatar radius (widget default is 20.0 when null).
  final double? radius;

  /// Text style for initials when no image is available.
  final TextStyle? initialsTextStyle;

  /// Placeholder icon if no username/thumbnail; optional.
  final IconData? placeholderIcon;

  /// Loading overlay appearance.
  final LoadingOverlayStyle? loadingOverlay;

  /// “Smart” indicator appearance (top-left).
  final SmartIndicatorStyle? smartIndicator;

  /// Registered/unregistered badge (bottom-right).
  final RegisteredBadgeStyle? registeredBadge;

  /// Presence badge (bottom-right).
  final PresenceBadgeStyle? presenceBadge;

  /// Pseudorandom, name-derived background/initials colors.
  final NameColorsStyle? nameColors;

  /// The app's own appearance for the avatar and its overlays.
  ///
  /// This is the single place these values live: a theme names only what it
  /// wants different, and everything it leaves out comes from here, so a new
  /// app build carries new appearance to every deployment that did not opt out.
  static LeadingAvatarStyle defaults(ColorScheme colors) {
    return LeadingAvatarStyle(
      backgroundColor: colors.secondaryContainer,
      radius: 20,
      initialsTextStyle: TextStyle(color: colors.onSecondaryContainer),
      loadingOverlay: const LoadingOverlayStyle(padding: EdgeInsets.zero, strokeWidth: 1),
      smartIndicator: SmartIndicatorStyle(
        backgroundColor: colors.surfaceContainerLowest,
        icon: Icons.person,
        sizeFactor: 0.4,
      ),
      // The dot's colors keep coming from RegisteredStatusStyles.
      registeredBadge: const RegisteredBadgeStyle(sizeFactor: 0.2),
      presenceBadge: PresenceBadgeStyle(
        availableColor: colors.tertiary,
        unavailableColor: colors.onSurfaceVariant,
        iconColor: colors.surface,
        sizeFactor: 0.5,
      ),
      nameColors: const NameColorsStyle(),
    );
  }

  static LeadingAvatarStyle merge(LeadingAvatarStyle? base, LeadingAvatarStyle? override) {
    if (base == null && override == null) return const LeadingAvatarStyle();
    base ??= const LeadingAvatarStyle();
    override ??= const LeadingAvatarStyle();

    return LeadingAvatarStyle(
      backgroundColor: override.backgroundColor ?? base.backgroundColor,
      radius: override.radius ?? base.radius,
      initialsTextStyle:
          base.initialsTextStyle?.merge(override.initialsTextStyle) ??
          override.initialsTextStyle ??
          base.initialsTextStyle,
      placeholderIcon: override.placeholderIcon ?? base.placeholderIcon,
      loadingOverlay: LoadingOverlayStyle.merge(base.loadingOverlay, override.loadingOverlay),
      smartIndicator: SmartIndicatorStyle.merge(base.smartIndicator, override.smartIndicator),
      registeredBadge: RegisteredBadgeStyle.merge(base.registeredBadge, override.registeredBadge),
      presenceBadge: PresenceBadgeStyle.merge(base.presenceBadge, override.presenceBadge),
      nameColors: NameColorsStyle.merge(base.nameColors, override.nameColors),
    );
  }

  static LeadingAvatarStyle? lerp(LeadingAvatarStyle? a, LeadingAvatarStyle? b, double t) {
    if (identical(a, b)) return a;
    if (a == null && b == null) return null;

    return LeadingAvatarStyle(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      radius: lerpDouble(a?.radius, b?.radius, t),
      initialsTextStyle: TextStyle.lerp(a?.initialsTextStyle, b?.initialsTextStyle, t),
      placeholderIcon: b?.placeholderIcon ?? a?.placeholderIcon,
      loadingOverlay: LoadingOverlayStyle.lerp(a?.loadingOverlay, b?.loadingOverlay, t),
      smartIndicator: SmartIndicatorStyle.lerp(a?.smartIndicator, b?.smartIndicator, t),
      registeredBadge: RegisteredBadgeStyle.lerp(a?.registeredBadge, b?.registeredBadge, t),
      presenceBadge: PresenceBadgeStyle.lerp(a?.presenceBadge, b?.presenceBadge, t),
      nameColors: t < 0.5 ? (a?.nameColors ?? b?.nameColors) : (b?.nameColors ?? a?.nameColors),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DoubleProperty('radius', radius))
      ..add(DiagnosticsProperty<TextStyle?>('initialsTextStyle', initialsTextStyle))
      ..add(DiagnosticsProperty<IconData?>('placeholderIcon', placeholderIcon))
      ..add(DiagnosticsProperty<LoadingOverlayStyle?>('loadingOverlay', loadingOverlay))
      ..add(DiagnosticsProperty<SmartIndicatorStyle?>('smartIndicator', smartIndicator))
      ..add(DiagnosticsProperty<RegisteredBadgeStyle?>('registeredBadge', registeredBadge))
      ..add(DiagnosticsProperty<PresenceBadgeStyle?>('presenceBadge', presenceBadge))
      ..add(DiagnosticsProperty<NameColorsStyle?>('nameColors', nameColors));
  }
}

/// Pseudorandom, name-derived avatar colors (see `AvatarColors`).
class NameColorsStyle with Diagnosticable {
  const NameColorsStyle({this.enabled = true, this.palette});

  /// Whether the background/initials colors are derived from the name.
  final bool enabled;

  /// Optional fixed palette; when null/empty the color is generated from the name hash.
  final List<Color>? palette;

  static NameColorsStyle? merge(NameColorsStyle? base, NameColorsStyle? override) {
    if (base == null && override == null) return null;
    if (base == null) return override;
    if (override == null) return base;

    return NameColorsStyle(enabled: override.enabled, palette: override.palette ?? base.palette);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(IterableProperty<Color>('palette', palette));
  }
}

class LoadingOverlayStyle with Diagnosticable {
  const LoadingOverlayStyle({this.showByDefault = false, this.padding, this.strokeWidth});

  final bool showByDefault;
  final EdgeInsets? padding;
  final double? strokeWidth;

  static LoadingOverlayStyle merge(LoadingOverlayStyle? base, LoadingOverlayStyle? override) {
    if (base == null && override == null) return const LoadingOverlayStyle();
    base ??= const LoadingOverlayStyle();
    override ??= const LoadingOverlayStyle();
    return LoadingOverlayStyle(
      showByDefault: override.showByDefault || base.showByDefault,
      padding: override.padding ?? base.padding,
      strokeWidth: override.strokeWidth ?? base.strokeWidth,
    );
  }

  static LoadingOverlayStyle? lerp(LoadingOverlayStyle? a, LoadingOverlayStyle? b, double t) {
    if (identical(a, b)) return a;
    if (a == null && b == null) return null;

    return LoadingOverlayStyle(
      showByDefault: b?.showByDefault ?? a?.showByDefault ?? false,
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      strokeWidth: lerpDouble(a?.strokeWidth, b?.strokeWidth, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('showByDefault', value: showByDefault, ifTrue: 'show'))
      ..add(DiagnosticsProperty<EdgeInsets?>('padding', padding))
      ..add(DoubleProperty('strokeWidth', strokeWidth));
  }
}
