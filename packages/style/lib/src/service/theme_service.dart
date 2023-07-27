import 'dart:convert';

import 'package:flutter/services.dart';

import '../api/configurator_api.dart';
import '../dto/dto.dart';
import '../storage/store.dart';

class ThemeService {
  ThemeService(this.api);

  final ConfiguratorApi api;

  Future<int> actualizeTheme({
    required String applicationId,
    required String themeId,
  }) async {
    final application = await api.getApplication(applicationId: applicationId);

    final serverVersion = application.version!;
    final currentVersion = await Store.getAppVersion();

    if (serverVersion > currentVersion) {
      var bundleData = await api.getTheme(applicationId: applicationId, themeId: themeId);
      await Store.updateLocalVersion(serverVersion);
      await Store.persistLocalTheme(bundleData);
    }
    return serverVersion;
  }

  Future<ThemeDTO> getThemeById({
    required String applicationId,
    required String themeId,
    required String defaultTheme,
  }) async {
    try {
      await actualizeTheme(applicationId: applicationId, themeId: themeId);
      final persistTheme = await Store.getTheme();
      return persistTheme!;
    } catch (e) {
      return getThemeDefault(defaultTheme: defaultTheme);
    }
  }

  Future<ThemeDTO> getThemeDefault({
    required String defaultTheme,
  }) async {
    final String response = await rootBundle.loadString(defaultTheme);
    return ThemeDTO.fromJson(jsonDecode(response));
  }
}
