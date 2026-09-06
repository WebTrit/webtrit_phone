import 'package:flutter/widgets.dart';

/// The checkerboard drawn behind anything that may be transparent, so a colour
/// with alpha reads as a colour rather than as the page behind it.
///
/// Copied from the configurator (`core/widgets/pattern_painter.dart`), which shows
/// theme colours over it for the same reason: an app bar is frosted, and on a plain
/// page there is no telling its colour from what is behind it.

class PatternPainter extends CustomPainter {
  PatternPainter({required this.primaryColor, this.cellSize = 20.0});

  final Color primaryColor;

  /// Side of one checker square. Smaller values suit small swatches.
  final double cellSize;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var row = 0; row < (size.height / cellSize).ceil(); row++) {
      for (var col = 0; col < (size.width / cellSize).ceil(); col++) {
        paint.color = (row + col).isEven ? primaryColor.withValues(alpha: 0.85) : primaryColor.withValues(alpha: 0.65);

        final rect = Rect.fromLTWH(col * cellSize, row * cellSize, cellSize, cellSize);
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant PatternPainter oldDelegate) {
    return oldDelegate.primaryColor != primaryColor || oldDelegate.cellSize != cellSize;
  }
}
