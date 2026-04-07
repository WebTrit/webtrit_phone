import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';

Future<void> loginByPassword(
  PatrolIntegrationTester $,
  String passwordUserCredential,
  String passwordPasswordCredential,
) async {
  final passwordSegmentButton = $(LoginType.passwordSignin.toLoginSegmentKey());
  final passwordUserInput = $(passwordUserInputKey);
  final passwordPasswordInput = $(passwordPasswordInputKey);
  final passwordButton = $(passwordButtonKey);

  if (passwordSegmentButton.visible) await passwordSegmentButton.tap();
  await passwordUserInput.enterText(passwordUserCredential);
  await passwordPasswordInput.enterText(passwordPasswordCredential);
  await passwordButton.tap();
}
