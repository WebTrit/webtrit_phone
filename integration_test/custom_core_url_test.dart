import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:webtrit_phone/app/constants.dart';
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

  final urlButton = find.byKey(const Key(loginModeScreenUrlButtonKey));
  final coreUrlInput = find.byKey(const Key(coreUrlInputKey));
  final coreUrlButton = find.byKey(const Key(coreUrlButtonKey));

  final testCoreUrl = EnvironmentConfig.LOGIN_TEST_CORE_URL!;

  testWidgets('should login by email', (tester) async {
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
