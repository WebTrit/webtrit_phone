import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_page_config.dart';

import 'package:webtrit_phone/features/keypad/view/keypad_screen_style.dart';
import 'package:webtrit_phone/features/keypad/view/keypad_screen_styles.dart';

import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

import '../theme_style_factory.dart';

import 'action_pad_style_factory.dart';
import 'keypad_style_factory.dart';

class KeypadScreenStyleFactory implements ThemeStyleFactory<KeypadScreenStyles> {
  KeypadScreenStyleFactory(this.colors, this.defaultFontFamily, {required this.config, required this.textTheme});

  final ColorScheme colors;
  final KeypadPageConfig config;
  final TextTheme textTheme;
  final String? defaultFontFamily;

  @override
  KeypadScreenStyles create() {
    final backgroundStyle = config.background?.toStyle();

    return KeypadScreenStyles(
      primary: KeypadScreenStyle(
        background: backgroundStyle,
        contentThemeOverride: config.themeOverride.mode.toThemeMode(),
        applyToAppBar: config.themeOverride.applyToAppBar,
        inputField: config.textField?.toStyle(colors: colors, defaultFontFamily: defaultFontFamily),
        contactNameField: config.contactName?.toStyle(
          colors: colors,
          defaultFontFamily: defaultFontFamily,
          base: const TextFieldStyle(textAlign: TextAlign.center, showCursor: false, keyboardType: TextInputType.none),
        ),
        keypadStyle: KeypadStyleFactory(
          colors,
          defaultFontFamily,
          config: config.keypad,
          textTheme: textTheme,
        ).create().primary,
        actionpadStyle: ActionPadStyleFactory(colors, config.actionpad).create().primary,
      ),
    );
  }
}
