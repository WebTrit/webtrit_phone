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

  static const SIGNUP_POST_DESCRIPTION_TEXT__NAME = 'WEBTRIT_APP_SIGNUP_POST_DESCRIPTION_TEXT';
  static const SIGNUP_POST_DESCRIPTION_TEXT = String.fromEnvironment(
    SIGNUP_POST_DESCRIPTION_TEXT__NAME,
  );

  static const PASSWORD_SIGNIN_POST_DESCRIPTION_TEXT__NAME = 'WEBTRIT_APP_PASSWORD_SIGNIN_POST_DESCRIPTION_TEXT';
  static const PASSWORD_SIGNIN_POST_DESCRIPTION_TEXT = String.fromEnvironment(
    PASSWORD_SIGNIN_POST_DESCRIPTION_TEXT__NAME,
  );

  static const OTP_SIGNIN_POST_DESCRIPTION_TEXT__NAME = 'WEBTRIT_APP_OTP_SIGNIN_POST_DESCRIPTION_TEXT';
  static const OTP_SIGNIN_POST_DESCRIPTION_TEXT = String.fromEnvironment(
    OTP_SIGNIN_POST_DESCRIPTION_TEXT__NAME,
  );
}
