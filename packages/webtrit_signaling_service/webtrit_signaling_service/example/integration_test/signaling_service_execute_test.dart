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
    service = WebtritSignalingService();
  });

  tearDown(() async {
    await service.dispose().timeout(const Duration(seconds: 60));
  });

  // -------------------------------------------------------------------------
  // execute() contract
  // -------------------------------------------------------------------------

  group('execute()', () {
    testWidgets('throws StateError before start()', (WidgetTester _) async {
      await expectLater(service.execute(_nextRequest()), throwsA(isA<StateError>()));
    });

    testWidgets('throws StateError when not connected (connection failed)', (WidgetTester _) async {
      final failed = Completer<void>();
      service.events.listen((e) {
        if (e is SignalingConnectionFailed && !failed.isCompleted) failed.complete();
      });

      await service.start(_kConfig);
      await _waitFor(failed.future, label: 'SignalingConnectionFailed');

      await expectLater(service.execute(_nextRequest()), throwsA(isA<StateError>()));
    });

    testWidgets('throws StateError after dispose()', (WidgetTester _) async {
      await service.start(_kConfig);
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await service.dispose();

      await expectLater(service.execute(_nextRequest()), throwsA(isA<StateError>()));
    });
  });
}
