import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/features/features.dart';

import '../theme_style_factory.dart';
import 'theme_image_style.dart';

class LoginSwitchScreenStyleFactory implements ThemeStyleFactory<LoginSwitchScreenStyles> {
  LoginSwitchScreenStyleFactory(this.config, this.colors);

  final LoginSwitchPageConfig? config;
  final ColorScheme colors;

  @override
  LoginSwitchScreenStyles create() {
    final pictureLogoStyle = ThemeImageStyleFactory(source: config?.mainLogo).create();

    return LoginSwitchScreenStyles(primary: LoginSwitchScreenStyle(pictureLogoStyle: pictureLogoStyle));
  }
}
