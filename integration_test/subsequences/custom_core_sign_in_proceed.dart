import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_phone/app/keys.dart';
import '../components/integration_test_environment_config.dart';

Future<void> customCoreSignInProceed(WidgetTester tester) async {
  final urlButton = find.byKey(loginModeScreenUrlButtonKey);
  final coreUrlInput = find.byKey(coreUrlInputKey);
  final coreUrlButton = find.byKey(coreUrlButtonKey);
  final testCoreUrl = IntegrationTestEnvironmentConfig.LOGIN_TEST_CUSTOM_CORE_URL!;

  await tester.tap(urlButton, warnIfMissed: true);
  await tester.pumpAndSettle();

  await tester.enterText(coreUrlInput, testCoreUrl);
  await tester.pumpAndSettle();

  await tester.tap(coreUrlButton, warnIfMissed: true);
  await tester.pumpAndSettle();
}
