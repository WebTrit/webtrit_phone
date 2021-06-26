class EnvironmentConfig {
  EnvironmentConfig._();

  static const DEBUG_LEVEL = String.fromEnvironment(
    'DEBUG_LEVEL',
    defaultValue: 'INFO',
  );

  static const PERIODIC_POLLING = bool.fromEnvironment(
    'PERIODIC_POLLING',
    defaultValue: true,
  );

  static const WEBTRIT_CORE_URL = String.fromEnvironment(
    'WEBTRIT_CORE_URL',
    defaultValue: 'http://localhost:4000',
  );

  static String get WEBTRIT_SIGNALING_URL {
    final uri = Uri.parse(WEBTRIT_CORE_URL);
    if (uri.scheme.endsWith('s')) {
      return uri.replace(scheme: 'wss').toString();
    } else {
      return uri.replace(scheme: 'ws').toString();
    }
  }
}
