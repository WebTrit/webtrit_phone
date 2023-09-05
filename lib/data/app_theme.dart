import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/theme/theme.dart';

class AppTheme {
  static late AppTheme _instance;

  static Future<void> init() async {
    final themeJson = jsonDecode(await rootBundle.loadString(Assets.themes.original));
    final themeSettings = ThemeSettings.fromJson(themeJson);
    _instance = AppTheme._(themeSettings);
  }

  factory AppTheme() {
    return _instance;
  }

  AppTheme._(this._settings);

  ThemeSettings _settings;

  ThemeSettings get settings => _settings;
}
