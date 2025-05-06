import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

import 'components/integration_test_environment_config.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

main() {
  final defaultLoginMethod = IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD;

  patrolTest(
    'Should show contacts list, search it and add to favorites',
    ($) async {
      await bootstrap();
      await pumpRootAndWaitUntilVisible($);

      // Login if not.
      if ($(LoginModeSelectScreen).visible) {
        await loginByMethod($, defaultLoginMethod);
        // Wait some time for components loading and session establishment.
        await pumpFor(const Duration(seconds: 5), $);
      }

      // Go to the contacts tab.
      await $(MainFlavor.contacts.toNavBarKey()).tap();

      // Check if has some local contacts.
      await $(contactsTabLocalKey).tap().then((e) => $.pumpAndTrySettle());
      expect($(contactsLocalContactTileKey), findsNothing, reason: 'Local contacts shouldnt be');

      // Check if has some external contacts.
      await $(contactsTabExtKey).tap().then((e) => $.pumpAndTrySettle());
      expect($(contactsExtContactTileKey), findsAny, reason: 'External contacts should be');

      const contactA = IntegrationTestEnvironmentConfig.WEBTRIT_APP_TEST_EXT_CONTACT_A;
      const contactANumber = IntegrationTestEnvironmentConfig.WEBTRIT_APP_TEST_EXT_CONTACT_A_NUMBER;
      const contactB = IntegrationTestEnvironmentConfig.WEBTRIT_APP_TEST_EXT_CONTACT_B;
      const contactBNumber = IntegrationTestEnvironmentConfig.WEBTRIT_APP_TEST_EXT_CONTACT_B_NUMBER;

      // Check if search of contactA works.
      await $(contactsSerchInputKey).enterText(contactA);
      await pumpFor(const Duration(seconds: 1), $);
      expect($(contactsExtContactTileKey).containing(contactA), findsOneWidget, reason: '$contactA should present');
      expect($(contactsExtContactTileKey).containing(contactB), findsNothing, reason: '$contactB shouldnt present');
      await $(contactsSerchInputClearKey).tap();

      // Check if search of contactB works.
      await $(contactsSerchInputKey).enterText(contactB);
      await pumpFor(const Duration(seconds: 1), $);
      expect($(contactsExtContactTileKey).containing(contactB), findsOneWidget, reason: '$contactB should present');
      expect($(contactsExtContactTileKey).containing(contactA), findsNothing, reason: '$contactA shouldnt present');
      await $(contactsSerchInputClearKey).tap();

      // Open contactA and add number to favorites.
      await $(contactsExtContactTileKey).containing(contactA).tap();
      await $(contactPhoneTileKey).containing(contactANumber).waitUntilVisible();
      await $(contactPhoneTileKey).containing(contactANumber).$(contactPhoneTileFavIconKey).tap();
      await $.native.pressBack().then((e) => $.pumpAndTrySettle());

      // Open contactB and add number to favorites.
      await $(contactsExtContactTileKey).containing(contactB).tap();
      await $(contactPhoneTileKey).containing(contactBNumber).waitUntilVisible();
      await $(contactPhoneTileKey).containing(contactBNumber).$(contactPhoneTileFavIconKey).tap();
      await $.native.pressBack().then((e) => $.pumpAndTrySettle());

      await $(MainFlavor.favorites.toNavBarKey()).tap();
      expect($(favoriteTileKey).containing(contactA), findsOneWidget, reason: '$contactB should favorited');
      expect($(favoriteTileKey).containing(contactB), findsOneWidget, reason: '$contactA should favorited');
      await pumpFor(const Duration(seconds: 1), $);
    },
  );
}
