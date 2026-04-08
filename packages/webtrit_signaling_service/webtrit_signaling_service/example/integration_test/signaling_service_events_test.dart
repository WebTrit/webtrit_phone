import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

const _kConfig = SignalingServiceConfig(
  coreUrl: 'wss://127.0.0.1:1',
  tenantId: 'integration-test',
  token: 'test-token',
);

// Waits for the completer with a timeout to produce a readable failure message.
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
  // Stream contract
  // -------------------------------------------------------------------------

  group('Events -- stream contract', () {
    testWidgets('events stream accessible before connect()', (WidgetTester _) async {
      expect(service.events, isA<Stream<SignalingModuleEvent>>());
    });

    testWidgets('events stream is a broadcast stream', (WidgetTester _) async {
      expect(service.events.isBroadcast, isTrue);
    });

    testWidgets('two listeners can subscribe simultaneously', (WidgetTester _) async {
      final listener1 = <SignalingModuleEvent>[];
      final listener2 = <SignalingModuleEvent>[];
      final sub1 = service.events.listen(listener1.add);
      final sub2 = service.events.listen(listener2.add);
      addTearDown(sub1.cancel);
      addTearDown(sub2.cancel);

      service.connect();

      final connecting1 = Completer<void>();
      final connecting2 = Completer<void>();
      sub1.onData((e) {
        if (e is SignalingConnecting && !connecting1.isCompleted) connecting1.complete();
      });
      sub2.onData((e) {
        if (e is SignalingConnecting && !connecting2.isCompleted) connecting2.complete();
      });

      await _waitFor(connecting1.future, label: 'listener1 SignalingConnecting');
      await _waitFor(connecting2.future, label: 'listener2 SignalingConnecting');
    });

    testWidgets('dispose() closes events stream', (WidgetTester _) async {
      final done = Completer<void>();
      service.events.listen(null, onDone: done.complete);

      await service.dispose();

      await _waitFor(done.future, label: 'stream onDone');
    });
  });

  // -------------------------------------------------------------------------
  // Connection failure path (no real server needed)
  // -------------------------------------------------------------------------

  group('Events -- connection failure path', () {
    testWidgets('connect() emits SignalingConnecting', (WidgetTester _) async {
      final connecting = Completer<void>();
      service.events.listen((event) {
        if (event is SignalingConnecting && !connecting.isCompleted) connecting.complete();
      });

      service.connect();
      await _waitFor(connecting.future, label: 'SignalingConnecting');
    });

    testWidgets('failed connection emits SignalingConnectionFailed with error', (WidgetTester _) async {
      final failed = Completer<SignalingConnectionFailed>();
      service.events.listen((event) {
        if (event is SignalingConnectionFailed && !failed.isCompleted) failed.complete(event);
      });

      service.connect();
      final event = await _waitFor(failed.future, label: 'SignalingConnectionFailed');

      expect(event.error, isNotNull);
    });

    testWidgets('SignalingConnectionFailed carries recommendedReconnectDelay', (WidgetTester _) async {
      final failed = Completer<SignalingConnectionFailed>();
      service.events.listen((event) {
        if (event is SignalingConnectionFailed && !failed.isCompleted) failed.complete(event);
      });

      service.connect();
      final event = await _waitFor(failed.future, label: 'SignalingConnectionFailed');

      expect(event.recommendedReconnectDelay, isNotNull);
    });

    testWidgets('events are delivered in correct order: Connecting -> ConnectionFailed', (WidgetTester _) async {
      final events = <SignalingModuleEvent>[];
      final failed = Completer<void>();

      service.events.listen((event) {
        events.add(event);
        if (event is SignalingConnectionFailed && !failed.isCompleted) failed.complete();
      });

      service.connect();
      await _waitFor(failed.future, label: 'SignalingConnectionFailed');

      expect(events.first, isA<SignalingConnecting>());
      expect(events.any((e) => e is SignalingConnectionFailed), isTrue);
    });
  });

  // -------------------------------------------------------------------------
  // Restart cycle events
  // -------------------------------------------------------------------------

  group('Events -- restart cycle', () {
    testWidgets('fresh instance after dispose() delivers events again', (WidgetTester _) async {
      // First session.
      final firstConnecting = Completer<void>();
      final sub = service.events.listen((e) {
        if (e is SignalingConnecting && !firstConnecting.isCompleted) firstConnecting.complete();
      });

      service.connect();
      await _waitFor(firstConnecting.future, label: 'first SignalingConnecting');
      sub.cancel();
      await service.dispose();

      // Fresh instance for the second session; tearDown will dispose it.
      service = WebtritSignalingService(config: _kConfig);
      final secondConnecting = Completer<void>();
      service.events.listen((e) {
        if (e is SignalingConnecting && !secondConnecting.isCompleted) secondConnecting.complete();
      });

      service.connect();
      await _waitFor(secondConnecting.future, label: 'second SignalingConnecting from fresh instance');
    });

    testWidgets('session buffer replayed to late subscriber', (WidgetTester _) async {
      // Wait for the connection to fail so the buffer has at least 2 events.
      final failed = Completer<void>();
      final earlyListener = service.events.listen((e) {
        if (e is SignalingConnectionFailed && !failed.isCompleted) failed.complete();
      });

      service.connect();
      await _waitFor(failed.future, label: 'SignalingConnectionFailed');
      earlyListener.cancel();

      // Late subscriber -- must receive buffered events synchronously.
      final buffered = <SignalingModuleEvent>[];
      service.events.listen(buffered.add);
      await Future<void>.delayed(Duration.zero);

      expect(buffered, isNotEmpty);
      expect(buffered.first, isA<SignalingConnecting>());
    });
  });
}
