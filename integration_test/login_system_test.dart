import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/bootstrap.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/accept_agrements_until_main_shell.dart';
import 'subsequences/custom_core_sign_in_proceed.dart';
import 'subsequences/login_by_email.dart';
import 'subsequences/login_by_otp.dart';
import 'subsequences/login_by_password.dart';
import 'subsequences/logout.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';
import 'subsequences/regular_sign_in_proceed.dart';

main() {
  const emailCredential = IntegrationTestEnvironmentConfig.EMAIL_CREDENTIAL;
  const emailVerifyCredential = IntegrationTestEnvironmentConfig.EMAIL_VERIFY_CREDENTIAL;
  final hasEmailCredentials = emailCredential.isNotEmpty && emailVerifyCredential.isNotEmpty;

  const otpCredential = IntegrationTestEnvironmentConfig.OTP_CREDENTIAL;
  const otpVerifyCredential = IntegrationTestEnvironmentConfig.OTP_VERIFY_CREDENTIAL;
  final hasOtpCredentials = otpCredential.isNotEmpty && otpVerifyCredential.isNotEmpty;

  const passwordUserCredential = IntegrationTestEnvironmentConfig.PASSWORD_USER_CREDENTIAL;
  const passwordPasswordCredential = IntegrationTestEnvironmentConfig.PASSWORD_PASSWORD_CREDENTIAL;
  final hasPasswordCredentials = passwordUserCredential.isNotEmpty && passwordPasswordCredential.isNotEmpty;

  const customCoreUrl = IntegrationTestEnvironmentConfig.CUSTOM_CORE_URL;
  final hasCustomCoreUrl = customCoreUrl.isNotEmpty;

  patrolTest(
    'should login by email credentials',
    ($) async {
      await bootstrap();
      await pumpRootAndWaitUntilVisible($);
      hasCustomCoreUrl ? await customCoreSignInProceed($) : await regularSignInProceed($);
      await loginByEmail($, emailCredential, emailVerifyCredential);
      await acceptAgrementsUntilMainShell($);
      await Future.delayed(const Duration(seconds: 5));
      await logout($);
    },
    skip: hasEmailCredentials == false,
  );

  patrolTest(
    'should login by otp credentials',
    ($) async {
      await bootstrap();
      await pumpRootAndWaitUntilVisible($);
      hasCustomCoreUrl ? await customCoreSignInProceed($) : await regularSignInProceed($);
      await loginByOtp($, otpCredential, otpVerifyCredential);
      await acceptAgrementsUntilMainShell($);
      await Future.delayed(const Duration(seconds: 5));
      await logout($);
    },
    skip: hasOtpCredentials == false,
  );

  patrolTest(
    'should login by password credentials',
    ($) async {
      await bootstrap();
      await pumpRootAndWaitUntilVisible($);
      hasCustomCoreUrl ? await customCoreSignInProceed($) : await regularSignInProceed($);
      await loginByPassword(($), passwordUserCredential, passwordPasswordCredential);
      await acceptAgrementsUntilMainShell(($));
      await Future.delayed(const Duration(seconds: 5));
      await logout($);
    },
    skip: hasPasswordCredentials == false,
  );
}
