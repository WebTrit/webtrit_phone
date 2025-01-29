import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class SnackBarStyleFactory implements ThemeStyleFactory<SnackBarStyles> {
  SnackBarStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final SnackBarWidgetConfig? config;

  @override
  SnackBarStyles create() {
    final successBackgroundColor = config?.successBackgroundColor.toColor() ?? colors.primary;
    final errorBackgroundColor = config?.errorBackgroundColor.toColor() ?? colors.error;
    final infoBackgroundColor = config?.infoBackgroundColor.toColor() ?? colors.secondary;
    final warningBackgroundColor = config?.warningBackgroundColor.toColor() ?? colors.tertiary;

    return SnackBarStyles(
      primary: SnackBarStyle(
        successBackgroundColor: successBackgroundColor,
        errorBackgroundColor: errorBackgroundColor,
        infoBackgroundColor: infoBackgroundColor,
        warningBackgroundColor: warningBackgroundColor,
      ),
    );
  }
}
