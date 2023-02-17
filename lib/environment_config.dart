// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class EnvironmentConfig {
  EnvironmentConfig._();

  static const DEBUG_LEVEL = String.fromEnvironment(
    'WEBTRIT_PHONE_DEBUG_LEVEL',
    defaultValue: 'INFO',
  );

  static const DATABASE_LOG_STATEMENTS = bool.fromEnvironment(
    'WEBTRIT_PHONE_DATABASE_LOG_STATEMENTS',
    defaultValue: false,
  );

  static const PERIODIC_POLLING = bool.fromEnvironment(
    'WEBTRIT_PHONE_PERIODIC_POLLING',
    defaultValue: true,
  );

  static const CORE_URL = String.fromEnvironment(
    'WEBTRIT_PHONE_WEBTRIT_CORE_URL',
  );

  static const DEMO_CORE_URL = String.fromEnvironment(
    'WEBTRIT_PHONE_DEMO_WEBTRIT_CORE_URL',
    defaultValue: 'http://localhost:4000',
  );

  static const APP_NAME = String.fromEnvironment(
    'WEBTRIT_PHONE_APP_NAME',
    defaultValue: 'WebTrit',
  );

  static const APP_DESCRIPTION = String.fromEnvironment(
    'WEBTRIT_PHONE_APP_DESCRIPTION',
    defaultValue: '$APP_NAME application',
  );

  static const APP_HELP_URL = String.fromEnvironment(
    'WEBTRIT_PHONE_APP_HELP_URL',
  );

  static const APP_ABOUT_URL = String.fromEnvironment(
    'WEBTRIT_PHONE_APP_ABOUT_URL',
  );

  static const APP_TERMS_AND_CONDITIONS_URL = String.fromEnvironment(
    'WEBTRIT_PHONE_APP_TERMS_AND_CONDITIONS_URL',
  );
}
