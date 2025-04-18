import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:webtrit_phone/app/router/main_shell.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/accept_agrements.dart';
import 'subsequences/custom_core_sign_in_proceed.dart';
import 'subsequences/login_by_email.dart';
import 'subsequences/login_by_otp.dart';
import 'subsequences/login_by_password.dart';
import 'subsequences/logout.dart';
import 'subsequences/pump_root_app.dart';
import 'subsequences/regular_sign_in_proceed.dart';

main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await bootstrap();

    final appPreferences = AppPreferencesFactory.instance;
    final secureStorage = SecureStorage();

    await appPreferences.clear();
    await secureStorage.deleteCoreUrl();
    await secureStorage.deleteTenantId();
    await secureStorage.deleteToken();
  });

  const emailCredential = IntegrationTestEnvironmentConfig.LOGIN_TEST_EMAIL_CREDENTIAL;
  const emailVerifyCredential = IntegrationTestEnvironmentConfig.LOGIN_TEST_EMAIL_VERIFY_CREDENTIAL;
  final hasEmailCredentials = (emailCredential != null && emailCredential.isNotEmpty) &&
      (emailVerifyCredential != null && emailVerifyCredential.isNotEmpty);

  const otpCredential = IntegrationTestEnvironmentConfig.LOGIN_TEST_OTP_CREDENTIAL;
  const otpVerifyCredential = IntegrationTestEnvironmentConfig.LOGIN_TEST_OTP_VERIFY_CREDENTIAL;
  final hasOtpCredentials = (otpCredential != null && otpCredential.isNotEmpty) &&
      (otpVerifyCredential != null && otpVerifyCredential.isNotEmpty);

  const passwordUserCredential = IntegrationTestEnvironmentConfig.LOGIN_TEST_PASSWORD_USER_CREDENTIAL;
  const passwordPasswordCredential = IntegrationTestEnvironmentConfig.LOGIN_TEST_PASSWORD_PASSWORD_CREDENTIAL;
  final hasPasswordCredentials = (passwordUserCredential != null && passwordUserCredential.isNotEmpty) &&
      (passwordPasswordCredential != null && passwordPasswordCredential.isNotEmpty);

  const customCoreUrl = IntegrationTestEnvironmentConfig.LOGIN_TEST_CUSTOM_CORE_URL;
  final hasCustomCoreUrl = customCoreUrl != null && customCoreUrl.isNotEmpty;

  if (hasEmailCredentials) {
    testWidgets(
      'should login by email credentials',
      (WidgetTester tester) async {
        await pumpRootApp(tester);
        expect(find.byType(LoginModeSelectScreen), findsOneWidget);
        debugPrint('Login mode select screen appeared');

        if (hasCustomCoreUrl) {
          await customCoreSignInProceed(tester);
          debugPrint('Custom core URL proceeded');
        } else {
          await regularSignInProceed(tester);
          debugPrint('Regular sign in proceeded');
        }

        await loginByEmail(tester, emailCredential, emailVerifyCredential);
        debugPrint('Email credentials entered');

        await acceptAgrements(tester);
        debugPrint('Agreements accepted');

        expect(find.byType(MainShell), findsOneWidget);
      },
      skip: false,
    );
    testWidgets(
      'should logout after login by email credentials',
      (WidgetTester tester) async {
        await pumpRootApp(tester);
        expect(find.byType(MainShell), findsOneWidget);
        debugPrint('Main shell appeared');

        await logout(tester);
      },
      skip: false,
    );
  }

  if (hasOtpCredentials) {
    testWidgets(
      'should login by otp credentials',
      (WidgetTester tester) async {
        await pumpRootApp(tester);
        expect(find.byType(LoginModeSelectScreen), findsOneWidget);
        debugPrint('Login mode select screen appeared');

        if (hasCustomCoreUrl) {
          await customCoreSignInProceed(tester);
          debugPrint('Custom core URL proceeded');
        } else {
          await regularSignInProceed(tester);
          debugPrint('Regular sign in proceeded');
        }

        await loginByOtp(tester, otpCredential, otpVerifyCredential);
        debugPrint('OTP credentials entered');

        await acceptAgrements(tester);
        debugPrint('Agreements accepted');

        expect(find.byType(MainShell), findsOneWidget);
      },
      skip: false,
    );
    testWidgets(
      'should logout after login by otp credentials',
      (WidgetTester tester) async {
        await pumpRootApp(tester);
        expect(find.byType(MainShell), findsOneWidget);
        debugPrint('Main shell appeared');

        await logout(tester);
      },
      skip: false,
    );
  }

  if (hasPasswordCredentials) {
    testWidgets(
      'should login by password credentials',
      (WidgetTester tester) async {
        await pumpRootApp(tester);
        expect(find.byType(LoginModeSelectScreen), findsOneWidget);
        debugPrint('Login mode select screen appeared');

        if (hasCustomCoreUrl) {
          await customCoreSignInProceed(tester);
          debugPrint('Custom core URL proceeded');
        } else {
          await regularSignInProceed(tester);
          debugPrint('Regular sign in proceeded');
        }

        await loginByPassword(tester, passwordUserCredential, passwordPasswordCredential);
        debugPrint('Password credentials entered');

        await acceptAgrements(tester);
        debugPrint('Agreements accepted');

        expect(find.byType(MainShell), findsOneWidget);
      },
      skip: false,
    );
    testWidgets(
      'should logout after login by password credentials',
      (WidgetTester tester) async {
        await pumpRootApp(tester);
        expect(find.byType(MainShell), findsOneWidget);
        debugPrint('Main shell appeared');

        await logout(tester);
      },
      skip: false,
    );
  }
}
