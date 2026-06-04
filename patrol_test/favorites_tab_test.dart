import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/features/favorites/widgets/favorite_tile.dart';
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

  patrolTest('Verify favorites functionality', ($) async {
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
    final contactAAlreadyFavorited = $(FavoriteTile).containing(RegExp(contactAUniqueName)).visible;
    final contactBAlreadyFavorited = $(FavoriteTile).containing(RegExp(contactBUniqueName)).visible;

    if (!contactAAlreadyFavorited) {
      await $(MainFlavor.contacts.toNavBarKey()).tap();
      await $(contactsTabExtKey).tap().then((e) => $.pumpAndTrySettle());
      final contactAVisible = $(contactsExtContactTileKey).containing(RegExp(contactAUniqueName)).visible;
      if (!contactAVisible) {
        await $(contactsSerchInputKey).enterText(contactAUniqueName);
        await pumpFor(const Duration(seconds: 1), $);
      }
      await $(contactsExtContactTileKey).containing(RegExp(contactAUniqueName)).tap();
      await $(contactPhoneTileKey).containing(contactAUniqueNumber).waitUntilVisible();
      await $(contactPhoneTileKey).containing(contactAUniqueNumber).$(contactPhoneTileFavIconKey).tap();
      await $(BackButtonIcon).tap();
      if (!contactAVisible) await $(contactsSerchInputClearKey).tap();
    }

    if (!contactBAlreadyFavorited) {
      await $(MainFlavor.contacts.toNavBarKey()).tap();
      await $(contactsTabExtKey).tap().then((e) => $.pumpAndTrySettle());
      final contactBVisible = $(contactsExtContactTileKey).containing(RegExp(contactBUniqueName)).visible;
      if (!contactBVisible) {
        await $(contactsSerchInputKey).enterText(contactBUniqueName);
        await pumpFor(const Duration(seconds: 1), $);
      }
      await $(contactsExtContactTileKey).containing(RegExp(contactBUniqueName)).tap();
      await $(contactPhoneTileKey).containing(contactBUniqueNumber).waitUntilVisible();
      await $(contactPhoneTileKey).containing(contactBUniqueNumber).$(contactPhoneTileFavIconKey).tap();
      await $(BackButtonIcon).tap();
      if (!contactBVisible) await $(contactsSerchInputClearKey).tap();
    }

    // Verify both contacts appear in the favorites tab.
    await $(MainFlavor.favorites.toNavBarKey()).tap();
    await $.pumpAndTrySettle();
    expect(
      $(FavoriteTile).containing(RegExp(contactAUniqueName)),
      findsOneWidget,
      reason: '$contactAUniqueName should be in favorites',
    );
    expect(
      $(FavoriteTile).containing(RegExp(contactBUniqueName)),
      findsOneWidget,
      reason: '$contactBUniqueName should be in favorites',
    );

    // Wait, logout, login again and verify favorites persisted.
    await pumpFor(const Duration(seconds: 5), $);
    await logout($);
    await loginByMethod($, defaultLoginMethod);
    await pumpFor(const Duration(seconds: 5), $);

    await $(MainFlavor.favorites.toNavBarKey()).tap();
    expect(
      $(FavoriteTile).containing(RegExp(contactAUniqueName)),
      findsOneWidget,
      reason: '$contactAUniqueName should still be in favorites after re-login',
    );
    expect(
      $(FavoriteTile).containing(RegExp(contactBUniqueName)),
      findsOneWidget,
      reason: '$contactBUniqueName should still be in favorites after re-login',
    );

    // Open dropdown for contactAUniqueName via three-dots icon, verify all actions, then open View Contact.
    await $(FavoriteTile).containing(RegExp(contactAUniqueName)).$(Icons.more_vert).tap();
    await $.pumpAndTrySettle();
    expect($('Audio call'), findsOneWidget, reason: 'Audio call action should be present');
    expect($('Video call'), findsOneWidget, reason: 'Video call action should be present');
    expect($('View Contact'), findsOneWidget, reason: 'View Contact action should be present');
    expect($('Delete'), findsOneWidget, reason: 'Delete action should be present');
    await $('View Contact').tap();
    await $(contactPhoneTileKey).containing(contactAUniqueNumber).waitUntilVisible();
    expect(
      $(contactPhoneTileKey).containing(contactAUniqueNumber),
      findsOneWidget,
      reason: '$contactAUniqueNumber should be visible in $contactAUniqueName contact detail',
    );
    await $(BackButtonIcon).tap();

    // Open dropdown for contactAUniqueName via three-dots icon, then audio call and hangup after 5 secs.
    await $(FavoriteTile).containing(RegExp(contactAUniqueName)).$(Icons.more_vert).tap();
    await $.pumpAndTrySettle();
    await $('Audio call').tap();
    await $(CallActiveScaffold).waitUntilVisible();
    await pumpFor(const Duration(seconds: 5), $);
    if ($(CallActiveScaffold).visible) await $(callActionsHangupKey).tap();
    await $.pumpAndTrySettle();

    // Open dropdown for contactAUniqueName via three-dots icon again, then delete.
    await $(FavoriteTile).containing(RegExp(contactAUniqueName)).$(Icons.more_vert).tap();
    await $.pumpAndTrySettle();
    await $('Delete').tap();
    await $.pumpAndTrySettle();

    // Open dropdown for contactBUniqueName via long press, verify all actions, then open View Contact.
    await $(FavoriteTile).containing(RegExp(contactBUniqueName)).longPress();
    await $.pumpAndTrySettle();
    expect($('Audio call'), findsOneWidget, reason: 'Audio call action should be present');
    expect($('Video call'), findsOneWidget, reason: 'Video call action should be present');
    expect($('View Contact'), findsOneWidget, reason: 'View Contact action should be present');
    expect($('Delete'), findsOneWidget, reason: 'Delete action should be present');
    await $('View Contact').tap();
    await $(contactPhoneTileKey).containing(contactBUniqueNumber).waitUntilVisible();
    expect(
      $(contactPhoneTileKey).containing(contactBUniqueNumber),
      findsOneWidget,
      reason: '$contactBUniqueNumber should be visible in $contactBUniqueName contact detail',
    );
    await $(BackButtonIcon).tap();

    // Open dropdown for contactBUniqueName via long press, then audio call and hangup after 5 secs.
    await $(FavoriteTile).containing(RegExp(contactBUniqueName)).longPress();
    await $.pumpAndTrySettle();
    await $('Audio call').tap();
    await $(CallActiveScaffold).waitUntilVisible();
    await pumpFor(const Duration(seconds: 5), $);
    if ($(CallActiveScaffold).visible) await $(callActionsHangupKey).tap();
    await $.pumpAndTrySettle();

    // Open dropdown for contactBUniqueName via long press again, then delete.
    await $(FavoriteTile).containing(RegExp(contactBUniqueName)).longPress();
    await $.pumpAndTrySettle();
    await $('Delete').tap();
    await $.pumpAndTrySettle();

    // Verify both are gone from favorites.
    expect(
      $(FavoriteTile).containing(RegExp(contactAUniqueName)),
      findsNothing,
      reason: '$contactAUniqueName should be removed from favorites',
    );
    expect(
      $(FavoriteTile).containing(RegExp(contactBUniqueName)),
      findsNothing,
      reason: '$contactBUniqueName should be removed from favorites',
    );

    // Logout, login again and verify deletion persisted.
    await pumpFor(const Duration(seconds: 5), $);
    await logout($);
    await loginByMethod($, defaultLoginMethod);
    await pumpFor(const Duration(seconds: 5), $);

    await $(MainFlavor.favorites.toNavBarKey()).tap();
    await $.pumpAndTrySettle();
    expect(
      $(FavoriteTile).containing(RegExp(contactAUniqueName)),
      findsNothing,
      reason: '$contactAUniqueName should still be absent from favorites after re-login',
    );
    expect(
      $(FavoriteTile).containing(RegExp(contactBUniqueName)),
      findsNothing,
      reason: '$contactBUniqueName should still be absent from favorites after re-login',
    );

    // Teardowning
    await logout($);
  });
}
