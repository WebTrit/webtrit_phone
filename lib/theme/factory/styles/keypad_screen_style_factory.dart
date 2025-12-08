import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_page_config.dart';

import 'package:webtrit_phone/features/keypad/keypad.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

import '../theme_style_factory.dart';

import 'action_pad_style_factory.dart';
import 'keypad_style_factory.dart';

class KeypadScreenStyleFactory implements ThemeStyleFactory<KeypadScreenStyles> {
  KeypadScreenStyleFactory(this.colors, {required this.config, required this.textTheme});

  final ColorScheme colors;
  final KeypadPageConfig config;
  final TextTheme textTheme;

  @override
  KeypadScreenStyles create() {
    final themeData = ThemeData(colorScheme: colors);
    return KeypadScreenStyles(
      primary: KeypadScreenStyle(
        inputField: config.textField?.toStyle(colors: colors, theme: themeData),
        contactNameField: config.contactName?.toStyle(
          colors: colors,
          theme: themeData,
          base: const TextFieldStyle(textAlign: TextAlign.center, showCursor: false, keyboardType: TextInputType.none),
        ),
        keypadStyle: KeypadStyleFactory(colors, config: config.keypad, textTheme: textTheme).create().primary,
        actionpadStyle: ActionPadStyleFactory(colors, config.actionpad).create().primary,
      ),
    );
  }
}
