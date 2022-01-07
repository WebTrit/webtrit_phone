// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class EnvironmentConfig {
  EnvironmentConfig._();

  static const DEBUG_LEVEL = String.fromEnvironment(
    'WEBTRIT_PHONE_DEBUG_LEVEL',
    defaultValue: 'INFO',
  );

  static const PERIODIC_POLLING = bool.fromEnvironment(
    'WEBTRIT_PHONE_PERIODIC_POLLING',
    defaultValue: true,
  );

  static const CORE_URL = String.fromEnvironment(
    'WEBTRIT_PHONE_WEBTRIT_CORE_URL',
    defaultValue: 'http://localhost:4000',
  );

  static String get SIGNALING_URL {
    final uri = Uri.parse(CORE_URL);
    if (uri.scheme.endsWith('s')) {
      return uri.replace(scheme: 'wss').toString();
    } else {
      return uri.replace(scheme: 'ws').toString();
    }
  }

  static const APP_NAME = String.fromEnvironment(
    'WEBTRIT_PHONE_APP_NAME',
    defaultValue: 'WebTrit',
  );
}
