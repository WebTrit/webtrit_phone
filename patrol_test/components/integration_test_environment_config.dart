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

  static const EXT_CONTACT_A__NAME = 'WEBTRIT_APP_TEST_EXT_CONTACT_A';
  static const EXT_CONTACT_A = String.fromEnvironment(EXT_CONTACT_A__NAME);

  static const EXT_CONTACT_A_NUMBER__NAME = 'WEBTRIT_APP_TEST_EXT_CONTACT_A_NUMBER';
  static const EXT_CONTACT_A_NUMBER = String.fromEnvironment(EXT_CONTACT_A_NUMBER__NAME);

  static const EXT_CONTACT_B__NAME = 'WEBTRIT_APP_TEST_EXT_CONTACT_B';
  static const EXT_CONTACT_B = String.fromEnvironment(EXT_CONTACT_B__NAME);

  static const EXT_CONTACT_B_NUMBER__NAME = 'WEBTRIT_APP_TEST_EXT_CONTACT_B_NUMBER';
  static const EXT_CONTACT_B_NUMBER = String.fromEnvironment(EXT_CONTACT_B_NUMBER__NAME);

  static const ACCOUNT_NAME__NAME = 'WEBTRIT_APP_TEST_ACCOUNT_NAME';
  static const ACCOUNT_NAME = String.fromEnvironment(ACCOUNT_NAME__NAME);

  static const ACCOUNT_MAIN_NUMBER__NAME = 'WEBTRIT_APP_TEST_ACCOUNT_MAIN_NUMBER';
  static const ACCOUNT_MAIN_NUMBER = String.fromEnvironment(ACCOUNT_MAIN_NUMBER__NAME);

  static const CALL_NUMBER_A__NAME = 'WEBTRIT_APP_TEST_CALL_NUMBER_A';
  static const CALL_NUMBER_A = String.fromEnvironment(CALL_NUMBER_A__NAME);

  static const CALL_NUMBER_B__NAME = 'WEBTRIT_APP_TEST_CALL_NUMBER_B';
  static const CALL_NUMBER_B = String.fromEnvironment(CALL_NUMBER_B__NAME);

  static const CROSS_CALL_SLEEP_SECONDS__NAME = 'WEBTRIT_APP_TEST_CROSS_CALL_SLEEP_SECONDS';
  static const CROSS_CALL_SLEEP_SECONDS = int.fromEnvironment(CROSS_CALL_SLEEP_SECONDS__NAME, defaultValue: 10);

  static const PJSUA_SERVER_HOST__NAME = 'WEBTRIT_APP_TEST_PJSUA_SERVER_HOST';
  static const PJSUA_SERVER_HOST = String.fromEnvironment(PJSUA_SERVER_HOST__NAME, defaultValue: '10.0.2.2');

  static const PJSUA_SERVER_PORT__NAME = 'WEBTRIT_APP_TEST_PJSUA_SERVER_PORT';
  static const PJSUA_SERVER_PORT = int.fromEnvironment(PJSUA_SERVER_PORT__NAME, defaultValue: 7788);

  static const PJSUA_SIP_SERVER__NAME = 'WEBTRIT_APP_TEST_PJSUA_SIP_SERVER';
  static const PJSUA_SIP_SERVER = String.fromEnvironment(PJSUA_SIP_SERVER__NAME);

  static const PJSUA_SIP_USERNAME__NAME = 'WEBTRIT_APP_TEST_PJSUA_SIP_USERNAME';
  static const PJSUA_SIP_USERNAME = String.fromEnvironment(PJSUA_SIP_USERNAME__NAME);

  static const PJSUA_SIP_PASSWORD__NAME = 'WEBTRIT_APP_TEST_PJSUA_SIP_PASSWORD';
  static const PJSUA_SIP_PASSWORD = String.fromEnvironment(PJSUA_SIP_PASSWORD__NAME);
}

enum LoginMethod { email, otp, password }
