import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/main_shell.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/main.dart';

import 'integration_test_environment_config.dart';

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
  final passwordSegmentButton = find.byKey(LoginType.passwordSignin.toLoginSegmentKey());
  final passwordUserInput = find.byKey(passwordUserInputKey);
  final passwordPasswordInput = find.byKey(passwordPasswordInputKey);
  final passwordButton = find.byKey(passwordButtonKey);

  final passwordUserCredential = IntegrationTestEnvironmentConfig.LOGIN_TEST_PASSWORD_USER_CREDENTIAL!;
  final passwordPasswordCredential = IntegrationTestEnvironmentConfig.LOGIN_TEST_PASSWORD_PASSWORD_CREDENTIAL!;

  testWidgets('should login by password credentials', (tester) async {
    var rootApp = const RootApp();
    await tester.pumpWidget(rootApp);

    await tester.pumpAndSettle();

    await tester.tap(signinButton, warnIfMissed: true);

    await tester.pumpAndSettle();

    if (passwordSegmentButton.evaluate().isNotEmpty) {
      await tester.tap(passwordSegmentButton, warnIfMissed: true);
      await tester.pumpAndSettle();
    }

    await tester.enterText(passwordUserInput, passwordUserCredential);

    await tester.pumpAndSettle();

    await tester.enterText(passwordPasswordInput, passwordPasswordCredential);

    await tester.pumpAndSettle();

    await tester.tap(passwordButton, warnIfMissed: true);

    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();

    expect(find.byType(MainShell), findsOneWidget);
  });
}
