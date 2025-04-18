// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class IntegrationTestEnvironmentConfig {
  IntegrationTestEnvironmentConfig._();

  static const LOGIN_TEST_CUSTOM_CORE_URL__NAME = 'WEBTRIT_APP_LOGIN_TEST_CUSTOM_CORE_URL';
  static const LOGIN_TEST_CUSTOM_CORE_URL = bool.hasEnvironment(LOGIN_TEST_CUSTOM_CORE_URL__NAME)
      ? String.fromEnvironment(
          LOGIN_TEST_CUSTOM_CORE_URL__NAME,
        )
      : null;

  static const LOGIN_TEST_EMAIL_CREDENTIAL__NAME = 'WEBTRIT_APP_LOGIN_TEST_EMAIL_CREDENTIAL';
  static const LOGIN_TEST_EMAIL_CREDENTIAL = bool.hasEnvironment(LOGIN_TEST_EMAIL_CREDENTIAL__NAME)
      ? String.fromEnvironment(
          LOGIN_TEST_EMAIL_CREDENTIAL__NAME,
        )
      : null;

  static const LOGIN_TEST_EMAIL_VERIFY_CREDENTIAL__NAME = 'WEBTRIT_APP_LOGIN_TEST_EMAIL_VERIFY_CREDENTIAL';
  static const LOGIN_TEST_EMAIL_VERIFY_CREDENTIAL = bool.hasEnvironment(LOGIN_TEST_EMAIL_VERIFY_CREDENTIAL__NAME)
      ? String.fromEnvironment(
          LOGIN_TEST_EMAIL_VERIFY_CREDENTIAL__NAME,
        )
      : null;

  static const LOGIN_TEST_OTP_CREDENTIAL__NAME = 'WEBTRIT_APP_LOGIN_TEST_OTP_CREDENTIAL';
  static const LOGIN_TEST_OTP_CREDENTIAL = bool.hasEnvironment(LOGIN_TEST_OTP_CREDENTIAL__NAME)
      ? String.fromEnvironment(
          LOGIN_TEST_OTP_CREDENTIAL__NAME,
        )
      : null;

  static const LOGIN_TEST_OTP_VERIFY_CREDENTIAL__NAME = 'WEBTRIT_APP_LOGIN_TEST_OTP_VERIFY_CREDENTIAL';
  static const LOGIN_TEST_OTP_VERIFY_CREDENTIAL = bool.hasEnvironment(LOGIN_TEST_OTP_VERIFY_CREDENTIAL__NAME)
      ? String.fromEnvironment(
          LOGIN_TEST_OTP_VERIFY_CREDENTIAL__NAME,
        )
      : null;

  static const LOGIN_TEST_PASSWORD_USER_CREDENTIAL__NAME = 'WEBTRIT_APP_LOGIN_TEST_PASSWORD_USER_CREDENTIAL';
  static const LOGIN_TEST_PASSWORD_USER_CREDENTIAL = bool.hasEnvironment(LOGIN_TEST_PASSWORD_USER_CREDENTIAL__NAME)
      ? String.fromEnvironment(
          LOGIN_TEST_PASSWORD_USER_CREDENTIAL__NAME,
        )
      : null;

  static const LOGIN_TEST_PASSWORD_PASSWORD_CREDENTIAL__NAME = 'WEBTRIT_APP_LOGIN_TEST_PASSWORD_PASSWORD_CREDENTIAL';
  static const LOGIN_TEST_PASSWORD_PASSWORD_CREDENTIAL =
      bool.hasEnvironment(LOGIN_TEST_PASSWORD_PASSWORD_CREDENTIAL__NAME)
          ? String.fromEnvironment(
              LOGIN_TEST_PASSWORD_PASSWORD_CREDENTIAL__NAME,
            )
          : null;
}
