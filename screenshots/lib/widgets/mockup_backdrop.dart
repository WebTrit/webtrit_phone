import 'package:flutter/material.dart';

import 'pattern_painter.dart';

/// The backdrop both mockup pages stand on.
///
/// The app bar is frosted and the call widgets are drawn over video, so a plain page
/// behind them says nothing: over the checkerboard their own colour and transparency
/// are visible, and both pages read the same way.
class MockupBackdrop extends StatelessWidget {
  const MockupBackdrop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // The pattern is painted with the brand colour at full strength over an opaque base:
    // mixed with the surface first, its cells came within a dozen values of the near-white
    // bars in front of them, which is a checkerboard nobody sees.
    final base = theme.brightness == Brightness.light
        ? theme.colorScheme.surfaceContainerHighest
        : theme.colorScheme.surfaceContainerLow;

    return ColoredBox(
      color: base,
      child: CustomPaint(
        painter: PatternPainter(primaryColor: theme.colorScheme.primary, cellSize: 24),
        child: child,
      ),
    );
  }
}
