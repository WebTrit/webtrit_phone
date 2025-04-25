import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:webtrit_phone/app/keys.dart';

Future<void> regularSignInProceed(PatrolIntegrationTester $) async {
  final singInButton = $(loginModeScreenSignUpButtonKey);
  await singInButton.tap();
}
