import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/web_view_container.dart';

void main() {
  group('RetryUntilSuccessStrategy', () {
    late DefaultConnectivityRecoveryStrategy strategy;
    late List<String> log;
    late StreamController<List<ConnectivityResult>> connectivityStream;

    setUp(() {
      log = [];
      connectivityStream = StreamController<List<ConnectivityResult>>();
    });

    tearDown(() async {
      await connectivityStream.close();
      strategy.disposeForTesting();
    });

    test('Case 1: WiFi available, WebView loads successfully immediately', () async {
      final completer = Completer<void>();

      strategy = DefaultConnectivityRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 5,
        connectivityStream: connectivityStream.stream,
      );

      strategy.startMonitoring(tryReload: () {
        log.add('reload');
        strategy.onPageLoadSuccess();
        completer.complete();
      });

      connectivityStream.add([ConnectivityResult.wifi]);

      await completer.future.timeout(const Duration(seconds: 1));

      expect(log, equals(['reload']));
    });

    test('Case 2: WiFi, but WebView fails 2 times before success', () async {
      final completer = Completer<void>();
      int failures = 2;

      strategy = DefaultConnectivityRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 5,
        connectivityStream: connectivityStream.stream,
      );

      strategy.startMonitoring(tryReload: () {
        log.add('reload');
        if (failures > 0) {
          failures--;
        } else {
          strategy.onPageLoadSuccess();
          completer.complete();
        }
      });

      connectivityStream.add([ConnectivityResult.wifi]);

      await completer.future.timeout(const Duration(seconds: 1));

      expect(log.length, equals(3)); // 2 failures + 1 success
    });

    test('Case 3: No WiFi — should not retry', () async {
      strategy = DefaultConnectivityRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 5,
        connectivityStream: connectivityStream.stream,
      );

      strategy.startMonitoring(tryReload: () {
        log.add('reload');
      });

      connectivityStream.add([ConnectivityResult.none]);

      await Future.delayed(const Duration(milliseconds: 300));

      expect(log, isEmpty);
    });

    test('Case 4: WiFi -> success -> drop -> reconnect -> retry again', () async {
      final completer = Completer<void>();
      int attemptCount = 0;

      strategy = DefaultConnectivityRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 10,
        connectivityStream: connectivityStream.stream,
      );

      strategy.startMonitoring(tryReload: () {
        final entry = 'reload:$attemptCount';
        log.add(entry);
        attemptCount++;

        if (entry == 'reload:1' || entry == 'reload:5') {
          strategy.onPageLoadSuccess();
          if (entry == 'reload:5') completer.complete();
        }
      });

      connectivityStream.add([ConnectivityResult.wifi]);
      await Future.delayed(const Duration(milliseconds: 300));

      connectivityStream.add([ConnectivityResult.none]);
      await Future.delayed(const Duration(milliseconds: 150));

      connectivityStream.add([ConnectivityResult.wifi]);

      await completer.future.timeout(const Duration(seconds: 2));

      expect(
          log,
          equals([
            'reload:0',
            'reload:1',
            'reload:2',
            'reload:3',
            'reload:4',
            'reload:5',
          ]));
    });

    test('Case 5: Max attempts reached — retries stop', () async {
      strategy = DefaultConnectivityRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 3,
        connectivityStream: connectivityStream.stream,
      );

      strategy.startMonitoring(tryReload: () {
        log.add('reload');
        strategy.onPageLoadFailed();
      });

      connectivityStream.add([ConnectivityResult.wifi]);

      await Future.delayed(const Duration(milliseconds: 500));

      expect(log.length, equals(1));
    });

    test('Case 6: Multiple calls to startMonitoring should be ignored', () async {
      final completer = Completer<void>();

      strategy = DefaultConnectivityRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 5,
        connectivityStream: connectivityStream.stream,
      );

      int reloadCount = 0;

      strategy.startMonitoring(tryReload: () {
        reloadCount++;
        strategy.onPageLoadSuccess();
        completer.complete();
      });

      strategy.startMonitoring(tryReload: () {
        log.add('should-not-be-called');
      });

      connectivityStream.add([ConnectivityResult.wifi]);

      await completer.future.timeout(const Duration(seconds: 1));

      expect(reloadCount, equals(1));
      expect(log, isNot(contains('should-not-be-called')));
    });
  });
}
