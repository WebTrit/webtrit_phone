import 'package:style/src/service/theme_service.dart';
import 'package:style/src/style_config.dart';

import 'model/models.dart';

class StyleManager {
  static late StyleManager _instance;

  static Future<void> init({
    required String themeId,
    required String applicationId,
    required String defaultTheme,
  }) async {
    _instance = StyleManager._(applicationId, themeId, defaultTheme);
  }

  static Future<void> setting({
    required String host,
  }) async {
    StyleConfig.baseUrl = host;
  }

  factory StyleManager() {
    return _instance;
  }

  StyleManager._(
    this._applicationId,
    this._themeId,
    this._defaultTheme,
  );

  String _applicationId;
  String _themeId;
  String _defaultTheme;

  final _themeService = ThemeService();

  Future<ThemeModel> get() async {
    return _themeService.readTheme(applicationId: _applicationId, themeId: _themeId, staticTheme: _defaultTheme);
  }
}
