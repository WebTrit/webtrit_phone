import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_widget_config.dart';

import 'package:webtrit_phone/theme/extension/extension.dart';

import '../theme_style_factory.dart';

class GradientsStyleFactory implements ThemeStyleFactory<Gradients?> {
  GradientsStyleFactory(this.config);

  final GradientColorsConfig config;

  @override
  Gradients? create() {
    final customColors = config.colors.map((it) => it.color.toColor()).toList();

    // Check if there are at least two colors to form a gradient
    if (customColors.length < 2) {
      return null;
    }
    return Gradients(
      tab: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: customColors),
    );
  }
}
