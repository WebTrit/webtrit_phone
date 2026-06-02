import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
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

  patrolTest('Favorites: '
      'add via contact detail | '
      'verify favorites tab | '
      'persist across re-login | '
      'dropdown via three-dots (view contact, call, delete) | '
      'dropdown via long press (view contact, call, delete)', ($) async {
    final instanceRegistry = await bootstrap();
    await pumpRootAndWaitUntilVisible(instanceRegistry, $);

    // Login if not.
    if ($(LoginModeSelectScreen).visible) {
      await loginByMethod($, defaultLoginMethod);
      await pumpFor(const Duration(seconds: 5), $);
    }

    // Check which contacts are already in favorites to avoid double-adding.
    await $(MainFlavor.favorites.toNavBarKey()).tap();
    await $.pumpAndTrySettle();
    final contactAAlreadyFavorited = $(favoriteTileKey).containing(RegExp(uniqueContactAName)).visible;
    final contactBAlreadyFavorited = $(favoriteTileKey).containing(RegExp(uniqueContactBName)).visible;

    if (!contactAAlreadyFavorited) {
      await $(MainFlavor.contacts.toNavBarKey()).tap();
      await $(contactsTabExtKey).tap().then((e) => $.pumpAndTrySettle());
      final contactAVisible = $(contactsExtContactTileKey).containing(RegExp(uniqueContactAName)).visible;
      if (!contactAVisible) {
        await $(contactsSerchInputKey).enterText(uniqueContactAName);
        await pumpFor(const Duration(seconds: 1), $);
      }
      await $(contactsExtContactTileKey).containing(RegExp(uniqueContactAName)).tap();
      await $(contactPhoneTileKey).containing(uniqueContactANumber).waitUntilVisible();
      await $(contactPhoneTileKey).containing(uniqueContactANumber).$(contactPhoneTileFavIconKey).tap();
      await $(BackButtonIcon).tap();
      if (!contactAVisible) await $(contactsSerchInputClearKey).tap();
    }

    if (!contactBAlreadyFavorited) {
      await $(MainFlavor.contacts.toNavBarKey()).tap();
      await $(contactsTabExtKey).tap().then((e) => $.pumpAndTrySettle());
      final contactBVisible = $(contactsExtContactTileKey).containing(RegExp(uniqueContactBName)).visible;
      if (!contactBVisible) {
        await $(contactsSerchInputKey).enterText(uniqueContactBName);
        await pumpFor(const Duration(seconds: 1), $);
      }
      await $(contactsExtContactTileKey).containing(RegExp(uniqueContactBName)).tap();
      await $(contactPhoneTileKey).containing(uniqueContactBNumber).waitUntilVisible();
      await $(contactPhoneTileKey).containing(uniqueContactBNumber).$(contactPhoneTileFavIconKey).tap();
      await $(BackButtonIcon).tap();
      if (!contactBVisible) await $(contactsSerchInputClearKey).tap();
    }

    // Verify both contacts appear in the favorites tab.
    await $(MainFlavor.favorites.toNavBarKey()).tap();
    await $.pumpAndTrySettle();
    expect(
      $(favoriteTileKey).containing(RegExp(uniqueContactAName)),
      findsOneWidget,
      reason: '$uniqueContactAName should be in favorites',
    );
    expect(
      $(favoriteTileKey).containing(RegExp(uniqueContactBName)),
      findsOneWidget,
      reason: '$uniqueContactBName should be in favorites',
    );

    // Wait, logout, login again and verify favorites persisted.
    await pumpFor(const Duration(seconds: 5), $);
    await logout($);
    await loginByMethod($, defaultLoginMethod);
    await pumpFor(const Duration(seconds: 5), $);

    await $(MainFlavor.favorites.toNavBarKey()).tap();
    expect(
      $(favoriteTileKey).containing(RegExp(uniqueContactAName)),
      findsOneWidget,
      reason: '$uniqueContactAName should still be in favorites after re-login',
    );
    expect(
      $(favoriteTileKey).containing(RegExp(uniqueContactBName)),
      findsOneWidget,
      reason: '$uniqueContactBName should still be in favorites after re-login',
    );

    // Open dropdown for uniqueContactAName via three-dots icon, verify all actions, then open View Contact.
    await $(favoriteTileKey).containing(RegExp(uniqueContactAName)).$(Icons.more_vert).tap();
    await $.pumpAndTrySettle();
    expect($('Audio call'), findsOneWidget, reason: 'Audio call action should be present');
    expect($('Video call'), findsOneWidget, reason: 'Video call action should be present');
    expect($('View Contact'), findsOneWidget, reason: 'View Contact action should be present');
    expect($('Delete'), findsOneWidget, reason: 'Delete action should be present');
    await $('View Contact').tap();
    await $(contactPhoneTileKey).containing(uniqueContactANumber).waitUntilVisible();
    expect(
      $(contactPhoneTileKey).containing(uniqueContactANumber),
      findsOneWidget,
      reason: '$uniqueContactANumber should be visible in $uniqueContactAName contact detail',
    );
    await $(BackButtonIcon).tap();

    // Open dropdown for uniqueContactAName via three-dots icon, then audio call and hangup after 5 secs.
    await $(favoriteTileKey).containing(RegExp(uniqueContactAName)).$(Icons.more_vert).tap();
    await $.pumpAndTrySettle();
    await $('Audio call').tap();
    await $(CallActiveScaffold).waitUntilVisible();
    await pumpFor(const Duration(seconds: 5), $);
    if ($(CallActiveScaffold).visible) await $(callActionsHangupKey).tap();
    await $.pumpAndTrySettle();

    // Open dropdown for uniqueContactAName via three-dots icon again, then delete.
    await $(favoriteTileKey).containing(RegExp(uniqueContactAName)).$(Icons.more_vert).tap();
    await $.pumpAndTrySettle();
    await $('Delete').tap();
    await $.pumpAndTrySettle();

    // Open dropdown for uniqueContactBName via long press, verify all actions, then open View Contact.
    await $(favoriteTileKey).containing(RegExp(uniqueContactBName)).longPress();
    await $.pumpAndTrySettle();
    expect($('Audio call'), findsOneWidget, reason: 'Audio call action should be present');
    expect($('Video call'), findsOneWidget, reason: 'Video call action should be present');
    expect($('View Contact'), findsOneWidget, reason: 'View Contact action should be present');
    expect($('Delete'), findsOneWidget, reason: 'Delete action should be present');
    await $('View Contact').tap();
    await $(contactPhoneTileKey).containing(uniqueContactBNumber).waitUntilVisible();
    expect(
      $(contactPhoneTileKey).containing(uniqueContactBNumber),
      findsOneWidget,
      reason: '$uniqueContactBNumber should be visible in $uniqueContactBName contact detail',
    );
    await $(BackButtonIcon).tap();

    // Open dropdown for uniqueContactBName via long press, then audio call and hangup after 5 secs.
    await $(favoriteTileKey).containing(RegExp(uniqueContactBName)).longPress();
    await $.pumpAndTrySettle();
    await $('Audio call').tap();
    await $(CallActiveScaffold).waitUntilVisible();
    await pumpFor(const Duration(seconds: 5), $);
    if ($(CallActiveScaffold).visible) await $(callActionsHangupKey).tap();
    await $.pumpAndTrySettle();

    // Open dropdown for uniqueContactBName via long press again, then delete.
    await $(favoriteTileKey).containing(RegExp(uniqueContactBName)).longPress();
    await $.pumpAndTrySettle();
    await $('Delete').tap();
    await $.pumpAndTrySettle();

    // Verify both are gone from favorites.
    expect(
      $(favoriteTileKey).containing(RegExp(uniqueContactAName)),
      findsNothing,
      reason: '$uniqueContactAName should be removed from favorites',
    );
    expect(
      $(favoriteTileKey).containing(RegExp(uniqueContactBName)),
      findsNothing,
      reason: '$uniqueContactBName should be removed from favorites',
    );

    // Logout, login again and verify deletion persisted.
    await pumpFor(const Duration(seconds: 5), $);
    await logout($);
    await loginByMethod($, defaultLoginMethod);
    await pumpFor(const Duration(seconds: 5), $);

    await $(MainFlavor.favorites.toNavBarKey()).tap();
    await $.pumpAndTrySettle();
    expect(
      $(favoriteTileKey).containing(RegExp(uniqueContactAName)),
      findsNothing,
      reason: '$uniqueContactAName should still be absent from favorites after re-login',
    );
    expect(
      $(favoriteTileKey).containing(RegExp(uniqueContactBName)),
      findsNothing,
      reason: '$uniqueContactBName should still be absent from favorites after re-login',
    );

    // Teardowning
    await logout($);
  });
}
