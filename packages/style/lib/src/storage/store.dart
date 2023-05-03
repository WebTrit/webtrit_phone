import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/models.dart';

class Store {
  static const String _appThemeData = 'WEBTRIT_THEME_DATA';
  static const String _appThemeVersion = 'WEBTRIT_THEME_VERSION';

  Store._();

  static Future<int> getAppVersion() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_appThemeVersion) ?? 0;
  }

  static Future updateLocalVersion(int version) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt(_appThemeVersion, version);
  }

  static Future<ThemeModel?> getTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final jsonString = preferences.getString(_appThemeData);
    Map<String, dynamic> map = jsonDecode(jsonString!) as Map<String, dynamic>;
    return ThemeModel.fromJson(map);
  }

  static Future<void> persistLocalTheme(ThemeModel theme) async {
    final preferences = await SharedPreferences.getInstance();
    final map = theme.toJson();
    final jsonString = jsonEncode(map);
    preferences.setString(_appThemeData, jsonString);
  }

  static Future<void> removePersistedReleaseData() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(_appThemeData);
  }
}
