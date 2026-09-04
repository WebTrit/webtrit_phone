import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/bootstrap.dart';

import 'components/api_request_log.dart';
import 'components/integration_test_environment_config.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';

/// Verifies the connect invariant: every "app connect" event - fresh login,
/// resume from background, network recovery - fires the user info request
/// exactly once, with no transport retries and no back-to-back duplicates.
///
/// The oracle is the api client's own request log line
/// (`GET request(0) to ... with requestId: ...`) observed in-process via
/// [Logger.root], the same signal the on-device investigation counted.
///
/// The contacts list is deliberately not asserted here: its mount fetch still
/// overlaps the polling cycle until that pair is deduplicated, so only the
/// user info endpoint carries a strict single-request invariant today.
void main() {
  patrolTest('each connect event fires the user info request exactly once', ($) async {
    // Phase 1: fresh login. From app start until the main shell settles there
    // must be exactly one user info request.
    final dependencies = await bootstrap();
    // Subscribe only after bootstrap: AppLogger.init inside it clears all
    // root logger listeners, which would silently drop an earlier oracle.
    final apiLog = ApiRequestLog()..start();
    addTearDown(apiLog.stop);
    // The dev checkout bundles no white-label font assets and bootstrap locks
    // runtime fetching off for production; on the bench the network fetch is
    // the intended substitute.
    GoogleFonts.config.allowRuntimeFetching = true;
    await pumpRootAndWaitUntilVisible(dependencies, $);
    await loginByMethod($, IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD);
    await $.waitUntilVisible($(AppShell));
    await pumpFor(const Duration(seconds: 6), $);

    debugPrint('apiLog after login: ${apiLog.describe('/user')}');
    expectSingleConnectFetch(apiLog.requestsFor('/user'), 'fresh login', 'user info');
    expect(apiLog.retriedFor('/user'), isEmpty, reason: 'no transport retries are expected on login');

    // Phase 2: resume from background. The marker is taken after the app is
    // already backgrounded, so a periodic tick cannot leak into the window;
    // the resume leading cycle must then be the only user info request.
    await $.platformAutomator.mobile.pressHome();
    // No pumping while backgrounded: frames are paused and $.pump() never
    // returns, but plain timers keep running in the isolate.
    await Future<void>.delayed(const Duration(seconds: 3));
    final backgroundedAt = DateTime.now();
    await $.platformAutomator.mobile.openApp();
    await $.waitUntilVisible($(AppShell));
    await pumpFor(const Duration(seconds: 6), $);

    debugPrint('apiLog after resume: ${apiLog.describe('/user')}');
    expectSingleConnectFetch(apiLog.requestsFor('/user', since: backgroundedAt), 'resume', 'user info');

    // Phase 3: network flap and recovery. Going offline must stop polling,
    // and coming back online must restart it with a single leading request -
    // not a burst and not a permanently silent poller.
    // Wifi and cellular toggles run through the shell (`svc`), unlike the
    // airplane-mode helper which drives the quick-settings UI and does not
    // find its tile on this device.
    await $.platformAutomator.mobile.disableWifi();
    await $.platformAutomator.mobile.disableCellular();
    await pumpFor(const Duration(seconds: 5), $);
    final offlineAt = DateTime.now();
    await $.platformAutomator.mobile.enableWifi();
    await $.platformAutomator.mobile.enableCellular();

    final recoveredAt = await _waitFor(
      $,
      () => apiLog.requestsFor('/user', since: offlineAt).isNotEmpty,
      timeout: const Duration(seconds: 40),
      description: 'polling must recover after the network returns',
    );
    await pumpFor(const Duration(seconds: 5), $);

    debugPrint('apiLog after recovery at $recoveredAt: ${apiLog.describe('/user')}');
    expectSingleConnectFetch(apiLog.requestsFor('/user', since: offlineAt), 'network recovery', 'user info');
  });
}

Future<DateTime> _waitFor(
  PatrolIntegrationTester $,
  bool Function() condition, {
  required Duration timeout,
  required String description,
}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail(description);
    }
    await pumpFor(const Duration(seconds: 1), $);
  }
  return DateTime.now();
}
