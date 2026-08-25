import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PresenceBadgeStyle with Diagnosticable {
  const PresenceBadgeStyle({
    this.availableColor,
    this.unavailableColor,
    this.busyColor,
    this.iconColor,
    this.sizeFactor,
  });

  final Color? availableColor;
  final Color? unavailableColor;

  /// Fill for a contact who should not be called right now: one publishing
  /// "busy" or "do not disturb".
  final Color? busyColor;

  /// Color of the activity glyph drawn inside the badge.
  final Color? iconColor;

  /// Relative to avatar diameter; the app's own value lives in
  /// [LeadingAvatarStyle.defaults].
  final double? sizeFactor;

  static PresenceBadgeStyle merge(PresenceBadgeStyle? base, PresenceBadgeStyle? override) {
    if (base == null && override == null) return const PresenceBadgeStyle();
    base ??= const PresenceBadgeStyle();
    override ??= const PresenceBadgeStyle();
    return PresenceBadgeStyle(
      availableColor: override.availableColor ?? base.availableColor,
      unavailableColor: override.unavailableColor ?? base.unavailableColor,
      busyColor: override.busyColor ?? base.busyColor,
      iconColor: override.iconColor ?? base.iconColor,
      sizeFactor: override.sizeFactor ?? base.sizeFactor,
    );
  }

  static PresenceBadgeStyle? lerp(PresenceBadgeStyle? a, PresenceBadgeStyle? b, double t) {
    if (identical(a, b)) return a;
    if (a == null && b == null) return null;

    return PresenceBadgeStyle(
      availableColor: Color.lerp(a?.availableColor, b?.availableColor, t),
      unavailableColor: Color.lerp(a?.unavailableColor, b?.unavailableColor, t),
      busyColor: Color.lerp(a?.busyColor, b?.busyColor, t),
      iconColor: Color.lerp(a?.iconColor, b?.iconColor, t),
      sizeFactor: lerpDouble(a?.sizeFactor, b?.sizeFactor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('availableColor', availableColor))
      ..add(ColorProperty('unavailableColor', unavailableColor))
      ..add(ColorProperty('busyColor', busyColor))
      ..add(ColorProperty('iconColor', iconColor))
      ..add(DoubleProperty('sizeFactor', sizeFactor));
  }
}
