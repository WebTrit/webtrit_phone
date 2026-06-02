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
  const contactAUniqueName = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_NAME;
  const contactAUniqueNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_NUMBER;
  const contactAUniqueExtNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_EXT_NUMBER;
  const contactAUniqueAdditionalNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_ADDITIONAL_NUMBER;
  const contactAUniqueSmsNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_SMS_NUMBER;
  const contactAUniqueEmail = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_EMAIL;
  const contactBUniqueName = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_NAME;
  const contactBUniqueNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_NUMBER;
  const contactBUniqueExtNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_EXT_NUMBER;
  const contactBUniqueAdditionalNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_ADDITIONAL_NUMBER;
  const contactBUniqueSmsNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_SMS_NUMBER;
  const contactBUniqueEmail = IntegrationTestEnvironmentConfig.EXT_CONTACT_B_UNIQUE_EMAIL;

  Future<void> verifyContactDetails(
    PatrolIntegrationTester $, {
    required String contactName,
    required String mainNumber,
    required String extNumber,
    required String additionalNumber,
    required String smsNumber,
    required String email,
  }) async {
    final searchWasUsed = !$(contactsExtContactTileKey).containing(RegExp(contactName)).visible;
    if (searchWasUsed) {
      await $(contactsSerchInputKey).enterText(contactName);
      await pumpFor(const Duration(seconds: 1), $);
    }
    await $(contactsExtContactTileKey).containing(RegExp(contactName)).tap();
    await $(contactPhoneTileKey).waitUntilVisible();

    if (extNumber.isNotEmpty) {
      expect(
        $(contactPhoneTileKey).containing(RegExp('ext')).containing(extNumber),
        findsOneWidget,
        reason: '$contactName should have ext number $extNumber',
      );
    }
    if (mainNumber.isNotEmpty) {
      expect(
        $(contactPhoneTileKey).containing(RegExp('number')).containing(mainNumber),
        findsOneWidget,
        reason: '$contactName should have main number $mainNumber',
      );
    }
    if (additionalNumber.isNotEmpty) {
      expect(
        $(contactPhoneTileKey).containing(RegExp('additional')).containing(additionalNumber),
        findsOneWidget,
        reason: '$contactName should have additional number $additionalNumber',
      );
    }
    if (smsNumber.isNotEmpty) {
      expect(
        $(contactPhoneTileKey).containing(RegExp('sms')).containing(smsNumber),
        findsOneWidget,
        reason: '$contactName should have sms number $smsNumber',
      );
    }
    if (email.isNotEmpty) {
      expect($(contactEmailTileKey).containing(email), findsOneWidget, reason: '$contactName should have email $email');
    }

    // Call using ext number if available, otherwise fall back to main number.
    final callNumber = extNumber.isNotEmpty ? extNumber : mainNumber;
    if (callNumber.isNotEmpty) {
      await $(contactPhoneTileKey).containing(callNumber).$(Icons.call).tap();
      await $(CallActiveScaffold).waitUntilVisible();
      await pumpFor(const Duration(seconds: 5), $);
      if ($(CallActiveScaffold).visible) await $(callActionsHangupKey).tap();
      await $.pumpAndTrySettle();
    }

    await $(BackButtonIcon).tap();
    if (searchWasUsed) await $(contactsSerchInputClearKey).tap();
  }

  patrolTest('Contact details: '
      'verify ext number | '
      'verify main number | '
      'verify additional number | '
      'verify sms number | '
      'verify email | '
      'audio call and hangup', ($) async {
    final instanceRegistry = await bootstrap();
    await pumpRootAndWaitUntilVisible(instanceRegistry, $);

    // Login if not.
    if ($(LoginModeSelectScreen).visible) {
      await loginByMethod($, defaultLoginMethod);
      await pumpFor(const Duration(seconds: 5), $);
    }

    await $(MainFlavor.contacts.toNavBarKey()).tap();
    await $(contactsTabExtKey).tap().then((e) => $.pumpAndTrySettle());

    await verifyContactDetails(
      $,
      contactName: contactAUniqueName,
      mainNumber: contactAUniqueNumber,
      extNumber: contactAUniqueExtNumber,
      additionalNumber: contactAUniqueAdditionalNumber,
      smsNumber: contactAUniqueSmsNumber,
      email: contactAUniqueEmail,
    );
    await verifyContactDetails(
      $,
      contactName: contactBUniqueName,
      mainNumber: contactBUniqueNumber,
      extNumber: contactBUniqueExtNumber,
      additionalNumber: contactBUniqueAdditionalNumber,
      smsNumber: contactBUniqueSmsNumber,
      email: contactBUniqueEmail,
    );

    // Teardowning
    await logout($);
  });
}
