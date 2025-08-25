import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/widgets/webview/web_view_container.dart';

class MockWebViewController extends Mock implements WebViewController {}

void main() {
  group('SoftReloadRecoveryStrategy', () {
    late SoftReloadRecoveryStrategy strategy;
    late List<String> log;
    late StreamController<List<ConnectivityResult>> connectivityStream;
    late WebViewController controller;

    setUpAll(() {
      // WebViewController methods don’t take complex args here, but register anyway
      registerFallbackValue(const <String, Object?>{});
    });

    setUp(() {
      log = [];
      connectivityStream = StreamController<List<ConnectivityResult>>();
      controller = MockWebViewController();

      when(() => controller.runJavaScript(any())).thenAnswer((_) async {});
      when(() => controller.reload()).thenAnswer((_) async {});
    });

    tearDown(() async {
      await connectivityStream.close();
      // Dispose via testing helper to avoid touching private members
      strategy.disposeForTesting();
    });

    // Simulates a situation where internet is available immediately
    // and the first reload results in a successful page load.
    test('Case 1: WiFi available, loads successfully immediately (single reload)', () async {
      final completer = Completer<void>();

      strategy = SoftReloadRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 5,
        connectivityStream: connectivityStream.stream,
      );

      when(() => controller.reload()).thenAnswer((_) async {
        log.add('reload');
        strategy.onPageLoadSuccess();
        if (!completer.isCompleted) completer.complete();
      });

      strategy.startMonitoringForTesting(controller);

      connectivityStream.add([ConnectivityResult.wifi]);

      await completer.future.timeout(const Duration(seconds: 1));

      expect(log, equals(['reload']));
    });

    // Simulates unstable page: two reload failures, then a success.
    test('Case 2: WiFi, fails twice before success (3 reloads total)', () async {
      final completer = Completer<void>();
      int failures = 2;

      strategy = SoftReloadRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 5,
        connectivityStream: connectivityStream.stream,
      );

      when(() => controller.reload()).thenAnswer((_) async {
        log.add('reload');
        if (failures > 0) {
          failures--;
          strategy.onPageLoadFailed();
        } else {
          strategy.onPageLoadSuccess();
          if (!completer.isCompleted) completer.complete();
        }
      });

      strategy.startMonitoringForTesting(controller);

      connectivityStream.add([ConnectivityResult.wifi]);

      await completer.future.timeout(const Duration(seconds: 2));

      expect(log.length, equals(3));
    });

    // Simulates device staying offline: no retries should happen.
    test('Case 3: No WiFi — should not retry at all', () async {
      strategy = SoftReloadRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 80),
        maxAttempts: 5,
        connectivityStream: connectivityStream.stream,
      );

      strategy.startMonitoringForTesting(controller);

      connectivityStream.add([ConnectivityResult.none]);

      await Future.delayed(const Duration(milliseconds: 350));

      verifyNever(() => controller.reload());
      expect(log, isEmpty);
    });

    // Simulates successful load once. After disconnect + reconnect,
    // strategy should not trigger additional reloads.
    test('Case 4: WiFi -> first success -> drop -> reconnect -> should NOT retry again', () async {
      int reloads = 0;
      final firstSuccess = Completer<void>();

      strategy = SoftReloadRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 10,
        connectivityStream: connectivityStream.stream,
      );

      when(() => controller.reload()).thenAnswer((_) async {
        reloads++;
        log.add('reload');
        if (!firstSuccess.isCompleted) {
          strategy.onPageLoadSuccess();
          firstSuccess.complete();
        }
      });

      strategy.startMonitoringForTesting(controller);

      // Go online -> one reload -> success
      connectivityStream.add([ConnectivityResult.wifi]);
      await firstSuccess.future.timeout(const Duration(seconds: 1));

      // Go offline then online again — should not trigger more reloads
      connectivityStream.add([ConnectivityResult.none]);
      await Future.delayed(const Duration(milliseconds: 200));
      connectivityStream.add([ConnectivityResult.wifi]);
      await Future.delayed(const Duration(milliseconds: 400));

      expect(reloads, equals(1));
      expect(log, equals(['reload']));
    });

    // Simulates permanent failure: reload attempts reach maxAttempts and stop.
    test('Case 5: Max attempts reached — retries stop', () async {
      strategy = SoftReloadRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 3,
        connectivityStream: connectivityStream.stream,
      );

      int reloads = 0;

      when(() => controller.reload()).thenAnswer((_) async {
        reloads++;
        log.add('reload');
        strategy.onPageLoadFailed();
      });

      strategy.startMonitoringForTesting(controller);

      connectivityStream.add([ConnectivityResult.wifi]);

      // ~ debounce (300ms) + 3 attempts * 100ms + buffer
      await Future.delayed(const Duration(milliseconds: 800));

      expect(reloads, equals(3));
      expect(log.length, equals(3));
    });

    // Simulates calling startMonitoring twice: only the first controller should be used.
    test('Case 6: Multiple startMonitoring calls are ignored after the first', () async {
      final completer = Completer<void>();
      int reloadCount = 0;

      strategy = SoftReloadRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 5,
        connectivityStream: connectivityStream.stream,
      );

      final firstController = MockWebViewController();
      when(() => firstController.reload()).thenAnswer((_) async {
        reloadCount++;
        strategy.onPageLoadSuccess();
        if (!completer.isCompleted) completer.complete();
      });

      final secondController = MockWebViewController();
      when(() => secondController.reload()).thenAnswer((_) async {
        log.add('should-not-be-called');
      });

      strategy.startMonitoringForTesting(firstController);

      // This should be ignored
      strategy.startMonitoringForTesting(secondController);

      connectivityStream.add([ConnectivityResult.wifi]);

      await completer.future.timeout(const Duration(seconds: 1));

      expect(reloadCount, equals(1));
      expect(log, isNot(contains('should-not-be-called')));
    });

    // Simulates first success, then later an explicit page failure.
    // After failure, retries should resume and eventually succeed again.
    test('Case 7: After initial success, explicit failure re-enables retries', () async {
      final firstSuccess = Completer<void>();
      final secondSuccess = Completer<void>();
      int reloads = 0;

      strategy = SoftReloadRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 80),
        maxAttempts: 5,
        connectivityStream: connectivityStream.stream,
      );

      when(() => controller.reload()).thenAnswer((_) async {
        reloads++;
        log.add('reload:$reloads');

        if (reloads == 1) {
          strategy.onPageLoadSuccess();
          if (!firstSuccess.isCompleted) firstSuccess.complete();
        } else if (reloads == 2) {
          strategy.onPageLoadSuccess();
          if (!secondSuccess.isCompleted) secondSuccess.complete();
        } else {
          strategy.onPageLoadFailed();
        }
      });

      strategy.startMonitoringForTesting(controller);

      connectivityStream.add([ConnectivityResult.wifi]);
      await firstSuccess.future.timeout(const Duration(seconds: 2));

      strategy.onPageLoadFailed();

      await secondSuccess.future.timeout(const Duration(seconds: 2));

      expect(reloads, greaterThanOrEqualTo(2));
      expect(log, containsAllInOrder(['reload:1', 'reload:2']));
    });
  });
}
