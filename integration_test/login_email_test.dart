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
  final emailSegmentButton = find.byKey(Key(LoginType.signup.toLoginSegmentKey()));
  final emailInput = find.byKey(signupEmailInputKey);
  final emailButton = find.byKey(signupEmailButtonKey);
  final emailVerifyInput = find.byKey(signupVerifyInputKey);
  final emailVerifyButton = find.byKey(signupVerifyButtonKey);

  final emailCredential = EnvironmentConfig.LOGIN_TEST_EMAIL_CREDENTIAL!;
  final emailVerifyCredential = EnvironmentConfig.LOGIN_TEST_EMAIL_VERIFY_CREDENTIAL!;

  testWidgets('should login by email credentials', (tester) async {
    var rootApp = const RootApp();
    await tester.pumpWidget(rootApp);

    await tester.pumpAndSettle();

    await tester.tap(signinButton, warnIfMissed: true);

    await tester.pumpAndSettle();

    if (emailSegmentButton.evaluate().isNotEmpty) {
      await tester.tap(emailSegmentButton, warnIfMissed: true);
      await tester.pumpAndSettle();
    }

    await tester.enterText(emailInput, emailCredential);

    await tester.pumpAndSettle();

    await tester.tap(emailButton, warnIfMissed: true);

    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();

    await tester.enterText(emailVerifyInput, emailVerifyCredential);

    await tester.pumpAndSettle();

    await tester.tap(emailVerifyButton, warnIfMissed: true);

    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();

    expect(find.byType(MainShell), findsOneWidget);
  });
}
