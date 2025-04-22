import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';

Future<void> loginByPassword(
  WidgetTester tester,
  String passwordUserCredential,
  String passwordPasswordCredential,
) async {
  final passwordSegmentButton = find.byKey(LoginType.passwordSignin.toLoginSegmentKey());
  final passwordUserInput = find.byKey(passwordUserInputKey);
  final passwordPasswordInput = find.byKey(passwordPasswordInputKey);
  final passwordButton = find.byKey(passwordButtonKey);

  if (passwordSegmentButton.evaluate().isNotEmpty) {
    await tester.tap(passwordSegmentButton, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  await tester.enterText(passwordUserInput, passwordUserCredential);
  await tester.pumpAndSettle();

  await tester.enterText(passwordPasswordInput, passwordPasswordCredential);
  await tester.pumpAndSettle();

  await tester.tap(passwordButton, warnIfMissed: true);
  await tester.pumpAndSettle();
}
