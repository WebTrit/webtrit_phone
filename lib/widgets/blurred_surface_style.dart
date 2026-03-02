import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Visual style for a [BlurredSurface] widget.
class BlurredSurfaceStyle with Diagnosticable {
  const BlurredSurfaceStyle({this.color, this.sigmaX, this.sigmaY});

  /// Overlay color for the blurred surface.
  final Color? color;

  /// Horizontal gaussian blur sigma.
  final double? sigmaX;

  /// Vertical gaussian blur sigma.
  final double? sigmaY;

  BlurredSurfaceStyle copyWith({Color? color, double? sigmaX, double? sigmaY}) {
    return BlurredSurfaceStyle(
      color: color ?? this.color,
      sigmaX: sigmaX ?? this.sigmaX,
      sigmaY: sigmaY ?? this.sigmaY,
    );
  }

  static BlurredSurfaceStyle merge(BlurredSurfaceStyle? a, BlurredSurfaceStyle? b) {
    if (a == null) return b ?? const BlurredSurfaceStyle();
    if (b == null) return a;

    return BlurredSurfaceStyle(color: b.color ?? a.color, sigmaX: b.sigmaX ?? a.sigmaX, sigmaY: b.sigmaY ?? a.sigmaY);
  }

  static BlurredSurfaceStyle? lerp(BlurredSurfaceStyle? a, BlurredSurfaceStyle? b, double t) {
    if (a == null && b == null) return null;

    return BlurredSurfaceStyle(
      color: Color.lerp(a?.color, b?.color, t),
      sigmaX: lerpDouble(a?.sigmaX, b?.sigmaX, t),
      sigmaY: lerpDouble(a?.sigmaY, b?.sigmaY, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('sigmaX', sigmaX))
      ..add(DoubleProperty('sigmaY', sigmaY));
  }
}
