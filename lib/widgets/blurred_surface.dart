import 'dart:ui';

import 'package:flutter/material.dart';

/// A backdrop blur surface intended for use as [AppBar.flexibleSpace].
///
/// Applies a [BackdropFilter] with configurable gaussian blur to create
/// a frosted-glass effect. When used with [Scaffold.extendBodyBehindAppBar],
/// scrollable content appears blurred beneath the app bar.
class BlurredSurface extends StatelessWidget {
  const BlurredSurface({super.key, this.color, this.sigmaX = 10, this.sigmaY = 10, this.child});

  final Color? color;
  final double sigmaX;
  final double sigmaY;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).canvasColor.withAlpha(150);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: child ?? Container(color: color),
      ),
    );
  }
}
