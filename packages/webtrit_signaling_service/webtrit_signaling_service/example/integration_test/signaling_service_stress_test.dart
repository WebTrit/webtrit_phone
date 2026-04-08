import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

const _kConfig = SignalingServiceConfig(
  coreUrl: 'wss://127.0.0.1:1',
  tenantId: 'integration-test',
  token: 'test-token',
);

Future<T> _waitFor<T>(Future<T> future, {String label = 'event', Duration timeout = const Duration(seconds: 300)}) {
  return future.timeout(timeout, onTimeout: () => throw TimeoutException('$label did not fire within timeout'));
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
  // Rapid lifecycle cycles
  // -------------------------------------------------------------------------

  group('Stress -- rapid connect/dispose cycles', () {
    testWidgets('5 create/connect/dispose cycles leave plugin in clean state', (WidgetTester _) async {
      for (var i = 0; i < 5; i++) {
        final s = WebtritSignalingService(config: _kConfig);
        s.connect();
        await Future<void>.delayed(const Duration(milliseconds: 100));
        await s.dispose();
      }
      // After all cycles the plugin must still accept a fresh instance.
      expect(() => service.connect(), returnsNormally);
    });

    testWidgets('rapid connect() calls are idempotent and do not hang', (WidgetTester _) async {
      service.connect();
      service.connect(); // idempotent -- no new start while pending
      service.connect(); // idempotent
      service.connect(); // idempotent
      await Future<void>.delayed(const Duration(milliseconds: 200));
      // Should still be in a valid state.
    });
  });

  // -------------------------------------------------------------------------
  // Multiple listeners
  // -------------------------------------------------------------------------

  group('Stress -- multiple concurrent listeners', () {
    testWidgets('5 listeners all receive SignalingConnecting', (WidgetTester _) async {
      final completers = List.generate(5, (_) => Completer<void>());
      final subs = <StreamSubscription<SignalingModuleEvent>>[];

      for (var i = 0; i < completers.length; i++) {
        final c = completers[i];
        subs.add(
          service.events.listen((e) {
            if (e is SignalingConnecting && !c.isCompleted) c.complete();
          }),
        );
      }

      service.connect();

      for (var i = 0; i < completers.length; i++) {
        await _waitFor(completers[i].future, label: 'listener $i SignalingConnecting');
      }

      for (final s in subs) {
        s.cancel();
      }
    });
  });

  // -------------------------------------------------------------------------
  // Late subscriber
  // -------------------------------------------------------------------------

  group('Stress -- late subscriber session buffer', () {
    testWidgets('late subscriber receives at least SignalingConnecting from buffer', (WidgetTester _) async {
      // Wait for failure so buffer is populated.
      final failed = Completer<void>();
      service.events.listen((e) {
        if (e is SignalingConnectionFailed && !failed.isCompleted) failed.complete();
      });

      service.connect();
      await _waitFor(failed.future, label: 'SignalingConnectionFailed');

      // Subscribe AFTER events were emitted -- buffer must replay them.
      final replayed = <SignalingModuleEvent>[];
      service.events.listen(replayed.add);
      await Future<void>.delayed(Duration.zero);

      expect(replayed.any((e) => e is SignalingConnecting), isTrue);
    });
  });
}
