import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/app_dependencies.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

import 'components/api_request_log.dart';
import 'components/integration_test_environment_config.dart';
import 'components/render_overflow_tolerance.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

/// Prevents the old duplicated contacts fetch from returning: screen mount
/// and leading polling used to download the same list independently. It also
/// covers manual refresh through the retained polling task.
void main() {
  patrolTest('login and pull share one contacts request path', ($) async {
    final dependencies = await bootstrap();
    final apiLog = ApiRequestLog()..start();
    addTearDown(apiLog.stop);
    // The dev checkout bundles no white-label font assets and bootstrap locks
    // runtime fetching off for production; on the bench the network fetch is
    // the intended substitute.
    GoogleFonts.config.allowRuntimeFetching = true;

    // The compact custom-core screen has a known small layout overflow. Keep
    // its tolerance inside login so Contacts overflows still fail this test.
    await tolerateSmallRenderOverflows(() => _openAndLogin(dependencies, $));
    await pumpFor(const Duration(seconds: 6), $);

    debugPrint('apiLog after login: ${apiLog.describe('/user/contacts')}');
    expectSingleConnectFetch(apiLog.requestsFor('/user/contacts'), 'fresh login', 'the contact list');
    expect(
      apiLog.retriedFor('/user/contacts'),
      isEmpty,
      reason: 'no transport retries are expected for the contact list on login',
    );

    // Phase 2: pull-to-refresh. The gesture must run one worker cycle and,
    // crucially, the indicator must close when the cycle ends - it used to
    // wait for a bloc state change that a finished sync no longer produces.
    await $(MainFlavor.contacts.toNavBarKey()).tap();
    // The sub-tab switcher only exists when several contact sources are
    // configured; with a single external source the list shows right away.
    if ($(contactsTabExtKey).visible) {
      await $(contactsTabExtKey).tap();
    }
    await $(contactsExtContactTileKey).waitUntilVisible();

    final beforePull = DateTime.now();
    await $.tester.fling($(contactsExtContactTileKey).first.finder, const Offset(0, 400), 1200);
    await $.pump();

    final deadline = DateTime.now().add(const Duration(seconds: 15));
    while (find.byType(RefreshProgressIndicator).evaluate().isNotEmpty) {
      if (DateTime.now().isAfter(deadline)) {
        fail('the pull-to-refresh indicator must close when the sync cycle ends');
      }
      await $.pump(const Duration(milliseconds: 100));
    }

    expect(
      apiLog.requestsFor('/user/contacts', since: beforePull).length,
      1,
      reason: 'a pull runs exactly one contact list fetch',
    );
  });
}

Future<void> _openAndLogin(AppDependencies dependencies, PatrolIntegrationTester $) async {
  await pumpRootAndWaitUntilVisible(dependencies, $);
  await loginByMethod($, IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD);
  await $.waitUntilVisible($(AppShell));
}
