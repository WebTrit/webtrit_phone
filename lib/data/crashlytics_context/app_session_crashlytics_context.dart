import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

import 'crashlytics_app_context.dart';

/// Crashlytics keys owned by the app session lifecycle (AppBloc): the
/// authorization state and the user's theme/locale settings.
class AppSessionCrashlyticsContext extends CrashlyticsAppContext {
  const AppSessionCrashlyticsContext({super.crashKeysWriter});

  void logAuthorization({required bool authorized}) {
    setKey('authorization', authorized ? 'authorized' : 'unauthorized');
  }

  void logThemeMode(ThemeMode themeMode) {
    setKey('themeMode', themeMode.name);
  }

  /// The default sentinel locale (no explicit selection) is written as
  /// 'system'.
  void logLocale(Locale locale) {
    setKey('locale', locale == LocaleExtension.defaultNull ? 'system' : locale.toLanguageTag());
  }
}
