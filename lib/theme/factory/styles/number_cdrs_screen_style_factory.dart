import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_page_config.dart';
import 'package:webtrit_phone/features/cdrs/features/number_cdrs_log/view/number_cdrs_screen_style.dart';
import 'package:webtrit_phone/features/cdrs/features/number_cdrs_log/view/number_cdrs_screen_styles.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

import '../theme_style_factory.dart';

class NumberCdrsScreenStyleFactory implements ThemeStyleFactory<NumberCdrsScreenStyles> {
  NumberCdrsScreenStyleFactory(this.colors, this.config, {this.appBarTheme});

  final ColorScheme colors;
  final NumberCdrsPageConfig config;
  final AppBarTheme? appBarTheme;

  @override
  NumberCdrsScreenStyles create() {
    final backgroundStyle = config.background?.toStyle();

    return NumberCdrsScreenStyles(
      primary: NumberCdrsScreenStyle(
        background: backgroundStyle,
        appBarBlurredSurface: config.appBarBlurredSurface?.toStyle(),
        appBarTheme: appBarTheme,
      ),
    );
  }
}
