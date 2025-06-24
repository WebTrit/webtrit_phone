import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class TextThemeDataFactory implements ThemeStyleFactory<TextTheme> {
  TextThemeDataFactory(this.colors, this.config, this.themeData);

  final ColorScheme colors;
  final FontsConfig config;
  final ThemeData themeData;

  @override
  TextTheme create() {
    final fontFamily = config.fontFamily;
    final baseTextTheme = themeData.textTheme;

    if (fontFamily == null) return baseTextTheme;
    try {
      return GoogleFonts.getTextTheme(fontFamily, baseTextTheme);
    } catch (e) {
      if (fontFamily.toLowerCase() == 'montserrat') {
        return baseTextTheme.apply(fontFamily: 'Montserrat');
      }
      return baseTextTheme;
    }
  }
}
