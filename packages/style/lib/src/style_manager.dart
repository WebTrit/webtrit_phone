import 'package:style/src/api/configurator_api.dart';
import 'package:style/src/service/theme_service.dart';

import 'dto/dto.dart';

class StyleManager {
  static late StyleManager _instance;

  static Future<void> init({
    required String defaultTheme,
    required String url,
  }) async {
    final api = ConfiguratorApi(url);
    final themeService = ThemeService(api);

    _instance = StyleManager._(defaultTheme, themeService);
  }

  factory StyleManager() {
    return _instance;
  }

  StyleManager._(
    this._defaultTheme,
    this._themeService,
  );

  String _defaultTheme;

  ThemeService _themeService;

  Future<ThemeDTO> getById(String applicationId, String themeId) async {
    return _themeService.getThemeById(applicationId: applicationId, themeId: themeId, defaultTheme: _defaultTheme);
  }

  Future<ThemeDTO> getDefault() async {
    return _themeService.getThemeDefault(defaultTheme: _defaultTheme);
  }
}
