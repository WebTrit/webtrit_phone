import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/main_shell.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/main.dart';

main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await bootstrap();

    final appPreferences = AppPreferences();
    final secureStorage = SecureStorage();

    await appPreferences.clear();
    await secureStorage.deleteCoreUrl();
    await secureStorage.deleteTenantId();
    await secureStorage.deleteToken();
  });

  final signinButton = find.byKey(loginModeScreenSignUpButtonKey);
  final otpSegmentButton = find.byKey(Key(LoginType.otpSignin.toLoginSegmentKey()));
  final otpInput = find.byKey(optInputKey);
  final otpButton = find.byKey(otpButtonKey);
  final otpVerifyInput = find.byKey(otpVerifyInputKey);
  final otpVerifyButton = find.byKey(otpVerifyButtonKey);

  final otpCredential = EnvironmentConfig.LOGIN_TEST_OTP_CREDENTIAL!;
  final otpVerifyCredential = EnvironmentConfig.LOGIN_TEST_OTP_VERIFY_CREDENTIAL!;

  testWidgets('should login by otp credentials', (tester) async {
    var rootApp = const RootApp();
    await tester.pumpWidget(rootApp);

    await tester.pumpAndSettle();

    await tester.tap(signinButton, warnIfMissed: true);

    await tester.pumpAndSettle();

    if (otpSegmentButton.evaluate().isNotEmpty) {
      await tester.tap(otpSegmentButton, warnIfMissed: true);
      await tester.pumpAndSettle();
    }

    await tester.enterText(otpInput, otpCredential);

    await tester.pumpAndSettle();

    await tester.tap(otpButton, warnIfMissed: true);

    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();

    await tester.enterText(otpVerifyInput, otpVerifyCredential);

    await tester.pumpAndSettle();

    await tester.tap(otpVerifyButton, warnIfMissed: true);

    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();

    expect(find.byType(MainShell), findsOneWidget);
  });
}
