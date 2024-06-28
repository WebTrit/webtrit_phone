import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:webtrit_phone/app/constants.dart';
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

  final signinButton = find.byKey(const Key(loginModeScreenSignUpButtonKey));
  final passwordSegmentButton = find.byKey(Key(LoginType.passwordSignin.toLoginSegmentKey()));
  final passwordUserInput = find.byKey(const Key(passwordUserInputKey));
  final passwordPasswordInput = find.byKey(const Key(passwordPasswordInputKey));
  final passwordButton = find.byKey(const Key(passwordButtonKey));

  final passwordUserCredential = EnvironmentConfig.LOGIN_TEST_PASSWORD_USER_CREDENTIAL!;
  final passwordPasswordCredential = EnvironmentConfig.LOGIN_TEST_PASSWORD_PASSWORD_CREDENTIAL!;

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
