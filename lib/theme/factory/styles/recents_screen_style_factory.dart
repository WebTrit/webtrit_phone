import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_page_config.dart';

import 'package:webtrit_phone/features/recents/view/recents_screen_style.dart';
import 'package:webtrit_phone/features/recents/view/recents_screen_styles.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

import '../theme_style_factory.dart';

class RecentsScreenStyleFactory implements ThemeStyleFactory<RecentsScreenStyles> {
  RecentsScreenStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final RecentsPageConfig config;

  @override
  RecentsScreenStyles create() {
    final backgroundStyle = config.background?.toStyle();

    return RecentsScreenStyles(
      primary: RecentsScreenStyle(
        background: backgroundStyle,
        contentThemeOverride: config.themeOverride.mode.toContentThemeOverride(),
        applyToAppBar: config.themeOverride.applyToAppBar,
      ),
    );
  }
}
