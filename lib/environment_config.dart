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

  // LOGZIO service-specific configuration.
  // If additional logging services are introduced, consider moving these to a separate logging configuration file.
  static const REMOTE_LOGZIO_LOGGING_URL__NAME = 'WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_URL';
  static const REMOTE_LOGZIO_LOGGING_URL = bool.hasEnvironment(REMOTE_LOGZIO_LOGGING_URL__NAME)
      ? String.fromEnvironment(
          REMOTE_LOGZIO_LOGGING_URL__NAME,
        )
      : null;

  // LOGZIO service-specific configuration.
  // If additional logging services are introduced, consider moving these to a separate logging configuration file.
  static const REMOTE_LOGZIO_LOG_LEVEL__NAME = 'WEBTRIT_APP_REMOTE_LOGZIO_LOG_LEVEL';
  static const REMOTE_LOGZIO_LOG_LEVEL = String.fromEnvironment(
    REMOTE_LOGZIO_LOG_LEVEL__NAME,
    defaultValue: 'INFO',
  );

  // LOGZIO service-specific configuration.
  // If additional logging services are introduced, consider moving these to a separate logging configuration file.
  static const REMOTE_LOGZIO_LOGGING_TOKEN__NAME = 'WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_TOKEN';
  static const REMOTE_LOGZIO_LOGGING_TOKEN = bool.hasEnvironment(REMOTE_LOGZIO_LOGGING_TOKEN__NAME)
      ? String.fromEnvironment(
          REMOTE_LOGZIO_LOGGING_TOKEN__NAME,
        )
      : null;

  // LOGZIO service-specific configuration.
  // If additional logging services are introduced, consider moving these to a separate logging configuration file.
  static const _REMOTE_LOGZIO_LOGGING_BUFFER_SIZE__KB = 0;
  static const REMOTE_LOGZIO_LOGGING_BUFFER_SIZE__NAME = 'WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_BUFFER_SIZE';
  static final REMOTE_LOGZIO_LOGGING_BUFFER_SIZE =
      int.tryParse(const String.fromEnvironment(REMOTE_LOGZIO_LOGGING_BUFFER_SIZE__NAME)) ??
          _REMOTE_LOGZIO_LOGGING_BUFFER_SIZE__KB;

  // SMS-based incoming call trigger mechanism (fallback).
  // If enabled, the app listens for specially formatted incoming SMS messages to trigger incoming calls.
  static const CALL_TRIGGER_MECHANISM_SMS__NAME = 'WEBTRIT_CALL_TRIGGER_MECHANISM_SMS';
  static const CALL_TRIGGER_MECHANISM_SMS = bool.fromEnvironment(
    CALL_TRIGGER_MECHANISM_SMS__NAME,
    defaultValue: false,
  );

  // SMS-based incoming call trigger prefix.
  // Used to filter incoming SMS messages. Only messages starting with this prefix are processed.
  static const CALL_TRIGGER_MECHANISM_SMS_PREFIX__NAME = 'WEBTRIT_CALL_TRIGGER_MECHANISM_SMS_PREFIX';
  static const CALL_TRIGGER_MECHANISM_SMS_PREFIX = String.fromEnvironment(
    CALL_TRIGGER_MECHANISM_SMS_PREFIX__NAME,
    defaultValue: '<#> WEBTRIT:',
  );

  // ICU regex pattern to extract callId, handle, displayName and hasVideo from SMS body.
  static const CALL_TRIGGER_MECHANISM_SMS_REGEX_PATTERN__NAME = 'WEBTRIT_CALL_TRIGGER_MECHANISM_SMS_REGEX_PATTERN';
  static const CALL_TRIGGER_MECHANISM_SMS_REGEX_PATTERN = String.fromEnvironment(
    CALL_TRIGGER_MECHANISM_SMS_REGEX_PATTERN__NAME,
    defaultValue:
        r'https://app\.webtrit\.com/call\?callId=([^&]+)&handle=([^&]+)&displayName=([^&]+)&hasVideo=(true|false)',
  );

  static const CONNECTIVITY_CHECK_URL__NAME = 'WEBTRIT_APP_CONNECTIVITY_CHECK_URL';

  // URL used to check internet connectivity. Defaults to Google (204).
  // Should return a quick 200/204 response.
  static const CONNECTIVITY_CHECK_URL = String.fromEnvironment(
    CONNECTIVITY_CHECK_URL__NAME,
    defaultValue: 'https://www.google.com/generate_204',
  );
}
