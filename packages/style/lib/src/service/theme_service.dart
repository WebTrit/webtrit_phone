import 'dart:convert';

import 'package:flutter/services.dart';

import '../api/api.dart';
import '../model/models.dart';
import '../storage/store.dart';

class ThemeService {
  Future<int> actualizeTheme({
    required String applicationId,
    required String themeId,
  }) async {
    final application = await Api.getApplication(applicationId: applicationId);

    final serverVersion = application.version!;
    final currentVersion = await Store.getAppVersion();

    if (serverVersion > currentVersion) {
      var bundleData = await Api.getTheme(applicationId: applicationId, themeId: themeId);
      await Store.updateLocalVersion(serverVersion);
      await Store.persistLocalTheme(bundleData);
    }
    return serverVersion;
  }

  Future<ThemeModel> readTheme({
    required String applicationId,
    required String themeId,
    required String staticTheme,
  }) async {
    try {
      await actualizeTheme(applicationId: applicationId, themeId: themeId);
      final persistTheme = await Store.getTheme();
      return persistTheme!;
    } catch (e) {
      final String response = await rootBundle.loadString(staticTheme);
      return ThemeModel.fromJson(jsonDecode(response));
    }
  }
}
