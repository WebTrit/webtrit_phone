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

  static const WEB_REGISTRATION_INITIAL_URL = String.fromEnvironment(
    'WEB_REGISTRATION_INITIAL_URL',
    defaultValue: null,
  );
}
