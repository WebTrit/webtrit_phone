import 'package:flutter/material.dart';

/// A circular progress indicator with explicit sizing control.
///
/// Allows defining distinct dimensions for the indicator itself and its
/// layout footprint.
class SizedCircularProgressIndicator extends StatelessWidget {
  const SizedCircularProgressIndicator({
    super.key,
    required this.size,
    this.outerSize,
    this.color,
    this.strokeWidth,
    this.semanticsLabel,
  });

  /// The diameter of the actual progress indicator spinner.
  final double size;

  /// The dimensions of the square bounding box that centers the indicator.
  ///
  /// If provided, the widget forces this size in the layout, centering the
  /// [size] spinner within it. This is useful for maintaining a consistent
  /// layout footprint (e.g., matching an icon size) while keeping the
  /// visual indicator smaller.
  ///
  /// If null, the widget takes the size of the indicator itself defined by [size].
  final double? outerSize;

  final Color? color;

  final double? strokeWidth;

  /// What the wait is about, for assistive technology.
  ///
  /// Worth passing wherever the indicator replaces the caption of a control:
  /// without it the spinner contributes no semantics at all, and the control
  /// goes nameless for as long as it is busy.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final strokeWidth = this.strokeWidth;
    final result = SizedBox.fromSize(
      size: Size.square(size),
      child: strokeWidth == null
          ? CircularProgressIndicator(color: color, semanticsLabel: semanticsLabel)
          : CircularProgressIndicator(color: color, strokeWidth: strokeWidth, semanticsLabel: semanticsLabel),
    );

    final outerSize = this.outerSize;
    if (outerSize == null) {
      return result;
    } else {
      return SizedBox.fromSize(
        size: Size.square(outerSize),
        child: Center(child: result),
      );
    }
  }
}
