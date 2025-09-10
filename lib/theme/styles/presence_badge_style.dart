import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PresenceBadgeStyle with Diagnosticable {
  const PresenceBadgeStyle({
    this.availableColor,
    this.unavailableColor,
    this.sizeFactor,
  });

  final Color? availableColor;
  final Color? unavailableColor;

  /// Relative to avatar diameter (widget ~0.325).
  final double? sizeFactor;

  static PresenceBadgeStyle merge(PresenceBadgeStyle? base, PresenceBadgeStyle? override) {
    if (base == null && override == null) return const PresenceBadgeStyle();
    base ??= const PresenceBadgeStyle();
    override ??= const PresenceBadgeStyle();
    return PresenceBadgeStyle(
      availableColor: override.availableColor ?? base.availableColor,
      unavailableColor: override.unavailableColor ?? base.unavailableColor,
      sizeFactor: override.sizeFactor ?? base.sizeFactor,
    );
  }

  static PresenceBadgeStyle? lerp(
    PresenceBadgeStyle? a,
    PresenceBadgeStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    if (a == null && b == null) return null;

    return PresenceBadgeStyle(
      availableColor: Color.lerp(a?.availableColor, b?.availableColor, t),
      unavailableColor: Color.lerp(a?.unavailableColor, b?.unavailableColor, t),
      sizeFactor: lerpDouble(a?.sizeFactor, b?.sizeFactor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('availableColor', availableColor))
      ..add(ColorProperty('unavailableColor', unavailableColor))
      ..add(DoubleProperty('sizeFactor', sizeFactor));
  }
}
