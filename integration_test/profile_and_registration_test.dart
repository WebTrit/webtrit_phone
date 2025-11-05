import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/extensions/session_status.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/features/settings/widgets/widgets.dart';
import 'package:webtrit_phone/models/session_status.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const accountName = IntegrationTestEnvironmentConfig.ACCOUNT_NAME;
  const accountMainNumber = IntegrationTestEnvironmentConfig.ACCOUNT_MAIN_NUMBER;

  patrolTest('Should show correct profile data and perform sip registration', ($) async {
    await bootstrap();
    await pumpRootAndWaitUntilVisible($);

    // Login if not.
    if ($(LoginModeSelectScreen).visible) {
      await loginByMethod($, defaultLoginMethod);
      // Wait some time for components loading and session establishment.
      await pumpFor(const Duration(seconds: 5), $);
    }

    // Open profile screen and check if the profile data is correct.
    await $(mainAppBarKey).tap();
    await pumpFor(const Duration(seconds: 2), $);
    expect($(UserInfoListTile).$(accountName), findsOneWidget, reason: 'Verify account name');
    expect($(UserInfoListTile).$(accountMainNumber), findsOneWidget, reason: 'Verify account main number');
    expect($(SessionStatus.ready.key), findsOneWidget, reason: 'Should be registered');

    // Check manual sip registration.
    await $(SwitchListTile).tap();
    await pumpFor(const Duration(seconds: 2), $);
    expect($(SessionStatus.appUnregistered.key), findsOneWidget, reason: 'Should unregister sip session');
    await $(SwitchListTile).tap();
    await pumpFor(const Duration(seconds: 2), $);
    expect($(SessionStatus.ready.key), findsOneWidget, reason: 'Should register sip session');
  });
}
