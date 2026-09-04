import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/bootstrap.dart';

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
    final apiLog = _ApiRequestLog()..start();
    addTearDown(apiLog.stop);
    // The dev checkout bundles no white-label font assets and bootstrap locks
    // runtime fetching off for production; on the bench the network fetch is
    // the intended substitute.
    GoogleFonts.config.allowRuntimeFetching = true;
    await pumpRootAndWaitUntilVisible(dependencies, $);
    await loginByMethod($, IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD);
    await $.waitUntilVisible($(AppShell));
    await pumpFor(const Duration(seconds: 6), $);

    debugPrint('apiLog after login: ${apiLog.describe()}');
    _expectSingleConnectFetch(apiLog.userInfoRequests(), 'fresh login');
    expect(apiLog.retriedRequests(), isEmpty, reason: 'no transport retries are expected on login');

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

    debugPrint('apiLog after resume: ${apiLog.describe()}');
    _expectSingleConnectFetch(apiLog.userInfoRequests(since: backgroundedAt), 'resume');

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
      () => apiLog.userInfoRequests(since: offlineAt).isNotEmpty,
      timeout: const Duration(seconds: 40),
      description: 'polling must recover after the network returns',
    );
    await pumpFor(const Duration(seconds: 5), $);

    debugPrint('apiLog after recovery at $recoveredAt: ${apiLog.describe()}');
    _expectSingleConnectFetch(apiLog.userInfoRequests(since: offlineAt), 'network recovery');
  });
}

/// The connect invariant, anchored to the requests themselves rather than to
/// UI timing: the phase saw at least one user info fetch, and no two fetches
/// arrived closer than the duplicate window. Legitimate periodic ticks are 10
/// seconds apart and pass; the duplicates from the investigated bug arrived
/// within 0.2-4 seconds of each other and fail.
void _expectSingleConnectFetch(List<_ApiRequest> requests, String phase) {
  expect(requests, isNotEmpty, reason: '$phase must fetch user info');
  for (var i = 1; i < requests.length; i++) {
    final gap = requests[i].time.difference(requests[i - 1].time);
    expect(
      gap,
      greaterThanOrEqualTo(const Duration(seconds: 8)),
      reason: '$phase fired user info requests ${gap.inMilliseconds} ms apart - a duplicate, not a periodic tick',
    );
  }
}

/// One HTTP request observed through the api client's request log line.
class _ApiRequest {
  _ApiRequest(this.time, this.attempt, this.path);

  final DateTime time;
  final int attempt;
  final String path;
}

class _ApiRequestLog {
  static final _requestLine = RegExp(r'([A-Z]+) request\((\d+)\) to (\S+) with requestId');

  final _requests = <_ApiRequest>[];
  StreamSubscription<LogRecord>? _subscription;
  int recordsSeen = 0;
  int clientRecordsSeen = 0;

  void start() {
    _subscription = Logger.root.onRecord.listen((record) {
      recordsSeen++;
      if (record.loggerName != 'WebtritApiClient') return;
      clientRecordsSeen++;
      final match = _requestLine.firstMatch(record.message);
      if (match == null) return;
      _requests.add(_ApiRequest(record.time, int.parse(match.group(2)!), Uri.parse(match.group(3)!).path));
    });
  }

  String describe() =>
      'records=$recordsSeen client=$clientRecordsSeen '
      'userInfo=${userInfoRequests().map((r) => r.time.toIso8601String()).toList()}';

  Future<void> stop() async => _subscription?.cancel();

  /// First-attempt GET /user requests within [since, until).
  List<_ApiRequest> userInfoRequests({DateTime? since, DateTime? until}) => _requests
      .where((r) => r.path.endsWith('/user') && r.attempt == 0)
      .where((r) => since == null || !r.time.isBefore(since))
      .where((r) => until == null || r.time.isBefore(until))
      .toList();

  /// User info requests that went through the transport retry loop. Other
  /// endpoints may legitimately retry (e.g. the login screen probing an
  /// unreachable preset core URL in the background).
  List<_ApiRequest> retriedRequests() => _requests.where((r) => r.attempt > 0 && r.path.endsWith('/user')).toList();
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
