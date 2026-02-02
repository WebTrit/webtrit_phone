import 'package:flutter/material.dart';

import '../theme_style_factory.dart';

class ProgressIndicatorThemeDataFactory implements ThemeStyleFactory<ProgressIndicatorThemeData> {
  const ProgressIndicatorThemeDataFactory(this.colorScheme);

  final ColorScheme colorScheme;

  @override
  ProgressIndicatorThemeData create() {
    return ProgressIndicatorThemeData(
      color: colorScheme.primary,
      refreshBackgroundColor: colorScheme.surfaceContainerHigh,
      circularTrackColor: colorScheme.onSurface.withValues(alpha: 0.1),
    );
  }
}
