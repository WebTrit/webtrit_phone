import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';

import '../components/integration_test_environment_config.dart';

Future<void> customCoreSignInProceed(PatrolIntegrationTester $) async {
  const testCoreUrl = IntegrationTestEnvironmentConfig.CUSTOM_CORE_URL;
  final urlButton = $(loginModeScreenUrlButtonKey);
  final coreUrlInput = $(coreUrlInputKey);
  final coreUrlButton = $(coreUrlButtonKey);

  await urlButton.tap();
  await coreUrlInput.enterText(testCoreUrl);
  await coreUrlButton.tap();
}
