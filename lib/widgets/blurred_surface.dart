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

  /// Frosted-glass fallback for app bars that have no configured blur style.
  ///
  /// Returns the blur only while the themed app bar background is translucent,
  /// i.e. while content actually shows through the bar. On an opaque bar a
  /// backdrop blur has nothing to reveal and only smears the bar edges with
  /// the colors around it, so `null` is returned and the bar stays solid.
  static BlurredSurface? adaptive(BuildContext context, {double sigmaX = 10, double sigmaY = 10}) {
    final barColor = Theme.of(context).appBarTheme.backgroundColor;
    if (barColor != null && barColor.a >= 1.0) return null;
    return BlurredSurface(sigmaX: sigmaX, sigmaY: sigmaY);
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
        child: child ?? Container(color: color ?? Colors.transparent),
      ),
    );
  }
}
