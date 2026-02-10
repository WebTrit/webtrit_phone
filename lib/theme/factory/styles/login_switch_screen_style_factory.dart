import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/features/features.dart';

import '../theme_style_factory.dart';
import 'theme_image_style.dart';

class LoginSwitchScreenStyleFactory implements ThemeStyleFactory<LoginSwitchScreenStyles> {
  LoginSwitchScreenStyleFactory(this.config, this.colors, this.defaultFontFamily);

  final LoginSwitchPageConfig? config;
  final ColorScheme colors;
  final String? defaultFontFamily;

  @override
  LoginSwitchScreenStyles create() {
    final pictureLogoStyle = ThemeImageStyleFactory(source: config?.mainLogo).create();

    return LoginSwitchScreenStyles(
      primary: LoginSwitchScreenStyle(
        contentThemeOverride: config?.themeOverride.mode.toThemeMode(),
        applyToAppBar: config?.themeOverride.applyToAppBar,
        pictureLogoStyle: pictureLogoStyle,
        segmentButtonStyle: config?.segmentButtonStyle?.toButtonStyle(defaultFontFamily: defaultFontFamily),
      ),
    );
  }
}
