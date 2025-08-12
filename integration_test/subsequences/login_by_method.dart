import 'package:patrol/patrol.dart';

import '../components/integration_test_environment_config.dart';
import 'accept_agrements_until_main_shell.dart';
import 'custom_core_sign_in_proceed.dart';
import 'login_by_email.dart';
import 'login_by_otp.dart';
import 'login_by_password.dart';
import 'regular_sign_in_proceed.dart';

Future<void> loginByMethod(PatrolIntegrationTester $, LoginMethod loginMethod) async {
  const customCoreUrl = IntegrationTestEnvironmentConfig.CUSTOM_CORE_URL;
  final hasCustomCoreUrl = customCoreUrl.isNotEmpty;

  hasCustomCoreUrl ? await customCoreSignInProceed($) : await regularSignInProceed($);

  await switch (loginMethod) {
    LoginMethod.email => loginByEmail(
        $,
        IntegrationTestEnvironmentConfig.EMAIL_CREDENTIAL,
        IntegrationTestEnvironmentConfig.EMAIL_VERIFY_CREDENTIAL,
      ),
    LoginMethod.otp => loginByOtp(
        $,
        IntegrationTestEnvironmentConfig.OTP_CREDENTIAL,
        IntegrationTestEnvironmentConfig.OTP_VERIFY_CREDENTIAL,
      ),
    LoginMethod.password => loginByPassword(
        $,
        IntegrationTestEnvironmentConfig.PASSWORD_USER_CREDENTIAL,
        IntegrationTestEnvironmentConfig.PASSWORD_PASSWORD_CREDENTIAL,
      ),
  };
  await acceptAgrementsUntilMainShell($);
}
