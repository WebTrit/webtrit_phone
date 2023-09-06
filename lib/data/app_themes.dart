import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/theme/theme.dart';

class AppThemes {
  static late AppThemes _instance;

  static Future<void> init() async {
    final themeJson = jsonDecode(await rootBundle.loadString(Assets.themes.original));
    final settings = ThemeSettings.fromJson(themeJson);
    final themes = [AppTheme(settings: settings)];
    _instance = AppThemes._(themes);
  }

  factory AppThemes() {
    return _instance;
  }

  AppThemes._(this.values);

  final List<AppTheme> values;
}

class AppTheme extends Equatable {
  const AppTheme({
    required this.settings,
  });

  final ThemeSettings settings;

  @override
  List<Object> get props => [
        settings,
      ];
}
