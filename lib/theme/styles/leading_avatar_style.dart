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
      ..add(DiagnosticsProperty<PresenceBadgeStyle?>('presenceBadge', presenceBadge));
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
