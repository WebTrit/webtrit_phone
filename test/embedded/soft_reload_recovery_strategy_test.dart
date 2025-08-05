import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/widgets/webview/web_view_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MockWebViewController extends Mock implements WebViewController {}

void main() {
  group('RetryUntilSuccessStrategy', () {
    late SoftReloadRecoveryStrategy strategy;
    late List<String> log;
    late StreamController<List<ConnectivityResult>> connectivityStream;
    late WebViewController controller;

    setUp(() {
      log = [];
      connectivityStream = StreamController<List<ConnectivityResult>>();
      controller = MockWebViewController();
      when(() => controller.runJavaScript(any())).thenAnswer((_) async {});
      when(() => controller.reload()).thenAnswer((_) => Future.value());
    });

    tearDown(() async {
      await connectivityStream.close();
      strategy.disposeForTesting();
    });

    test('Case 1: WiFi available, WebView loads successfully immediately', () async {
      final completer = Completer<void>();

      strategy = SoftReloadRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 5,
        connectivityStream: connectivityStream.stream,
      );

      when(() => controller.reload()).thenAnswer((_) async {
        log.add('reload');
        strategy.onPageLoadSuccess();
        completer.complete();
      });

      strategy.startMonitoringForTesting(controller);

      connectivityStream.add([ConnectivityResult.wifi]);

      await completer.future.timeout(const Duration(seconds: 1));

      expect(log, equals(['reload']));
    });

    test('Case 2: WiFi, but WebView fails 2 times before success', () async {
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
          completer.complete();
        }
      });

      strategy.startMonitoringForTesting(controller);

      connectivityStream.add([ConnectivityResult.wifi]);

      await completer.future.timeout(const Duration(seconds: 1));

      expect(log.length, equals(3)); // 2 failures + 1 success
    });

    test('Case 3: No WiFi — should not retry', () async {
      strategy = SoftReloadRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 5,
        connectivityStream: connectivityStream.stream,
      );

      strategy.startMonitoringForTesting(controller);

      connectivityStream.add([ConnectivityResult.none]);

      await Future.delayed(const Duration(milliseconds: 300));

      expect(log, isEmpty);
    });

    test('Case 4: WiFi -> success -> drop -> reconnect -> retry again', () async {
      final completer = Completer<void>();
      int attemptCount = 0;

      strategy = SoftReloadRecoveryStrategy(
        retryDelay: const Duration(milliseconds: 100),
        maxAttempts: 10,
        connectivityStream: connectivityStream.stream,
      );

      when(() => controller.reload()).thenAnswer((_) async {
        final entry = 'reload:$attemptCount';
        log.add(entry);
        attemptCount++;

        if (entry == 'reload:1' || entry == 'reload:5') {
          strategy.onPageLoadSuccess();
          if (entry == 'reload:5') completer.complete();
        } else {
          strategy.onPageLoadFailed();
        }
      });

      strategy.startMonitoringForTesting(controller);

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
        ]),
      );
    });

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

      await Future.delayed(const Duration(milliseconds: 800));

      expect(reloads, equals(3));
      expect(log.length, equals(3));
    });

    test('Case 6: Multiple calls to startMonitoring should be ignored', () async {
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
        completer.complete();
      });

      final secondController = MockWebViewController();
      when(() => secondController.reload()).thenAnswer((_) async {
        log.add('should-not-be-called');
      });

      strategy.startMonitoringForTesting(firstController);

      strategy.startMonitoringForTesting(secondController);

      connectivityStream.add([ConnectivityResult.wifi]);

      await completer.future.timeout(const Duration(seconds: 1));

      expect(reloadCount, equals(1));
      expect(log, isNot(contains('should-not-be-called')));
    });
  });
}
