// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class IntegrationTestEnvironmentConfig {
  IntegrationTestEnvironmentConfig._();

  static const CUSTOM_CORE_URL__NAME = 'WEBTRIT_APP_TEST_CUSTOM_CORE_URL';
  static const CUSTOM_CORE_URL = String.fromEnvironment(CUSTOM_CORE_URL__NAME);

  static const EMAIL_CREDENTIAL__NAME = 'WEBTRIT_APP_TEST_EMAIL_CREDENTIAL';
  static const EMAIL_CREDENTIAL = String.fromEnvironment(EMAIL_CREDENTIAL__NAME);

  static const EMAIL_VERIFY_CREDENTIAL__NAME = 'WEBTRIT_APP_TEST_EMAIL_VERIFY_CREDENTIAL';
  static const EMAIL_VERIFY_CREDENTIAL = String.fromEnvironment(EMAIL_VERIFY_CREDENTIAL__NAME);

  static const OTP_CREDENTIAL__NAME = 'WEBTRIT_APP_TEST_OTP_CREDENTIAL';
  static const OTP_CREDENTIAL = String.fromEnvironment(OTP_CREDENTIAL__NAME);

  static const OTP_VERIFY_CREDENTIAL__NAME = 'WEBTRIT_APP_TEST_OTP_VERIFY_CREDENTIAL';
  static const OTP_VERIFY_CREDENTIAL = String.fromEnvironment(OTP_VERIFY_CREDENTIAL__NAME);

  static const PASSWORD_USER_CREDENTIAL__NAME = 'WEBTRIT_APP_TEST_PASSWORD_USER_CREDENTIAL';
  static const PASSWORD_USER_CREDENTIAL = String.fromEnvironment(PASSWORD_USER_CREDENTIAL__NAME);

  static const PASSWORD_PASSWORD_CREDENTIAL__NAME = 'WEBTRIT_APP_TEST_PASSWORD_PASSWORD_CREDENTIAL';
  static const PASSWORD_PASSWORD_CREDENTIAL = String.fromEnvironment(PASSWORD_PASSWORD_CREDENTIAL__NAME);

  static const DEFAULT_LOGIN_METHOD__NAME = 'WEBTRIT_APP_TEST_DEFAULT_LOGIN_METHOD';
  static LoginMethod DEFAULT_LOGIN_METHOD = LoginMethod.values.byName(
    const String.fromEnvironment(DEFAULT_LOGIN_METHOD__NAME),
  );
}

enum LoginMethod { email, otp, password }
