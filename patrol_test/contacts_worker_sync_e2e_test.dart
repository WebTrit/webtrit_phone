import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'components/allow_test_font_fetching.dart';
import 'components/api_request_log.dart';
import 'components/integration_test_environment_config.dart';
import 'components/render_overflow_tolerance.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/open_ext_contacts_tab.dart';
import 'subsequences/logout.dart';
import 'subsequences/pull_to_refresh.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';
import 'subsequences/wait_until.dart';
import 'subsequences/with_network_disabled.dart';

// One wait policy for the whole file.
const _connectSettle = Duration(seconds: 6);
const _searchSettle = Duration(seconds: 2);
const _backgroundDwell = Duration(seconds: 3);
const _networkSettle = Duration(seconds: 3);
const _offlinePullTimeout = Duration(seconds: 30);
const _recoveryTimeout = Duration(seconds: 40);

/// Covers the external contacts sync worker end to end on a real device:
///
/// 1. A fresh login runs exactly one contact list fetch with no transport
///    retries, and the fetched list is actually merged into the local store
///    the screen reads.
/// 2. Searching the own number finds nothing while searching a known
///    contact's number does - the on-device half of the self-filter story;
///    the filter itself, with the account present in the payload, is pinned
///    by the worker's unit tests.
/// 3. A pull-to-refresh runs exactly one fetch and its indicator closes
///    when the cycle ends.
/// 4. A resume from background runs exactly one leading fetch.
/// 5. A pull while offline does not hang the indicator, and the sync
///    recovers with a single fetch once the network returns.
void main() {
  const contactName = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_NAME;
  const contactNumber = IntegrationTestEnvironmentConfig.EXT_CONTACT_A_UNIQUE_NUMBER;
  const ownNumber = IntegrationTestEnvironmentConfig.ACCOUNT_MAIN_NUMBER;

  patrolTest('the contacts sync worker drives every contact flow', ($) async {
    tolerateRenderOverflow();
    allowTestFontFetching();

    // Unset defines degrade to empty strings and would make the search
    // phases pass without testing anything - fail loudly instead.
    expect(contactName, isNotEmpty, reason: 'EXT_CONTACT_A_UNIQUE_NAME must be configured');
    expect(contactNumber, isNotEmpty, reason: 'EXT_CONTACT_A_UNIQUE_NUMBER must be configured');
    expect(ownNumber, isNotEmpty, reason: 'ACCOUNT_MAIN_NUMBER must be configured');
    // The exact-count assertions below assume no periodic tick can land
    // inside a phase window; state the dependency instead of betting on it.
    expect(
      EnvironmentConfig.EXTERNAL_CONTACTS_REPOSITORY_POLLING_INTERVAL_SECONDS,
      greaterThanOrEqualTo(45),
      reason: 'the phase windows assume the contacts polling interval stays above them',
    );

    final dependencies = await bootstrap();
    final apiLog = ApiRequestLog()..start();
    addTearDown(apiLog.stop);

    // Phase 1: fresh login - one fetch, no retries, data reaches the screen.
    debugPrint('phase 1: fresh login');
    await pumpRootAndWaitUntilVisible(dependencies, $);
    expect(
      $(LoginModeSelectScreen).visible,
      isTrue,
      reason: 'phase 1 needs a fresh install: a leftover session would skip the login connect event',
    );
    await loginByMethod($, IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD);
    await $.waitUntilVisible($(AppShell));
    await pumpFor(_connectSettle, $);

    expectSingleConnectFetch(apiLog.requestsFor('/user/contacts'), 'fresh login', 'the contact list');
    expect(
      apiLog.retriedFor('/user/contacts'),
      isEmpty,
      reason: 'no transport retries are expected for the contact list on login',
    );

    await openExtContactsTab($);

    // Phase 2: number search finds a known contact but not the own number.
    debugPrint('phase 2: self-filter search');
    await openContactsSearch($);
    await $(contactsSearchInputKey).enterText(contactNumber);
    await pumpFor(_searchSettle, $);
    await $(contactsExtContactTileKey).containing(RegExp(RegExp.escape(contactName))).waitUntilVisible();
    await $(contactsSearchInputClearKey).tap();

    await $(contactsSearchInputKey).enterText(ownNumber);
    await pumpFor(_searchSettle, $);
    expect(
      $(contactsExtContactTileKey),
      findsNothing,
      reason: 'the own number must be filtered out of the synced list',
    );
    await $(contactsSearchInputClearKey).tap();
    await $(contactsExtContactTileKey).waitUntilVisible();

    // Phase 3: pull-to-refresh - one fetch, indicator closes with the cycle.
    debugPrint('phase 3: pull-to-refresh');
    final beforePull = DateTime.now();
    await pullToRefresh(
      $,
      $(contactsExtContactTileKey),
      closeReason: 'the pull indicator must close when the sync cycle ends',
    );
    expect(
      apiLog.requestsFor('/user/contacts', since: beforePull).length,
      1,
      reason: 'a pull runs exactly one contact list fetch',
    );

    // Phase 4: resume from background - one leading fetch.
    debugPrint('phase 4: resume from background');
    await $.platformAutomator.mobile.pressHome();
    // No pumping while backgrounded: frames are paused and $.pump() never
    // returns, but plain timers keep running in the isolate.
    await Future<void>.delayed(_backgroundDwell);
    final backgroundedAt = DateTime.now();
    await $.platformAutomator.mobile.openApp();
    await $.waitUntilVisible($(AppShell));
    await pumpFor(_connectSettle, $);
    expectSingleConnectFetch(apiLog.requestsFor('/user/contacts', since: backgroundedAt), 'resume', 'the contact list');

    // Phase 5: a pull while offline must not hang, and the network's return
    // brings exactly one recovering fetch.
    debugPrint('phase 5: offline pull and recovery');
    var offlineAt = DateTime.now();
    await withNetworkDisabled($, () async {
      await pumpFor(_networkSettle, $);
      await pullToRefresh(
        $,
        $(contactsExtContactTileKey),
        // The offline fetch may walk its full transport retry chain before
        // failing, which takes longer than an online cycle.
        closeTimeout: _offlinePullTimeout,
        closeReason: 'the pull indicator must close even when the fetch fails offline',
      );
      offlineAt = DateTime.now();
    });

    await waitUntil(
      $,
      () => apiLog.requestsFor('/user/contacts', since: offlineAt).isNotEmpty,
      timeout: _recoveryTimeout,
      description: 'the contacts sync must recover after the network returns',
      step: const Duration(seconds: 1),
    );
    await pumpFor(_connectSettle, $);
    expectSingleConnectFetch(
      apiLog.requestsFor('/user/contacts', since: offlineAt),
      'network recovery',
      'the contact list',
    );

    await logout($);
  });
}
