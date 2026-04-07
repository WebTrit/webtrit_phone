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
    service = WebtritSignalingService();
  });

  tearDown(() async {
    await service.dispose().timeout(const Duration(seconds: 60));
  });

  // -------------------------------------------------------------------------
  // Rapid lifecycle cycles
  // -------------------------------------------------------------------------

  group('Stress -- rapid start/dispose cycles', () {
    testWidgets('5 start/dispose cycles leave plugin in clean state', (WidgetTester _) async {
      for (var i = 0; i < 5; i++) {
        await service.start(_kConfig);
        await Future<void>.delayed(const Duration(milliseconds: 100));
        await service.dispose();
      }
      // After all cycles the plugin must still accept a fresh start.
      await expectLater(service.start(_kConfig), completes);
    });

    testWidgets('rapid start/start replaces session without hanging', (WidgetTester _) async {
      await service.start(_kConfig);
      await service.start(_kConfig); // replaces session immediately
      await service.start(_kConfig); // replaces again
      // Should still be in a valid state.
      await expectLater(service.start(_kConfig), completes);
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

      await service.start(_kConfig);

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

      await service.start(_kConfig);
      await _waitFor(failed.future, label: 'SignalingConnectionFailed');

      // Subscribe AFTER events were emitted -- buffer must replay them.
      final replayed = <SignalingModuleEvent>[];
      service.events.listen(replayed.add);
      await Future<void>.delayed(Duration.zero);

      expect(replayed.any((e) => e is SignalingConnecting), isTrue);
    });
  });
}
