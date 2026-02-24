import 'dart:ui';

import 'package:flutter/material.dart';

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
