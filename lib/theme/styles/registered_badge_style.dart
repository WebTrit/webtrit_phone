import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisteredBadgeStyle with Diagnosticable {
  const RegisteredBadgeStyle({this.registeredColor, this.unregisteredColor, this.sizeFactor});

  final Color? registeredColor;
  final Color? unregisteredColor;

  /// Relative to avatar diameter (widget ~0.2).
  final double? sizeFactor;

  static RegisteredBadgeStyle merge(RegisteredBadgeStyle? base, RegisteredBadgeStyle? override) {
    if (base == null && override == null) return const RegisteredBadgeStyle();
    base ??= const RegisteredBadgeStyle();
    override ??= const RegisteredBadgeStyle();
    return RegisteredBadgeStyle(
      registeredColor: override.registeredColor ?? base.registeredColor,
      unregisteredColor: override.unregisteredColor ?? base.unregisteredColor,
      sizeFactor: override.sizeFactor ?? base.sizeFactor,
    );
  }

  static RegisteredBadgeStyle? lerp(RegisteredBadgeStyle? a, RegisteredBadgeStyle? b, double t) {
    if (identical(a, b)) return a;
    if (a == null && b == null) return null;

    return RegisteredBadgeStyle(
      registeredColor: Color.lerp(a?.registeredColor, b?.registeredColor, t),
      unregisteredColor: Color.lerp(a?.unregisteredColor, b?.unregisteredColor, t),
      sizeFactor: lerpDouble(a?.sizeFactor, b?.sizeFactor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('registeredColor', registeredColor))
      ..add(ColorProperty('unregisteredColor', unregisteredColor))
      ..add(DoubleProperty('sizeFactor', sizeFactor));
  }
}
