import 'package:flutter/widgets.dart';

class OverlayConfig {
  final BoxConstraints overlayEntityConstraints;
  final BoxConstraints? overlayEntityConstraintsMinimized;

  final double sticking;
  final double clipRadius;

  final bool draggability;

  const OverlayConfig({
    required this.overlayEntityConstraints,
    this.overlayEntityConstraintsMinimized,
    this.sticking = 4,
    this.clipRadius = 8,
    this.draggability = true,
  });
}
