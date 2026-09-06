import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'subsequences/pump_for.dart';
import 'subsequences/wait_until.dart';
import 'subsequences/with_network_disabled.dart';

const _transportTimeout = Duration(seconds: 20);
const _pollingInterval = Duration(seconds: 1);

/// Reproduces the connectivity ABA race through the real Android plugin:
/// wifi probe P1 -> none -> wifi probe P2, then P2 completes before P1.
///
/// The checker is controlled because an actual HTTP race is timing-dependent;
/// the OS transport changes are real. The final assertion crosses the service
/// boundary into PollingService and proves that its periodic schedule remains
/// alive after the stale P1 result arrives.
void main() {
  patrolTest('a stale connectivity probe cannot stop polling after wifi recovers', ($) async {
    final network = RestorableNetwork($);
    addTearDown(network.restore);
    await network.disable();
    await _waitForPlatformTransport($, ConnectivityResult.none);

    final checker = _ControlledConnectivityChecker();
    final connectivityService = await ConnectivityServiceImpl.create(connectivityChecker: checker);
    addTearDown(connectivityService.dispose);
    expect(connectivityService.currentConnectivityResult, ConnectivityResult.none);

    final connectionStates = <bool>[];
    final connectionSubscription = connectivityService.connectionStream.listen(connectionStates.add);
    addTearDown(connectionSubscription.cancel);

    final refreshable = _CountingRefreshable();
    final pollingService = PollingService(
      connectivityService: connectivityService,
      registrations: [PollingRegistration(listener: refreshable, interval: _pollingInterval)],
      options: const PollingOptions(
        jitterMaxMs: 0,
        verifyReachabilityOnTick: false,
        leadingRefreshRequiresVerify: false,
      ),
    );
    addTearDown(pollingService.dispose);
    await $.pump();
    expect(refreshable.calls, 0, reason: 'polling starts while the device is offline');

    await network.enableWifi();
    final firstWaveEnd = await _waitForStableProbeCount($, checker, minimum: 1);

    await network.disableWifi();
    await _waitForServiceTransport($, connectivityService, ConnectivityResult.none);

    await network.enableWifi();
    final secondWaveEnd = await _waitForStableProbeCount($, checker, minimum: firstWaveEnd + 1);
    final latestProbe = secondWaveEnd - 1;

    checker.complete(latestProbe, true);
    await waitUntil(
      $,
      () => connectionStates.lastOrNull == true && refreshable.calls >= 1,
      timeout: const Duration(seconds: 5),
      description: 'the newest wifi probe must reconnect polling and run its leading refresh',
    );

    checker.completeEveryPendingExcept(latestProbe, false);
    await pumpFor(const Duration(seconds: 3), $);

    expect(connectionStates.last, isTrue, reason: 'stale wifi probes must not overwrite the latest online result');
    expect(refreshable.calls, greaterThanOrEqualTo(2), reason: 'periodic polling must remain scheduled after recovery');
  });
}

Future<void> _waitForPlatformTransport(PatrolIntegrationTester $, ConnectivityResult expected) async {
  final connectivity = Connectivity();
  final deadline = DateTime.now().add(_transportTimeout);
  while (true) {
    final results = await connectivity.checkConnectivity();
    if (results.firstOrNull == expected) return;
    if (DateTime.now().isAfter(deadline)) {
      fail('the platform did not report $expected within $_transportTimeout; last result: $results');
    }
    await $.pump(const Duration(milliseconds: 250));
  }
}

Future<void> _waitForServiceTransport(
  PatrolIntegrationTester $,
  ConnectivityService connectivityService,
  ConnectivityResult expected,
) async {
  await waitUntil(
    $,
    () => connectivityService.currentConnectivityResult == expected,
    timeout: _transportTimeout,
    description: 'the connectivity service did not report $expected',
    step: const Duration(milliseconds: 250),
  );
}

Future<int> _waitForStableProbeCount(
  PatrolIntegrationTester $,
  _ControlledConnectivityChecker checker, {
  required int minimum,
}) async {
  await waitUntil(
    $,
    () => checker.probes.length >= minimum,
    timeout: _transportTimeout,
    description: 'the connectivity service did not start probe $minimum',
    step: const Duration(milliseconds: 250),
  );

  var previous = checker.probes.length;
  var stableSamples = 0;
  final deadline = DateTime.now().add(_transportTimeout);
  while (stableSamples < 3) {
    if (DateTime.now().isAfter(deadline)) {
      fail('connectivity probes did not settle; last count: $previous');
    }
    await $.pump(const Duration(milliseconds: 300));
    final current = checker.probes.length;
    if (current == previous) {
      stableSamples++;
    } else {
      previous = current;
      stableSamples = 0;
    }
  }
  return previous;
}

class _ControlledConnectivityChecker implements ConnectivityChecker {
  final probes = <Completer<bool>>[];

  @override
  Future<bool> checkConnection() {
    final probe = Completer<bool>();
    probes.add(probe);
    return probe.future;
  }

  void complete(int index, bool result) {
    final probe = probes[index];
    if (!probe.isCompleted) probe.complete(result);
  }

  void completeEveryPendingExcept(int excludedIndex, bool result) {
    for (var index = 0; index < probes.length; index++) {
      if (index != excludedIndex) complete(index, result);
    }
  }

  @override
  Future<void> dispose() async {}
}

class _CountingRefreshable implements Refreshable {
  var calls = 0;

  @override
  bool get isActive => true;

  @override
  Future<void> refresh() async {
    calls++;
  }
}
