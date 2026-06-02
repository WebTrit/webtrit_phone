import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/logout.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

void main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;
  const uniqueContactAName = IntegrationTestEnvironmentConfig.EXT_CONTACT_UNIQUE_A_NAME;
  const uniqueContactANumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_UNIQUE_A_NUMBER;
  const uniqueContactBName = IntegrationTestEnvironmentConfig.EXT_CONTACT_UNIQUE_B_NAME;
  const uniqueContactBNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_UNIQUE_B_NUMBER;
  const multiSearchQuery = IntegrationTestEnvironmentConfig.EXT_CONTACT_MULTI_SEARCH_QUERY;

  patrolTest('External contact tab test: '
  'inner tab swtitching |'
  'search by name and number |'
  'contact details navigate', ($) async {
    final instanceRegistry = await bootstrap();
    await pumpRootAndWaitUntilVisible(instanceRegistry, $);

    // Login if not.
    if ($(LoginModeSelectScreen).visible) {
      await loginByMethod($, defaultLoginMethod);
      // Wait some time for components loading and session establishment.
      await pumpFor(const Duration(seconds: 5), $);
    }

    // Go to the contacts tab.
    await $(MainFlavor.contacts.toNavBarKey()).tap();

    // Check inner tabs switching.
    await $(contactsTabLocalKey).tap().then((e) => $.pumpAndTrySettle());
    expect(
      $(contactsExtContactTileKey),
      findsNothing,
      reason: 'External contacts shouldnt be visible if local tab is selected',
    );
    await $(contactsTabExtKey).tap().then((e) => $.pumpAndTrySettle());
    expect(
      $(contactsExtContactTileKey),
      findsAny,
      reason: 'External contacts should be visible if external tab is selected',
    );

    // Check if search with a query matching multiple contacts returns more than one result.
    await $(contactsSerchInputKey).enterText(multiSearchQuery);
    await pumpFor(const Duration(seconds: 1), $);
    expect(
      $(contactsExtContactTileKey),
      findsAtLeastNWidgets(2),
      reason: '$multiSearchQuery should match multiple contacts with same name part',
    );
    await $(contactsSerchInputClearKey).tap();

    // Check if search of uniqueContactAName returns exactly one result, then verify number in detail.
    await $(contactsSerchInputKey).enterText(uniqueContactAName);
    await pumpFor(const Duration(seconds: 1), $);
    expect(
      $(contactsExtContactTileKey).containing(RegExp(uniqueContactAName)),
      findsOneWidget,
      reason: '$uniqueContactAName should present if name match',
    );
    expect(
      $(contactsExtContactTileKey).containing(RegExp(uniqueContactBName)),
      findsNothing,
      reason: '$uniqueContactBName shouldnt present if name match',
    );
    await $(contactsExtContactTileKey).containing(RegExp(uniqueContactAName)).tap();
    await $(contactPhoneTileKey).containing(uniqueContactANumber).waitUntilVisible();
    expect(
      $(contactPhoneTileKey).containing(uniqueContactANumber),
      findsOneWidget,
      reason: '$uniqueContactANumber should be visible in $uniqueContactAName detail',
    );
    await $(BackButtonIcon).tap();
    await $(contactsSerchInputClearKey).tap();

    // Check if search of uniqueContactANumber returns exactly one result, then verify name in result.
    await $(contactsSerchInputKey).enterText(uniqueContactANumber);
    await pumpFor(const Duration(seconds: 1), $);
    expect(
      $(contactsExtContactTileKey).containing(RegExp(uniqueContactAName)),
      findsOneWidget,
      reason: '$uniqueContactAName should present if number match',
    );
    expect(
      $(contactsExtContactTileKey).containing(RegExp(uniqueContactBName)),
      findsNothing,
      reason: '$uniqueContactBName shouldnt present if number match',
    );
    await $(contactsSerchInputClearKey).tap();

    // Check if search of uniqueContactBName returns exactly one result, then verify number in detail.
    await $(contactsSerchInputKey).enterText(uniqueContactBName);
    await pumpFor(const Duration(seconds: 1), $);
    expect(
      $(contactsExtContactTileKey).containing(RegExp(uniqueContactBName)),
      findsOneWidget,
      reason: '$uniqueContactBName should present if name match',
    );
    expect(
      $(contactsExtContactTileKey).containing(RegExp(uniqueContactAName)),
      findsNothing,
      reason: '$uniqueContactAName shouldnt present if name match',
    );
    await $(contactsExtContactTileKey).containing(RegExp(uniqueContactBName)).tap();
    await $(contactPhoneTileKey).containing(uniqueContactBNumber).waitUntilVisible();
    expect(
      $(contactPhoneTileKey).containing(uniqueContactBNumber),
      findsOneWidget,
      reason: '$uniqueContactBNumber should be visible in $uniqueContactBName detail',
    );
    await $(BackButtonIcon).tap();
    await $(contactsSerchInputClearKey).tap();

    // Check if search of uniqueContactBNumber returns exactly one result, then verify name in result.
    await $(contactsSerchInputKey).enterText(uniqueContactBNumber);
    await pumpFor(const Duration(seconds: 1), $);
    expect(
      $(contactsExtContactTileKey).containing(RegExp(uniqueContactBName)),
      findsOneWidget,
      reason: '$uniqueContactBName should present if number match',
    );
    expect(
      $(contactsExtContactTileKey).containing(RegExp(uniqueContactAName)),
      findsNothing,
      reason: '$uniqueContactAName shouldnt present if number match',
    );
    await $(contactsSerchInputClearKey).tap();

    // Teardowning
    await logout($);
  });
}
