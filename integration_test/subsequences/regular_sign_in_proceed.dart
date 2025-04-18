import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_phone/app/keys.dart';

Future<void> regularSignInProceed(WidgetTester tester) async {
  final singInButton = find.byKey(loginModeScreenSignUpButtonKey);

  await tester.tap(singInButton, warnIfMissed: true);
  await tester.pumpAndSettle();
}
