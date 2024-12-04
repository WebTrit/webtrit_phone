// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class EnvironmentConfig {
  EnvironmentConfig._();

  static const DEBUG_LEVEL__NAME = 'WEBTRIT_APP_DEBUG_LEVEL';
  static const DEBUG_LEVEL = String.fromEnvironment(
    DEBUG_LEVEL__NAME,
    defaultValue: 'INFO',
  );

  static const DATABASE_LOG_STATEMENTS__NAME = 'WEBTRIT_APP_DATABASE_LOG_STATEMENTS';
  static const DATABASE_LOG_STATEMENTS = bool.fromEnvironment(
    DATABASE_LOG_STATEMENTS__NAME,
    defaultValue: false,
  );

  static const PERIODIC_POLLING__NAME = 'WEBTRIT_APP_PERIODIC_POLLING';
  static const PERIODIC_POLLING = bool.fromEnvironment(
    PERIODIC_POLLING__NAME,
    defaultValue: true,
  );

  static const ENABLE_ATTENDED_TRANSFER__NAME = 'WEBTRIT_APP_ENABLE_ATTENDED_TRANSFER';
  static const ENABLE_ATTENDED_TRANSFER = bool.fromEnvironment(
    ENABLE_ATTENDED_TRANSFER__NAME,
    defaultValue: true,
  );

  static const CORE_URL__NAME = 'WEBTRIT_APP_CORE_URL';
  static const CORE_URL = bool.hasEnvironment(CORE_URL__NAME)
      ? String.fromEnvironment(
          CORE_URL__NAME,
        )
      : null;

  static const DEMO_CORE_URL__NAME = 'WEBTRIT_APP_DEMO_CORE_URL';
  static const DEMO_CORE_URL = String.fromEnvironment(
    DEMO_CORE_URL__NAME,
    defaultValue: 'http://localhost:4000',
  );

  static const CORE_VERSION_CONSTRAINT__NAME = 'WEBTRIT_APP_CORE_VERSION_CONSTRAINT';
  static const CORE_VERSION_CONSTRAINT = String.fromEnvironment(
    CORE_VERSION_CONSTRAINT__NAME,
    defaultValue: '>=0.7.0-alpha <2.0.0',
  );

  static const APP_LINK_DOMAIN__NAME = 'WEBTRIT_APP_LINK_DOMAIN';
  static const APP_LINK_DOMAIN = String.fromEnvironment(APP_LINK_DOMAIN__NAME, defaultValue: '');

  static const APP_NAME__NAME = 'WEBTRIT_APP_NAME';
  static const APP_NAME = String.fromEnvironment(
    APP_NAME__NAME,
    defaultValue: 'WebTrit',
  );

  static const APP_GREETING__NAME = 'WEBTRIT_APP_GREETING';
  static const APP_GREETING = bool.hasEnvironment(APP_GREETING__NAME)
      ? String.fromEnvironment(
          APP_GREETING__NAME,
        )
      : null;

  static const APP_DESCRIPTION__NAME = 'WEBTRIT_APP_DESCRIPTION';
  static const APP_DESCRIPTION = bool.hasEnvironment(APP_HELP_URL__NAME)
      ? String.fromEnvironment(
          APP_DESCRIPTION__NAME,
        )
      : null;

  static const APP_HELP_URL__NAME = 'WEBTRIT_APP_HELP_URL';
  static const APP_HELP_URL = bool.hasEnvironment(APP_HELP_URL__NAME)
      ? String.fromEnvironment(
          APP_HELP_URL__NAME,
        )
      : null;

  static const APP_ABOUT_URL__NAME = 'WEBTRIT_APP_ABOUT_URL';
  static const APP_ABOUT_URL = bool.hasEnvironment(APP_ABOUT_URL__NAME)
      ? String.fromEnvironment(
          APP_ABOUT_URL__NAME,
        )
      : null;

  static const APP_CREDENTIALS_REQUEST_URL__NAME = 'WEBTRIT_APP_CREDENTIALS_REQUEST_URL';
  static const APP_CREDENTIALS_REQUEST_URL = bool.hasEnvironment(APP_CREDENTIALS_REQUEST_URL__NAME)
      ? String.fromEnvironment(
          APP_CREDENTIALS_REQUEST_URL__NAME,
        )
      : null;

  static const SALES_EMAIL__NAME = 'WEBTRIT_APP_SALES_EMAIL';
  static const SALES_EMAIL = String.fromEnvironment(
    SALES_EMAIL__NAME,
    defaultValue: 'sales@webtrit.com',
  );

  static const FCM_VAPID_KEY__NAME = 'WEBTRIT_APP_FCM_VAPID_KEY';
  static const FCM_VAPID_KEY = bool.hasEnvironment(FCM_VAPID_KEY__NAME)
      ? String.fromEnvironment(
          FCM_VAPID_KEY__NAME,
        )
      : null;

  static const CHAT_FEATURE_ENABLE__NAME = 'WEBTRIT_APP_CHAT_FEATURE_ENABLE';
  @Deprecated('Will be moved to feature access provider')
  static const CHAT_FEATURE_ENABLE = bool.fromEnvironment(
    CHAT_FEATURE_ENABLE__NAME,
    defaultValue: false,
  );

  static const CHAT_SERVICE_URL__NAME = 'WEBTRIT_APP_CHAT_SERVICE_URL';
  @Deprecated('Will be removed soon')
  static const CHAT_SERVICE_URL = bool.hasEnvironment(CHAT_SERVICE_URL__NAME)
      ? String.fromEnvironment(
          CHAT_SERVICE_URL__NAME,
        )
      : 'ws://localhost:4000/socket/websocket';

  static const SMS_FEATURE_ENABLE__NAME = 'WEBTRIT_APP_SMS_FEATURE_ENABLE';
  @Deprecated('Will be moved to feature access provider')
  static const SMS_FEATURE_ENABLE = bool.fromEnvironment(
    SMS_FEATURE_ENABLE__NAME,
    defaultValue: false,
  );

  static const SMS_SERVICE_URL__NAME = 'WEBTRIT_APP_SMS_SERVICE_URL';
  @Deprecated('Will be removed soon')
  static const SMS_SERVICE_URL = bool.hasEnvironment(SMS_SERVICE_URL__NAME)
      ? String.fromEnvironment(
          SMS_SERVICE_URL__NAME,
        )
      : 'ws://localhost:4000/socket/websocket';
}
