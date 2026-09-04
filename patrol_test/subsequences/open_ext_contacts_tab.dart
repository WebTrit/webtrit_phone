import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

/// Opens the external contacts list from the bottom navigation, on either
/// contacts screen layout: the sub-tab switcher only exists when several
/// contact sources are configured - with a single external source the list
/// shows right away.
Future<void> openExtContactsTab(PatrolIntegrationTester $) async {
  await $(MainFlavor.contacts.toNavBarKey()).tap();
  if ($(contactsTabExtKey).visible) {
    await $(contactsTabExtKey).tap();
  }
  await $(contactsExtContactTileKey).waitUntilVisible();
}

/// Reveals the contacts search box: the filter-style screen hides it behind
/// a button, the classic screen pins it open.
Future<void> openContactsSearch(PatrolIntegrationTester $) async {
  if (!$(contactsSearchInputKey).visible) {
    await $(contactsSearchOpenKey).tap();
  }
  await $(contactsSearchInputKey).waitUntilVisible();
}
