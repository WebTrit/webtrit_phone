import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:webtrit_phone/app/keys.dart';
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

  final urlButton = find.byKey(loginModeScreenUrlButtonKey);
  final coreUrlInput = find.byKey(coreUrlInputKey);
  final coreUrlButton = find.byKey(coreUrlButtonKey);

  final testCoreUrl = IntegrationTestEnvironmentConfig.LOGIN_TEST_CORE_URL!;

  testWidgets('should accept core url and process login types', (tester) async {
    var rootApp = const RootApp();
    await tester.pumpWidget(rootApp);

    await tester.pumpAndSettle();

    await tester.tap(urlButton, warnIfMissed: true);

    await tester.pumpAndSettle();

    await tester.enterText(coreUrlInput, testCoreUrl);

    await tester.pumpAndSettle();

    await tester.tap(coreUrlButton, warnIfMissed: true);

    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();

    expect(find.byType(LoginSwitchScreen), findsOneWidget);
  });
}
