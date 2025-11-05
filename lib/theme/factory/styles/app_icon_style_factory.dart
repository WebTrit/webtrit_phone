import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';

import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../theme_style_factory.dart';

class AppIconStyleFactory implements ThemeStyleFactory<AppIconStyles> {
  AppIconStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final AppIconWidgetConfig? config;

  @override
  AppIconStyles create() {
    final appIconColor = config?.color?.toColor() ?? colors.primary;

    return AppIconStyles(primary: AppIconStyle(color: appIconColor));
  }
}
