// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/main_shell.dart';

Future<void> acceptAgrementsUntilMainShell(PatrolIntegrationTester $) async {
  final contactsAgreementCheckbox = $(contactsAgreementCheckboxKey);
  final contactsAgreementAcceptButton = $(contactsAgreementAcceptButtonKey);
  final userAgreementCheckbox = $(userAgreementCheckboxKey);
  final userAgreementAcceptButton = $(userAgreementAcceptButtonKey);
  final permissionsInitButton = $(permissionsInitButtonKey);
  final permissionTipsButton = $(permissionTipsButtonKey);

  while ($(MainShell).visible == false) {
    print('Waiting for MainShell to appear...');

    // Contacts agrement processing
    if (contactsAgreementCheckbox.visible) await contactsAgreementCheckbox.tap();
    if (contactsAgreementAcceptButton.visible) await contactsAgreementAcceptButton.tap();

    // User agreement processing
    if (userAgreementCheckbox.visible) await userAgreementCheckbox.tap();
    if (userAgreementAcceptButton.visible) await userAgreementAcceptButton.tap();

    // Permissions processing
    if (permissionsInitButton.visible) {
      await permissionsInitButton.tap(settlePolicy: SettlePolicy.noSettle);

      // Process native permission dialogs until they go away
      await Future.doWhile(() async {
        final isPermissionDialogVisible = await $.native.isPermissionDialogVisible();
        if (isPermissionDialogVisible) await $.native.grantPermissionWhenInUse();
        return isPermissionDialogVisible;
      });
      await $.pumpAndTrySettle();
    }
    if (permissionTipsButton.visible) await permissionTipsButton.tap();

    // Try pump ui before next MainShell check
    await $.pumpAndTrySettle();
  }
}
