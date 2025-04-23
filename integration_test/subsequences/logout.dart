import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';

Future<void> logout(WidgetTester tester) async {
  final appBar = find.byKey(mainAppBarKey);
  final logoutButton = find.byKey(settingsLogoutButtonKey);
  final confirmButton = find.byKey(confirmDialogYesButtonKey);

  await tester.tap(appBar, warnIfMissed: true);
  await tester.pumpAndSettle();
  debugPrint('Main app bar tapped');

  expect(find.byType(SettingsScreen), findsOneWidget);

  await tester.tap(logoutButton, warnIfMissed: true);
  await tester.pumpAndSettle();
  debugPrint('Logout button tapped');

  await tester.tap(confirmButton, warnIfMissed: true);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  debugPrint('Confirm dialog button tapped');

  expect(find.byType(LoginModeSelectScreen), findsOneWidget);
}
