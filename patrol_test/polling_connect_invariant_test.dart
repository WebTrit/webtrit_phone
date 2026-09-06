import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/bootstrap.dart';

import 'components/api_request_log.dart';
import 'components/integration_test_environment_config.dart';
import 'components/render_overflow_tolerance.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/pump_for.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';
import 'subsequences/wait_until.dart';
import 'subsequences/with_network_disabled.dart';

/// Verifies the connect invariant: every "app connect" event - fresh login,
/// resume from background, network recovery - fires the user info request
/// exactly once, with no transport retries and no back-to-back duplicates.
///
/// The oracle is the api client's own request log line
/// (`GET request(0) to ... with requestId: ...`) observed in-process via
/// [Logger.root], the same signal the on-device investigation counted.
///
/// Contacts uses the same lifecycle but is deliberately covered by the
/// separate worker-sync E2E, keeping this guard focused on user info.
void main() {
  patrolTest('each connect event fires the user info request exactly once', ($) async {
    // Phase 1: fresh login. From app start until the main shell settles there
    // must be exactly one user info request.
    final dependencies = await bootstrap();
    // Subscribe only after bootstrap: AppLogger.init inside it clears all
    // root logger listeners, which would silently drop an earlier oracle.
    final apiLog = ApiRequestLog()..start();
    addTearDown(apiLog.stop);
    await pumpRootAndWaitUntilVisible(dependencies, $);
    await tolerateSmallRenderOverflows(() => _login($));
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
    final offlineAt = await withNetworkDisabled($, () => _waitWhileOffline($));

    final recoveredAt = await waitUntil(
      $,
      () => apiLog.requestsFor('/user', since: offlineAt).isNotEmpty,
      timeout: const Duration(seconds: 40),
      description: 'polling must recover after the network returns',
      step: const Duration(seconds: 1),
    );
    await pumpFor(const Duration(seconds: 5), $);

    debugPrint('apiLog after recovery at $recoveredAt: ${apiLog.describe('/user')}');
    expectSingleConnectFetch(apiLog.requestsFor('/user', since: offlineAt), 'network recovery', 'user info');
  });
}

Future<void> _login(PatrolIntegrationTester $) async {
  await loginByMethod($, IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD);
  await $.waitUntilVisible($(AppShell));
}

Future<DateTime> _waitWhileOffline(PatrolIntegrationTester $) async {
  await pumpFor(const Duration(seconds: 5), $);
  return DateTime.now();
}
