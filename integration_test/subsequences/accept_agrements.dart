import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/main_shell.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/features/permissions/widgets/permission_tips.dart';

Future<void> acceptAgrements(WidgetTester tester) async {
  while (find.byType(MainShell).evaluate().isEmpty) {
    debugPrint('Waiting for MainShell to appear...');
    if (find.byType(ContactsAgreementScreen).evaluate().isNotEmpty) {
      debugPrint('ContactsAgreementScreen found');
      await tester.tap(find.byKey(contactsAgreementCheckboxKey), warnIfMissed: true);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(contactsAgreementAcceptButtonKey), warnIfMissed: true);
      await tester.pumpAndSettle();
    }

    if (find.byType(UserAgreementScreen).evaluate().isNotEmpty) {
      debugPrint('UserAgreementScreen found');
      await tester.tap(find.byKey(userAgreementCheckboxKey), warnIfMissed: true);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(userAgreementAcceptButtonKey), warnIfMissed: true);
      await tester.pumpAndSettle();
    }

    if (find.byType(PermissionsScreen).evaluate().isNotEmpty) {
      debugPrint('PermissionsProcessScreen found');
      await tester.tap(find.byKey(permissionsInitButtonKey), warnIfMissed: true);
      await tester.pumpAndSettle();
    }

    if (find.byType(PermissionTips).evaluate().isNotEmpty) {
      debugPrint('PermissionTips found');
      await tester.tap(find.byKey(permissionTipsButtonKey), warnIfMissed: true);
      await tester.pumpAndSettle();
    }

    await Future.delayed(const Duration(seconds: 1));
  }
}
