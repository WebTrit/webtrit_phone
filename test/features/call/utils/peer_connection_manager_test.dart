import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/features/call/utils/utils.dart';

class MockPeerConnectionFactory extends Mock implements PeerConnectionFactory {}

class MockRTCPeerConnection extends Mock implements RTCPeerConnection {}

void main() {
  late PeerConnectionManager manager;
  late MockPeerConnectionFactory mockFactory;
  late MockRTCPeerConnection mockPC;

  const kTestUuid = 'test-call-uuid';
  const kShortTimeout = Duration(milliseconds: 50);

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockFactory = MockPeerConnectionFactory();
    mockPC = MockRTCPeerConnection();

    when(() => mockFactory.create()).thenAnswer((_) async => mockPC);
    when(() => mockPC.close()).thenAnswer((_) async {});

    manager = PeerConnectionManager(factory: mockFactory, retrieveTimeout: kShortTimeout);
  });

  group('PeerConnectionManager (Basic)', () {
    test('add() creates a completer but does not complete it yet', () async {
      manager.add(kTestUuid);
      final result = await manager.retrieve(kTestUuid, allowWaiting: false);
      expect(result, isNull);
    });

    test('add() ignores duplicate calls', () {
      manager.add(kTestUuid);
      manager.add(kTestUuid);
      expect(manager.retrieve(kTestUuid, allowWaiting: false), completes);
    });

    test('createPeerConnection() calls factory and returns PC', () async {
      const observer = PeerConnectionObserver();
      final pc = await manager.createPeerConnection(kTestUuid, observer: observer);
      verify(() => mockFactory.create()).called(1);
      expect(pc, equals(mockPC));
    });

    test('complete() successfully completes the barrier', () async {
      manager.add(kTestUuid);
      manager.complete(kTestUuid, mockPC);
      final result = await manager.retrieve(kTestUuid);
      expect(result, equals(mockPC));
    });

    test('complete() handles late completion gracefully (no completer)', () {
      expect(() => manager.complete(kTestUuid, mockPC), returnsNormally);
    });

    test('completeError() completes with error', () async {
      manager.add(kTestUuid);
      final exception = Exception('Test Error');
      manager.completeError(kTestUuid, exception);
      expect(manager.retrieve(kTestUuid), throwsA(equals(exception)));
    });

    test('retrieve() throws TimeoutException if not completed in time', () async {
      manager.add(kTestUuid);
      expect(manager.retrieve(kTestUuid), throwsA(isA<TimeoutException>()));
    });

    test('retrieve() returns immediately if already completed', () async {
      manager.add(kTestUuid);
      manager.complete(kTestUuid, mockPC);
      final result = await manager.retrieve(kTestUuid);
      expect(result, equals(mockPC));
    });

    test('disposePeerConnection() closes PC and handles uncompleted completer', () async {
      manager.add(kTestUuid);
      manager.complete(kTestUuid, mockPC);
      await manager.disposePeerConnection(kTestUuid);
      verify(() => mockPC.close()).called(1);
      final result = await manager.retrieve(kTestUuid);
      expect(result, isNull);
    });

    test('disposePeerConnection() completes with error if completer was pending', () async {
      manager.add(kTestUuid);
      final futurePending = manager.retrieve(kTestUuid);
      expect(futurePending, throwsA(isA<StateError>()));
      await manager.disposePeerConnection(kTestUuid);
    });

    test('dispose() closes all connections', () async {
      const uuid1 = 'uuid-1';
      const uuid2 = 'uuid-2';
      final mockPC2 = MockRTCPeerConnection();
      when(() => mockPC2.close()).thenAnswer((_) async {});

      manager.add(uuid1);
      manager.complete(uuid1, mockPC);
      manager.add(uuid2);
      manager.complete(uuid2, mockPC2);

      await manager.dispose();
      verify(() => mockPC.close()).called(1);
      verify(() => mockPC2.close()).called(1);
    });
  });

  group('Bloc Specific Scenarios', () {
    test('conditionalCompleteError() completes pending call with error (Handshake cleanup)', () async {
      // Scenario: _onSignalingStateHandshake detects a "ghost" call that is not in lines.
      // It calls conditionalCompleteError to kill the pending wait.
      manager.add(kTestUuid);

      final exception = Exception('Request Terminated');
      manager.conditionalCompleteError(kTestUuid, exception);

      expect(manager.retrieve(kTestUuid), throwsA(equals(exception)));
    });

    test('conditionalCompleteError() does NOT affect already active calls (Handshake safety)', () async {
      // Scenario: _onSignalingStateHandshake runs while a valid active call exists.
      // The active connection must be preserved.
      manager.add(kTestUuid);
      manager.complete(kTestUuid, mockPC); // Call is active

      final exception = Exception('Should be ignored');
      manager.conditionalCompleteError(kTestUuid, exception);

      // Should still return the valid PC, not the error
      expect(await manager.retrieve(kTestUuid), equals(mockPC));
    });

    test('conditionalCompleteError() is safe when callId does not exist', () async {
      // Scenario: Cleanup logic runs for a UUID that was already removed.
      expect(() => manager.conditionalCompleteError('unknown-uuid', Exception('e')), returnsNormally);
    });

    test('Race Condition: complete() called after disposePeerConnection()', () async {
      // Scenario: performStarted initiates creation (async). User hangs up immediately (dispose called).
      // Then creation finishes and tries to call complete().
      manager.add(kTestUuid);

      // User hangs up -> Dispose triggers StateError on waiters
      final pendingFuture = manager.retrieve(kTestUuid);
      expect(pendingFuture, throwsA(isA<StateError>()));
      await manager.disposePeerConnection(kTestUuid);

      // Factory finishes later and calls complete
      manager.complete(kTestUuid, mockPC);

      // Verify that retrieve returns null (because it was removed) and no crash occurred
      final result = await manager.retrieve(kTestUuid);
      expect(result, isNull);
    });

    test('Race Condition: completeError() called after disposePeerConnection()', () async {
      // Scenario: Similar to above, but creation failed after hangup.
      manager.add(kTestUuid);

      // Dispose
      final pendingFuture = manager.retrieve(kTestUuid);
      expect(pendingFuture, throwsA(isA<StateError>()));
      await manager.disposePeerConnection(kTestUuid);

      // Late error report
      manager.completeError(kTestUuid, Exception('Late error'));

      // Should be clean
      expect(await manager.retrieve(kTestUuid), isNull);
    });

    test('retrieve() returns null immediately for unknown UUID', () async {
      // Scenario: Signaling event arrives for a callId that hasn't been added via onChange yet.
      final result = await manager.retrieve('ghost-uuid');
      expect(result, isNull);
    });

    test('Ignored dispose: disposePeerConnection() safe to call multiple times', () async {
      // Scenario: Cleanup might be triggered in onChange AND in event handler.
      manager.add(kTestUuid);
      manager.complete(kTestUuid, mockPC);

      await manager.disposePeerConnection(kTestUuid);
      await manager.disposePeerConnection(kTestUuid); // Second call

      verify(() => mockPC.close()).called(1);
    });

    test('completeError() on already completed call does not change state', () async {
      // Scenario: Call established. Later, some minor error logic in Bloc triggers completeError.
      // Existing connection should remain valid.
      manager.add(kTestUuid);
      manager.complete(kTestUuid, mockPC);

      manager.completeError(kTestUuid, Exception('Late minor error'));

      expect(await manager.retrieve(kTestUuid), equals(mockPC));
    });
  });

  group('Disposal Barrier & Timeout Scenarios', () {
    test('createPeerConnection() waits for pending disposal (Barrier)', () async {
      // Setup active call manually to simulate existing state
      manager.add(kTestUuid);
      manager.complete(kTestUuid, mockPC);

      // Control when pc.close() finishes
      final closeCompleter = Completer<void>();
      when(() => mockPC.close()).thenAnswer((_) => closeCompleter.future);

      // Start disposal -> this will "hang" until closeCompleter is completed
      final disposeFuture = manager.disposePeerConnection(kTestUuid);

      // Try to create NEW connection immediately
      // It should NOT complete yet because disposal is still pending
      bool createCompleted = false;
      final createFuture = manager
          .createPeerConnection(kTestUuid, observer: const PeerConnectionObserver())
          .whenComplete(() => createCompleted = true);

      // Allow microtasks to propagate
      await Future.delayed(Duration.zero);
      expect(createCompleted, isFalse, reason: 'Should wait for disposal to finish');

      // Finish disposal
      closeCompleter.complete();
      await disposeFuture;

      // Now creation should proceed
      await createFuture;
      expect(createCompleted, isTrue);

      // Verify factory called ONCE (only for the new creation)
      verify(() => mockFactory.create()).called(1);

      // Verify the old connection was explicitly closed
      verify(() => mockPC.close()).called(1);
    });

    test('dispose() returns even if pc.close() hangs (Safety Timeout)', () async {
      // Setup active call manually
      manager.add(kTestUuid);
      manager.complete(kTestUuid, mockPC);

      // Mock close() that NEVER completes
      when(() => mockPC.close()).thenAnswer((_) => Completer<void>().future);

      // Measure time for dispose()
      final stopwatch = Stopwatch()..start();

      // This should take approx 2 seconds (the timeout hardcoded in manager)
      // but importantly, it MUST complete.
      await manager.dispose();

      stopwatch.stop();

      // Verify it waited at least the timeout duration (2s)
      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(2000));
      // Verify it didn't hang forever (e.g. < 4s buffer)
      expect(stopwatch.elapsedMilliseconds, lessThan(4000));
    });
  });
}
