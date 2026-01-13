import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/features/call/utils/utils.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  late PeerConnectionManager manager;

  setUp(() {
    manager = PeerConnectionManager(
      factory: const DefaultPeerConnectionFactory(),
      retrieveTimeout: const Duration(seconds: 5),
    );
  });

  tearDown(() async {
    await manager.dispose();
  });

  group('PeerConnectionManager Integration (Real WebRTC)', () {
    test('establishes a loopback connection between two peers managed by the same instance', () async {
      const callerId = 'caller-uuid';
      const calleeId = 'callee-uuid';

      // Initialize slots
      manager.add(callerId);
      manager.add(calleeId);

      // Create Real PeerConnections
      // ICE candidates are captured to exchange them manually, simulating a signaling server.
      final callerCandidates = <RTCIceCandidate>[];
      final calleeCandidates = <RTCIceCandidate>[];

      final callerConnectedCompleter = Completer<void>();
      final calleeConnectedCompleter = Completer<void>();

      final callerObserver = PeerConnectionObserver(
        onIceCandidate: (c) => callerCandidates.add(c),
        onIceConnectionState: (state) {
          if (state == RTCIceConnectionState.RTCIceConnectionStateConnected) {
            if (!callerConnectedCompleter.isCompleted) callerConnectedCompleter.complete();
          }
        },
      );

      final calleeObserver = PeerConnectionObserver(
        onIceCandidate: (c) => calleeCandidates.add(c),
        onIceConnectionState: (state) {
          if (state == RTCIceConnectionState.RTCIceConnectionStateConnected) {
            if (!calleeConnectedCompleter.isCompleted) calleeConnectedCompleter.complete();
          }
        },
      );

      final pcCaller = await manager.createPeerConnection(callerId, observer: callerObserver);
      final pcCallee = await manager.createPeerConnection(calleeId, observer: calleeObserver);

      // Create Data Channel to ensure negotiation triggers
      await pcCaller.createDataChannel('test_channel', RTCDataChannelInit());

      // Complete manager setup
      manager.complete(callerId, pcCaller);
      manager.complete(calleeId, pcCallee);

      // --- Signaling Simulation Loop ---

      // Caller creates Offer
      final offer = await pcCaller.createOffer({});
      await pcCaller.setLocalDescription(offer);
      await pcCallee.setRemoteDescription(offer);

      // Callee creates Answer
      final answer = await pcCallee.createAnswer({});
      await pcCallee.setLocalDescription(answer);
      await pcCaller.setRemoteDescription(answer);

      // Exchange ICE Candidates (Trickle simulation)
      // Waits briefly for candidates to be gathered
      await Future.delayed(const Duration(milliseconds: 500));

      for (final c in callerCandidates) {
        await pcCallee.addCandidate(c);
      }
      for (final c in calleeCandidates) {
        await pcCaller.addCandidate(c);
      }

      // Verify Connections become Connected
      await expectLater(callerConnectedCompleter.future.timeout(const Duration(seconds: 10)), completes);
      await expectLater(calleeConnectedCompleter.future.timeout(const Duration(seconds: 10)), completes);

      // Verify Manager Retrieval works for real objects
      expect(await manager.retrieve(callerId), equals(pcCaller));
      expect(await manager.retrieve(calleeId), equals(pcCallee));

      // Test Disposal works safely on real objects
      await manager.disposePeerConnection(callerId);

      // Verify state is cleared
      expect(await manager.retrieve(callerId, allowWaiting: false), isNull);

      // Verify native object is closed (signaling state changes to closed)
      // Uses helper to wait for native propagation
      await _waitForSignalingState(pcCaller, RTCSignalingState.RTCSignalingStateClosed);

      expect(pcCaller.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));

      // Callee should still be alive
      expect(await manager.retrieve(calleeId), isNotNull);
    });

    test('Real Race Condition: dispose while negotiating', () async {
      const raceUuid = 'race-uuid';
      manager.add(raceUuid);

      // Start creating a real connection (takes non-zero time natively)
      final futurePc = manager.createPeerConnection(raceUuid, observer: const PeerConnectionObserver());

      // Trigger dispose IMMEDIATELY while creation is in flight
      // Tests the "Disposal Barrier" against real async delays of the plugin
      final disposeFuture = manager.disposePeerConnection(raceUuid);

      // Wait for creation to finish
      final pc = await futurePc;

      // Wait for disposal to finish
      await disposeFuture;

      // Try to complete. The manager should detect it was disposed and close the orphan.
      manager.complete(raceUuid, pc);

      expect(await manager.retrieve(raceUuid), isNull);

      // Verify the orphan PC is actually closed
      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);
      expect(pc.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));
    });
  });

  group('PeerConnectionManager Integration (Bloc Scenarios)', () {
    /// Scenario: Standard outgoing call flow found in [CallBloc.__onCallPerformEventStarted].
    /// Flow: add -> create -> setup -> complete -> retrieve -> dispose.
    test('Scenario: Full outgoing call lifecycle (Happy Path)', () async {
      const callId = 'outgoing-call-uuid';

      // Bloc: _peerConnectionManager.add(addUuid)
      manager.add(callId);

      // Bloc: _createPeerConnection -> manager.createPeerConnection
      final pcFuture = manager.createPeerConnection(callId, observer: const PeerConnectionObserver());

      final pc = await pcFuture;

      // Bloc: Setup (Simulate adding tracks and creating offer)
      // Note: A simple data channel is used to avoid requiring camera permissions in CI/Test env
      await pc.createDataChannel('test', RTCDataChannelInit());
      final offer = await pc.createOffer({});
      await pc.setLocalDescription(offer);

      // Bloc: _peerConnectionManager.complete
      manager.complete(callId, pc);

      // Bloc: Usage (e.g. toggle mute, dtmf)
      final retrievedPc = await manager.retrieve(callId);
      expect(retrievedPc, equals(pc));
      expect(retrievedPc!.signalingState, equals(RTCSignalingState.RTCSignalingStateHaveLocalOffer));

      // Bloc: Hangup -> disposePeerConnection
      await manager.disposePeerConnection(callId);

      // Verify cleanup
      expect(await manager.retrieve(callId, allowWaiting: false), isNull);
      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);
      expect(pc.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));
    });

    /// Scenario: Setup failure found in [CallBloc.__onCallPerformEventStarted] catch block.
    /// Flow: add -> create -> error -> completeError -> retrieve throws.
    test('Scenario: Call setup failure (e.g. UserMedia/SDP error)', () async {
      const callId = 'error-call-uuid';
      final expectedError = Exception('Simulated UserMedia Error');

      manager.add(callId);

      // Start creation
      final pc = await manager.createPeerConnection(callId, observer: const PeerConnectionObserver());

      // Simulate failure logic in Bloc
      // Instead of calling complete(), completeError() is called
      manager.completeError(callId, expectedError);

      // Bloc tries to retrieve active call, expects it to fail
      expect(
        manager.retrieve(callId),
        throwsA(equals(expectedError)),
        reason: 'Manager should propagate the setup error to any waiters',
      );

      // Cleanup: In the Bloc, this is followed by add(_ResetStateEvent.completeCall)
      // which eventually calls disposePeerConnection
      await manager.disposePeerConnection(callId);

      // Ensure the PC created in the test is closed to avoid leaks.
      await pc.close();
    });

    test('Scenario: Rapid Reconnect (Disposal Barrier on Real Hardware)', () async {
      const callId = 'reconnect-uuid';

      // Establish Cycle 1
      manager.add(callId);
      final pc1 = await manager.createPeerConnection(callId, observer: const PeerConnectionObserver());
      manager.complete(callId, pc1);

      // Trigger Dispose (Cycle 1)
      // Initiates cleanup without awaiting immediately to simulate rapid state changes.
      final disposeFuture = manager.disposePeerConnection(callId);

      // Start Cycle 2 (Same ID)
      // The manager must handle the collision with the pending disposal.
      manager.add(callId);

      final pc2 = await manager.createPeerConnection(callId, observer: const PeerConnectionObserver());

      // Ensure disposal completed before proceeding with verification.
      await disposeFuture;

      manager.complete(callId, pc2);

      // Verify the old connection is closed or detached.
      expect(
        pc1.signalingState,
        anyOf(equals(RTCSignalingState.RTCSignalingStateClosed), isNull),
        reason: 'Cycle 1 PC should be closed',
      );

      // Verify the new connection is a distinct instance.
      expect(pc2, isNot(equals(pc1)), reason: 'Cycle 2 PC must be a new instance');

      // Functional Liveness Check.
      // Direct verification via `createOffer` is used instead of `signalingState`
      // to avoid flaky tests caused by asynchronous event channel latency.
      // If the native object is invalid, this operation throws an exception.
      try {
        final offer = await pc2.createOffer();

        expect(offer.sdp, isNotNull, reason: 'Generated SDP should not be null');
        expect(offer.sdp, isNotEmpty, reason: 'Generated SDP should not be empty');
      } catch (e) {
        fail('Cycle 2 PC failed to create offer. The native object may be invalid. Error: $e');
      }
    });

    /// Scenario: "Orphan" connection handling.
    /// Context: User hangs up *while* the connection is initializing (e.g. poor network).
    /// [CallBloc] logic: `disposePeerConnection` is called while `__onCallPerformEventStarted` is awaiting.
    test('Scenario: Hangup during initialization (Orphan Handling)', () async {
      const callId = 'orphan-uuid';
      manager.add(callId);

      // Creation starts
      final pcFuture = manager.createPeerConnection(callId, observer: const PeerConnectionObserver());

      // User hangs up immediately (before setup completes)
      final disposeFuture = manager.disposePeerConnection(callId);

      // Setup finishes eventually
      final pc = await pcFuture;

      // Bloc calls complete() as part of the flow
      manager.complete(callId, pc);

      // Disposal finishes
      await disposeFuture;

      // Expectation: Manager detects the state was removed and closes the "Orphan" PC immediately.
      expect(await manager.retrieve(callId, allowWaiting: false), isNull);

      // Verify the PC is actually closed natively
      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);
      expect(pc.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));
    });
  });

  group('PeerConnectionManager Integration (Advanced Concurrency & Error Handling)', () {
    /// Scenario: Multi-line management.
    /// Context: User has an active call on Line 1 and receives a call on Line 2.
    /// [CallBloc] manages multiple UUIDs simultaneously.
    test('Scenario: Concurrent Calls (Line 1 & Line 2 isolation)', () async {
      const callId1 = 'line-1-uuid';
      const callId2 = 'line-2-uuid';

      // Initialize both lines
      manager.add(callId1);
      manager.add(callId2);

      // Create connections
      final pc1 = await manager.createPeerConnection(callId1, observer: const PeerConnectionObserver());
      final pc2 = await manager.createPeerConnection(callId2, observer: const PeerConnectionObserver());

      // Complete setup
      manager.complete(callId1, pc1);
      manager.complete(callId2, pc2);

      // Verify independence
      expect(await manager.retrieve(callId1), equals(pc1));
      expect(await manager.retrieve(callId2), equals(pc2));
      expect(pc1, isNot(equals(pc2)));

      // Dispose Line 1 (User hangs up one call)
      await manager.disposePeerConnection(callId1);

      // Verify Line 1 is dead, but Line 2 is still alive
      expect(await manager.retrieve(callId1, allowWaiting: false), isNull);
      await _waitForSignalingState(pc1, RTCSignalingState.RTCSignalingStateClosed);
      expect(pc1.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));

      // Line 2 must remain untouched
      final retrievedPc2 = await manager.retrieve(callId2);
      expect(retrievedPc2, isNotNull);
      expect(retrievedPc2!.signalingState, isNot(equals(RTCSignalingState.RTCSignalingStateClosed)));
    });

    /// Scenario: Waiting for a connection that never completes (Timeout).
    /// Context: `CallBloc` waits for `retrieve()` but the setup process hangs or crashes silently.
    /// The manager must throw a TimeoutException to unblock the Bloc.
    test('Scenario: Retrieve Timeout (Deadlock prevention)', () async {
      const callId = 'timeout-uuid';

      // Create a specific manager with a short timeout for this test
      final fastManager = PeerConnectionManager(
        factory: const DefaultPeerConnectionFactory(),
        retrieveTimeout: const Duration(milliseconds: 200),
      );
      addTearDown(fastManager.dispose);

      fastManager.add(callId);
      // Purposefully do NOT call complete()

      final stopwatch = Stopwatch()..start();

      // Expect a timeout
      await expectLater(fastManager.retrieve(callId), throwsA(isA<TimeoutException>()));

      stopwatch.stop();
      // Verify it waited at least the timeout duration
      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(200));
    });

    /// Scenario: Handshake cleanup logic.
    /// Context: [CallBloc._onSignalingStateHandshake] uses `conditionalCompleteError`
    /// to kill pending "ghost" calls without disturbing active valid calls.
    test('Scenario: Conditional Error Completion (Handshake Logic)', () async {
      const pendingCallId = 'ghost-uuid';
      const activeCallId = 'active-uuid';
      final error = Exception('Request Terminated');

      // Setup: One pending call, one active call
      manager.add(pendingCallId);
      manager.add(activeCallId);

      final pc = await manager.createPeerConnection(activeCallId, observer: const PeerConnectionObserver());
      manager.complete(activeCallId, pc);

      // Action: Signal Handshake arrives and decides to kill both
      // (simulating a logic that iterates over calls)
      manager.conditionalCompleteError(pendingCallId, error);
      manager.conditionalCompleteError(activeCallId, error);

      // Verification:

      // 1. Pending call should throw the error (stopping any `await retrieve()`)
      await expectLater(manager.retrieve(pendingCallId), throwsA(equals(error)));

      // 2. Active call should IGNORE the error and return the valid PC
      // because it was already completed successfully.
      expect(await manager.retrieve(activeCallId), equals(pc));
      expect(pc.signalingState, isNot(equals(RTCSignalingState.RTCSignalingStateClosed)));
    });

    /// Scenario: Full Cleanup.
    /// Context: App logout or `CallBloc.close()`.
    /// Ensures `dispose()` handles a mix of active, pending, and disposing states safely.
    test('Scenario: Bulk Dispose (App Logout)', () async {
      const idActive = 'active';
      const idPending = 'pending';
      const idDisposing = 'disposing';

      // 1. Setup Active
      manager.add(idActive);
      final pc = await manager.createPeerConnection(idActive, observer: const PeerConnectionObserver());
      manager.complete(idActive, pc);

      // 2. Setup Pending (Added but not completed)
      manager.add(idPending);

      // 3. Setup Disposing (Already in process of closing)
      manager.add(idDisposing);
      final pcDisposing = await manager.createPeerConnection(idDisposing, observer: const PeerConnectionObserver());
      manager.complete(idDisposing, pcDisposing);
      // Fire and forget disposal to create "barrier" state
      final disposalFuture = manager.disposePeerConnection(idDisposing);

      // 4. Perform Global Dispose
      await manager.dispose();

      // 5. Verification
      await disposalFuture; // Should be done

      // Active -> Closed
      expect(await manager.retrieve(idActive, allowWaiting: false), isNull);
      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);
      expect(pc.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));

      // Pending -> Null (Removed from state)
      expect(await manager.retrieve(idPending, allowWaiting: false), isNull);

      // Disposing -> Closed
      expect(await manager.retrieve(idDisposing, allowWaiting: false), isNull);
      expect(pcDisposing.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));
    });
  });

  group('PeerConnectionManager Integration (Edge Cases & Unpredictable Events)', () {
    /// Scenario: Late Completion (Zombie Protection).
    /// Context: A race condition where `createPeerConnection` finishes AFTER the call
    /// was already disposed (e.g. user cancelled while camera was initializing).
    /// The manager must detect that the slot is gone and close the "orphan" PC immediately.
    test('Scenario: Late Completion (Zombie PC Cleanup)', () async {
      const callId = 'zombie-uuid';

      // Start flow
      manager.add(callId);

      // Create a real PC (simulate a slow factory)
      // Manually created here to control the timing of 'complete'
      final pc = await const DefaultPeerConnectionFactory().create();

      // User hangs up BEFORE completion
      await manager.disposePeerConnection(callId);

      // Factory finishes and calls complete() on a disposed session
      manager.complete(callId, pc);

      // Verification:
      // The manager should have called pc.close() internally because the state was missing.
      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);
      expect(pc.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));
    });

    /// Scenario: Double Dispose.
    /// Context: UI triggers "End Call" twice, or both Signaling and UI trigger hangup simultaneously.
    /// The manager must handle redundant dispose calls gracefully without crashing.
    test('Scenario: Idempotent Dispose (Double Hangup)', () async {
      const callId = 'double-tap-uuid';

      manager.add(callId);
      final pc = await manager.createPeerConnection(callId, observer: const PeerConnectionObserver());
      manager.complete(callId, pc);

      // First Dispose
      await manager.disposePeerConnection(callId);

      // Second Dispose (Duplicate)
      // Should not throw
      await manager.disposePeerConnection(callId);

      // Verify final state is clean
      expect(await manager.retrieve(callId, allowWaiting: false), isNull);
      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);
      expect(pc.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));
    });

    /// Scenario: External/Native Closure.
    /// Context: The WebRTC engine closes the connection due to network failure or OS resource reclamation,
    /// occurring outside the Manager's control.
    /// The Manager continues to hold the reference until explicitly disposed, avoiding null pointer crashes in the Bloc.
    test('Scenario: External Native Close (Resilience)', () async {
      const callId = 'native-crash-uuid';

      manager.add(callId);
      final pc = await manager.createPeerConnection(callId, observer: const PeerConnectionObserver());
      manager.complete(callId, pc);

      // Simulate external closure (e.g. native layer error)
      await pc.close();

      // Retrieve should still succeed (Manager holds the object reference)
      // This ensures the Bloc can still access the object to log final stats or cleanup listeners
      final retrievedPc = await manager.retrieve(callId);
      expect(retrievedPc, isNotNull);
      // Depending on native implementation timing, state might be closed or closing
      // We rely on the object identity primarily here
      expect(retrievedPc, equals(pc));

      // Official Dispose
      await manager.disposePeerConnection(callId);
      expect(await manager.retrieve(callId, allowWaiting: false), isNull);
    });

    /// Scenario: Immediate Dispose before Create.
    /// Context: `add` is called, but `dispose` arrives before `create` is even invoked/awaited.
    /// Tests the Completer's behavior when the barrier is broken early.
    test('Scenario: Pre-emptive Dispose (Cancel before Start)', () async {
      const callId = 'pre-emptive-uuid';

      manager.add(callId);

      // Start retrieving (simulate Bloc waiting)
      final retrieveFuture = manager.retrieve(callId);

      // Register the expectation BEFORE triggering the error to avoid unhandled exception
      final expectation = expectLater(retrieveFuture, throwsA(isA<StateError>()));

      // Trigger Dispose (causes the error in retrieveFuture)
      await manager.disposePeerConnection(callId);

      // Await the expectation result
      await expectation;
    });
  });
}

/// Helper to poll for a specific signaling state.
/// Necessary because native state updates might lag slightly behind Dart execution.
Future<void> _waitForSignalingState(RTCPeerConnection pc, RTCSignalingState expectedState) async {
  if (pc.signalingState == expectedState) return;

  final completer = Completer<void>();
  final timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
    if (pc.signalingState == expectedState) {
      timer.cancel();
      if (!completer.isCompleted) completer.complete();
    }
  });

  return completer.future.timeout(
    const Duration(seconds: 5),
    onTimeout: () {
      timer.cancel();
      throw TimeoutException('Signaling state did not become $expectedState. Current: ${pc.signalingState}');
    },
  );
}
