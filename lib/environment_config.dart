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

  static const APP_LINK_DOMAIN__NAME = 'WEBTRIT_APP_LINK_DOMAIN';
  static const APP_LINK_DOMAIN = String.fromEnvironment(APP_LINK_DOMAIN__NAME, defaultValue: '');

  static const APP_NAME__NAME = 'WEBTRIT_APP_NAME';
  static const APP_NAME = String.fromEnvironment(
    APP_NAME__NAME,
    defaultValue: 'WebTrit',
  );

  static const APP_GREETING__NAME = 'WEBTRIT_APP_GREETING';
  static const APP_GREETING = String.fromEnvironment(
    APP_GREETING__NAME,
    defaultValue: 'WebTrit',
  );

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

  static const APP_TERMS_AND_CONDITIONS_URL__NAME = 'WEBTRIT_APP_TERMS_AND_CONDITIONS_URL';
  static const APP_TERMS_AND_CONDITIONS_URL = bool.hasEnvironment(APP_TERMS_AND_CONDITIONS_URL__NAME)
      ? String.fromEnvironment(
          APP_TERMS_AND_CONDITIONS_URL__NAME,
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

  static const FAVOURITE_FEATURE_ENABLE__NAME = 'WEBTRIT_APP_FAVOURITE_FEATURE_ENABLE';
  static const FAVOURITE_FEATURE_ENABLE = bool.fromEnvironment(
    FAVOURITE_FEATURE_ENABLE__NAME,
    defaultValue: true,
  );

  static const RECENT_FEATURE_ENABLE__NAME = 'WEBTRIT_APP_RECENT_FEATURE_ENABLE';
  static const RECENT_FEATURE_ENABLE = bool.fromEnvironment(
    RECENT_FEATURE_ENABLE__NAME,
    defaultValue: true,
  );

  static const CONTACT_FEATURE_ENABLE__NAME = 'WEBTRIT_APP_CONTACT_FEATURE_ENABLE';
  static const CONTACT_FEATURE_ENABLE = bool.fromEnvironment(
    CONTACT_FEATURE_ENABLE__NAME,
    defaultValue: true,
  );

  static const KEYPAD_FEATURE_ENABLE__NAME = 'WEBTRIT_APP_KEYPAD_FEATURE_ENABLE';
  static const KEYPAD_FEATURE_ENABLE = bool.fromEnvironment(
    KEYPAD_FEATURE_ENABLE__NAME,
    defaultValue: true,
  );

  static const LOCAL_CONTACTS_FEATURE_ENABLE__NAME = 'WEBTRIT_APP_LOCAL_CONTACTS_FEATURE_ENABLE';
  static const LOCAL_CONTACTS_FEATURE_ENABLE = bool.fromEnvironment(
    LOCAL_CONTACTS_FEATURE_ENABLE__NAME,
    defaultValue: true,
  );

  static const REMOTE_CONTACTS_FEATURE_ENABLE__NAME = 'WEBTRIT_APP_REMOTE_CONTACTS_FEATURE_ENABLE';
  static const REMOTE_CONTACTS_FEATURE_ENABLE = bool.fromEnvironment(
    REMOTE_CONTACTS_FEATURE_ENABLE__NAME,
    defaultValue: true,
  );

  static const LOG_RECORD_FEATURE_ENABLE__NAME = 'WEBTRIT_APP_LOG_RECORD_FEATURE_ENABLE';
  static const LOG_RECORD_FEATURE_ENABLE = bool.fromEnvironment(
    LOG_RECORD_FEATURE_ENABLE__NAME,
    defaultValue: true,
  );
}
