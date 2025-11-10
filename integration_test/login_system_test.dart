import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/bootstrap.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/logout.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

void main() {
  const emailCredential = IntegrationTestEnvironmentConfig.EMAIL_CREDENTIAL;
  const emailVerifyCredential = IntegrationTestEnvironmentConfig.EMAIL_VERIFY_CREDENTIAL;
  final hasEmailCredentials = emailCredential.isNotEmpty && emailVerifyCredential.isNotEmpty;

  const otpCredential = IntegrationTestEnvironmentConfig.OTP_CREDENTIAL;
  const otpVerifyCredential = IntegrationTestEnvironmentConfig.OTP_VERIFY_CREDENTIAL;
  final hasOtpCredentials = otpCredential.isNotEmpty && otpVerifyCredential.isNotEmpty;

  const passwordUserCredential = IntegrationTestEnvironmentConfig.PASSWORD_USER_CREDENTIAL;
  const passwordPasswordCredential = IntegrationTestEnvironmentConfig.PASSWORD_PASSWORD_CREDENTIAL;
  final hasPasswordCredentials = passwordUserCredential.isNotEmpty && passwordPasswordCredential.isNotEmpty;

  patrolTest('should login by email credentials', ($) async {
    await bootstrap();
    await pumpRootAndWaitUntilVisible($);
    await loginByMethod($, LoginMethod.email);
    await Future.delayed(const Duration(seconds: 5));
    await logout($);
  }, skip: hasEmailCredentials == false);

  patrolTest('should login by otp credentials', ($) async {
    await bootstrap();
    await pumpRootAndWaitUntilVisible($);
    await loginByMethod($, LoginMethod.otp);
    await Future.delayed(const Duration(seconds: 5));
    await logout($);
  }, skip: hasOtpCredentials == false);

  patrolTest('should login by password credentials', ($) async {
    await bootstrap();
    await pumpRootAndWaitUntilVisible($);
    await loginByMethod($, LoginMethod.password);
    await Future.delayed(const Duration(seconds: 5));
    await logout($);
  }, skip: hasPasswordCredentials == false);
}
