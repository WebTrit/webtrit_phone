import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
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
    final apiLog = _ApiRequestLog()..start();
    addTearDown(apiLog.stop);

    // Phase 1: fresh login. From app start until the main shell settles there
    // must be exactly one user info request.
    final instanceRegistry = await bootstrap();
    await pumpRootAndWaitUntilVisible(instanceRegistry, $);
    await loginByMethod($, IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD);
    await $.waitUntilVisible($(AppShell));
    await pumpFor(const Duration(seconds: 6), $);

    expect(apiLog.userInfoRequests().length, 1, reason: 'a fresh login must fetch user info exactly once');
    expect(apiLog.retriedRequests(), isEmpty, reason: 'no transport retries are expected on login');

    // Phase 2: resume from background. The marker is taken after the app is
    // already backgrounded, so a periodic tick cannot leak into the window;
    // the resume leading cycle must then be the only user info request.
    await $.platformAutomator.mobile.pressHome();
    await pumpFor(const Duration(seconds: 3), $);
    final backgroundedAt = DateTime.now();
    await $.platformAutomator.mobile.openApp();
    await $.waitUntilVisible($(AppShell));
    await pumpFor(const Duration(seconds: 6), $);

    expect(
      apiLog.userInfoRequests(since: backgroundedAt).length,
      1,
      reason: 'a resume must fetch user info exactly once',
    );

    // Phase 3: network flap and recovery. Going offline must stop polling,
    // and coming back online must restart it with a single leading request -
    // not a burst and not a permanently silent poller.
    await $.platformAutomator.mobile.enableAirplaneMode();
    await pumpFor(const Duration(seconds: 5), $);
    final offlineAt = DateTime.now();
    await $.platformAutomator.mobile.disableAirplaneMode();

    final recoveredAt = await _waitFor(
      $,
      () => apiLog.userInfoRequests(since: offlineAt).isNotEmpty,
      timeout: const Duration(seconds: 40),
      description: 'polling must recover after the network returns',
    );
    await pumpFor(const Duration(seconds: 5), $);

    final burstWindow = recoveredAt.add(const Duration(seconds: 4));
    expect(
      apiLog.userInfoRequests(since: offlineAt, until: burstWindow).length,
      1,
      reason: 'network recovery must run one leading cycle, not a burst',
    );
  });
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

  void start() {
    _subscription = Logger.root.onRecord.listen((record) {
      if (record.loggerName != 'WebtritApiClient') return;
      final match = _requestLine.firstMatch(record.message);
      if (match == null) return;
      _requests.add(_ApiRequest(record.time, int.parse(match.group(2)!), Uri.parse(match.group(3)!).path));
    });
  }

  Future<void> stop() async => _subscription?.cancel();

  /// First-attempt GET /user requests within [since, until).
  List<_ApiRequest> userInfoRequests({DateTime? since, DateTime? until}) => _requests
      .where((r) => r.path.endsWith('/user') && r.attempt == 0)
      .where((r) => since == null || !r.time.isBefore(since))
      .where((r) => until == null || r.time.isBefore(until))
      .toList();

  /// Requests that went through the transport retry loop.
  List<_ApiRequest> retriedRequests() => _requests.where((r) => r.attempt > 0).toList();
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
