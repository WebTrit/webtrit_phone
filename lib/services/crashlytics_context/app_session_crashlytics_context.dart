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

  /// Binds crash reports to the logged-in user. Call with no arguments on
  /// logout: an empty identifier clears the Crashlytics user binding, and the
  /// sessionId (install-scoped) is left untouched.
  void logUser({String? userId, String? sessionId}) {
    crashKeysWriter.setUserIdentifier(userId ?? '');
    if (sessionId != null) setKey('sessionId', sessionId);
  }

  /// Writes the tenant/core scope of the active session. Crashlytics cannot
  /// delete keys, so a missing value is written as the 'unset' sentinel -
  /// otherwise a crash after logout (or a tenant switch) would be attributed
  /// to the previous session's tenant/core.
  void logSessionScope({String? tenantId, String? coreUrl}) {
    setKey('tenantId', tenantId ?? 'unset');
    setKey('coreUrl', coreUrl ?? 'unset');
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
