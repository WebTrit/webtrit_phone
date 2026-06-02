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
  const contactAUniqueName = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_NAME;
  const contactAUniqueNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_NUMBER;
  const contactBUniqueName = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_NAME;
  const contactBUniqueNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_NUMBER;
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

    // Check if search of contactAUniqueName returns exactly one result, then verify number in detail.
    await $(contactsSerchInputKey).enterText(contactAUniqueName);
    await pumpFor(const Duration(seconds: 1), $);
    expect(
      $(contactsExtContactTileKey).containing(RegExp(contactAUniqueName)),
      findsOneWidget,
      reason: '$contactAUniqueName should present if name match',
    );
    expect(
      $(contactsExtContactTileKey).containing(RegExp(contactBUniqueName)),
      findsNothing,
      reason: '$contactBUniqueName shouldnt present if name match',
    );
    await $(contactsExtContactTileKey).containing(RegExp(contactAUniqueName)).tap();
    await $(contactPhoneTileKey).containing(contactAUniqueNumber).waitUntilVisible();
    expect(
      $(contactPhoneTileKey).containing(contactAUniqueNumber),
      findsOneWidget,
      reason: '$contactAUniqueNumber should be visible in $contactAUniqueName detail',
    );
    await $(BackButtonIcon).tap();
    await $(contactsSerchInputClearKey).tap();

    // Check if search of contactAUniqueNumber returns exactly one result, then verify name in result.
    await $(contactsSerchInputKey).enterText(contactAUniqueNumber);
    await pumpFor(const Duration(seconds: 1), $);
    expect(
      $(contactsExtContactTileKey).containing(RegExp(contactAUniqueName)),
      findsOneWidget,
      reason: '$contactAUniqueName should present if number match',
    );
    expect(
      $(contactsExtContactTileKey).containing(RegExp(contactBUniqueName)),
      findsNothing,
      reason: '$contactBUniqueName shouldnt present if number match',
    );
    await $(contactsSerchInputClearKey).tap();

    // Check if search of contactBUniqueName returns exactly one result, then verify number in detail.
    await $(contactsSerchInputKey).enterText(contactBUniqueName);
    await pumpFor(const Duration(seconds: 1), $);
    expect(
      $(contactsExtContactTileKey).containing(RegExp(contactBUniqueName)),
      findsOneWidget,
      reason: '$contactBUniqueName should present if name match',
    );
    expect(
      $(contactsExtContactTileKey).containing(RegExp(contactAUniqueName)),
      findsNothing,
      reason: '$contactAUniqueName shouldnt present if name match',
    );
    await $(contactsExtContactTileKey).containing(RegExp(contactBUniqueName)).tap();
    await $(contactPhoneTileKey).containing(contactBUniqueNumber).waitUntilVisible();
    expect(
      $(contactPhoneTileKey).containing(contactBUniqueNumber),
      findsOneWidget,
      reason: '$contactBUniqueNumber should be visible in $contactBUniqueName detail',
    );
    await $(BackButtonIcon).tap();
    await $(contactsSerchInputClearKey).tap();

    // Check if search of contactBUniqueNumber returns exactly one result, then verify name in result.
    await $(contactsSerchInputKey).enterText(contactBUniqueNumber);
    await pumpFor(const Duration(seconds: 1), $);
    expect(
      $(contactsExtContactTileKey).containing(RegExp(contactBUniqueName)),
      findsOneWidget,
      reason: '$contactBUniqueName should present if number match',
    );
    expect(
      $(contactsExtContactTileKey).containing(RegExp(contactAUniqueName)),
      findsNothing,
      reason: '$contactAUniqueName shouldnt present if number match',
    );
    await $(contactsSerchInputClearKey).tap();

    // Teardowning
    await logout($);
  });
}
