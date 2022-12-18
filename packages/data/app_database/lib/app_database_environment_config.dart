// ignore_for_file: constant_identifier_names, non_constant_identifier_names

abstract class AppDatabaseEnvironmentConfig {
  static const LOG_STATEMENTS = bool.fromEnvironment(
    'WEBTRIT_PHONE_DATABASE_LOG_STATEMENTS',
    defaultValue: false,
  );
}
