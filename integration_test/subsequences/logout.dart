import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/features/settings/view/settings_screen.dart';
import 'package:webtrit_phone/widgets/confirm_dialog.dart';

Future<void> logout(PatrolIntegrationTester $) async {
  final appBar = $(mainAppBarKey);
  final logoutButton = $(settingsLogoutButtonKey);
  final confirmButton = $(confirmDialogYesButtonKey);
  final settingsScreen = $(SettingsScreen);
  final confirmDialog = $(ConfirmDialog);
  final loginModeSelectScreen = $(LoginModeSelectScreen);

  await appBar.tap();
  await settingsScreen.waitUntilVisible();
  await logoutButton.tap();
  await confirmDialog.waitUntilVisible();
  await confirmButton.tap();
  await loginModeSelectScreen.waitUntilVisible();
}
