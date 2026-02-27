import 'dart:ui';

import 'package:flutter/material.dart';

import 'blurred_surface_style.dart';
export 'blurred_surface_style.dart';

/// A backdrop blur surface intended for use as [AppBar.flexibleSpace].
///
/// Applies a [BackdropFilter] with configurable gaussian blur to create
/// a frosted-glass effect. When used with [Scaffold.extendBodyBehindAppBar],
/// scrollable content appears blurred beneath the app bar.
class BlurredSurface extends StatelessWidget {
  const BlurredSurface({super.key, this.color, this.sigmaX = 0, this.sigmaY = 0, this.child});

  /// Creates a [BlurredSurface] from [style], or returns `null` when absent.
  ///
  /// Defaults sigmaX/sigmaY to 10 when not specified in [style].
  static BlurredSurface? fromStyle(BlurredSurfaceStyle? style) {
    if (style == null) return null;
    return BlurredSurface(color: style.color, sigmaX: style.sigmaX ?? 10, sigmaY: style.sigmaY ?? 10);
  }

  final Color? color;
  final double sigmaX;
  final double sigmaY;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: child ?? Container(color: color),
      ),
    );
  }
}
