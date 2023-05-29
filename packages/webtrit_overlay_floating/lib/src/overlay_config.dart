import 'package:flutter/widgets.dart';

class OverlayConfig {
  final BoxConstraints overlayEntityConstraints;
  final BoxConstraints overlayEntityConstraintsMinimized;

  final double sticking;
  final double clipRadius;

  const OverlayConfig({
    this.overlayEntityConstraints = const BoxConstraints(maxHeight: 148, maxWidth: 148),
    this.overlayEntityConstraintsMinimized = const BoxConstraints(maxHeight: 148, maxWidth: 40),
    this.sticking = 4,
    this.clipRadius = 8,
  });
}
