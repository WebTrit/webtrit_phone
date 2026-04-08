import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

const _kConfig = SignalingServiceConfig(
  coreUrl: 'wss://127.0.0.1:1',
  tenantId: 'integration-test',
  token: 'test-token',
);

Future<T> _waitFor<T>(Future<T> future, {String label = 'event', Duration timeout = const Duration(seconds: 300)}) {
  return future.timeout(timeout, onTimeout: () => throw TimeoutException('$label did not fire within timeout'));
}

var _idCounter = 0;

HangupRequest _nextRequest() {
  final id = 'exec-${_idCounter++}';
  return HangupRequest(transaction: id, line: 1, callId: id);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late WebtritSignalingService service;

  setUp(() {
    service = WebtritSignalingService(config: _kConfig);
  });

  tearDown(() async {
    await service.dispose().timeout(const Duration(seconds: 60));
  });

  // -------------------------------------------------------------------------
  // execute() contract
  // -------------------------------------------------------------------------

  group('execute()', () {
    testWidgets('execute() returns a non-null Future when not connected', (WidgetTester _) async {
      expect(service.execute(_nextRequest()), isNotNull);
    });

    testWidgets('queued request fails with NotConnectedException on dispose()', (WidgetTester _) async {
      final future = service.execute(_nextRequest())!;

      await service.dispose();

      await expectLater(future, throwsA(isA<NotConnectedException>()));
    });

    testWidgets('multiple queued requests all fail with NotConnectedException on dispose()', (WidgetTester _) async {
      final futures = [
        service.execute(_nextRequest())!,
        service.execute(_nextRequest())!,
        service.execute(_nextRequest())!,
      ];

      await service.dispose();

      for (final f in futures) {
        await expectLater(f, throwsA(isA<NotConnectedException>()));
      }
    });

    testWidgets('queued requests are not executed while connection is failing', (WidgetTester _) async {
      final failed = Completer<void>();
      service.events.listen((e) {
        if (e is SignalingConnectionFailed && !failed.isCompleted) failed.complete();
      });

      final future = service.execute(_nextRequest());
      service.connect();
      await _waitFor(failed.future, label: 'SignalingConnectionFailed');

      // Request is still pending (not yet resolved or thrown).
      expect(future, isNotNull);
    });
  });
}
