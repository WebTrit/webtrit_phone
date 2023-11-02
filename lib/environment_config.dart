// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class EnvironmentConfig {
  EnvironmentConfig._();

  static const DEBUG_LEVEL = String.fromEnvironment(
    'WEBTRIT_APP_DEBUG_LEVEL',
    defaultValue: 'INFO',
  );

  static const DATABASE_LOG_STATEMENTS = bool.fromEnvironment(
    'WEBTRIT_APP_DATABASE_LOG_STATEMENTS',
    defaultValue: false,
  );

  static const PERIODIC_POLLING = bool.fromEnvironment(
    'WEBTRIT_APP_PERIODIC_POLLING',
    defaultValue: true,
  );

  static const CORE_URL = String.fromEnvironment(
    'WEBTRIT_APP_CORE_URL',
  );

  static const DEMO_CORE_URL = String.fromEnvironment(
    'WEBTRIT_APP_DEMO_CORE_URL',
    defaultValue: 'http://localhost:4000',
  );

  static const DEFAULT_PASSWORD_TYPE_LOGIN_TENANT = String.fromEnvironment(
    'WEBTRIT_DEFAULT_PASSWORD_TYPE_LOGIN_TENANT',
    defaultValue: '',
  );

  static const APP_NAME = String.fromEnvironment(
    'WEBTRIT_APP_NAME',
    defaultValue: 'WebTrit',
  );

  static const APP_GREETING = String.fromEnvironment(
    'WEBTRIT_APP_GREETING',
    defaultValue: 'WebTrit',
  );

  static const APP_DESCRIPTION = String.fromEnvironment(
    'WEBTRIT_APP_DESCRIPTION',
  );

  static const APP_HELP_URL = String.fromEnvironment(
    'WEBTRIT_APP_HELP_URL',
  );

  static const APP_ABOUT_URL = String.fromEnvironment(
    'WEBTRIT_APP_ABOUT_URL',
  );

  static const APP_TERMS_AND_CONDITIONS_URL = String.fromEnvironment(
    'WEBTRIT_APP_TERMS_AND_CONDITIONS_URL',
  );

  static const SALES_EMAIL = String.fromEnvironment(
    'WEBTRIT_APP_SALES_EMAIL',
    defaultValue: 'sales@webtrit.com',
  );

  static const FCM_VAPID_KEY = String.fromEnvironment(
    'WEBTRIT_APP_FCM_VAPID_KEY',
  );
}
