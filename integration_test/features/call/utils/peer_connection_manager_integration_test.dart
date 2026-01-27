import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/features/call/utils/utils.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Allows tests to keep running even if UI updates are happening.
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  late StreamSubscription<LogRecord> logSubscription;

  setUpAll(() {
    Logger.root.level = Level.ALL;
    logSubscription = Logger.root.onRecord.listen((record) {
      // ignore: avoid_print
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  });

  tearDownAll(() async {
    await logSubscription.cancel();
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
    // Allow microtasks to clear to prevent test leakage
    await Future.delayed(const Duration(milliseconds: 100));
  });

  group('PeerConnectionManager Integration (Real WebRTC)', () {
    testWidgets('establishes a loopback connection between two peers', (tester) async {
      const callerId = 'caller-uuid';
      const calleeId = 'callee-uuid';

      manager.add(callerId);
      manager.add(calleeId);

      // 1. Setup Observers & Completers
      final callerCandidates = <RTCIceCandidate>[];
      final calleeCandidates = <RTCIceCandidate>[];
      final callerConnected = Completer<void>();
      final calleeConnected = Completer<void>();

      void onIceConnectionState(RTCIceConnectionState state, Completer<void> completer) {
        if (state == RTCIceConnectionState.RTCIceConnectionStateConnected && !completer.isCompleted) {
          completer.complete();
        }
      }

      final pcCaller = await manager.createPeerConnection(
        callerId,
        observer: PeerConnectionObserver(
          onIceCandidate: callerCandidates.add,
          onIceConnectionState: (s) => onIceConnectionState(s, callerConnected),
        ),
      );

      final pcCallee = await manager.createPeerConnection(
        calleeId,
        observer: PeerConnectionObserver(
          onIceCandidate: calleeCandidates.add,
          onIceConnectionState: (s) => onIceConnectionState(s, calleeConnected),
        ),
      );

      // Create Data Channel to ensure negotiation triggers
      await pcCaller.createDataChannel('test_channel', RTCDataChannelInit());

      manager.complete(callerId, pcCaller);
      manager.complete(calleeId, pcCallee);

      // 2. Negotiation (Simulated Signaling)
      final offer = await pcCaller.createOffer({});
      await pcCaller.setLocalDescription(offer);
      await pcCallee.setRemoteDescription(offer);

      final answer = await pcCallee.createAnswer({});
      await pcCallee.setLocalDescription(answer);
      await pcCaller.setRemoteDescription(answer);

      // Exchange ICE Candidates (Trickle simulation)
      await tester.pump(const Duration(milliseconds: 500));

      for (final c in callerCandidates) {
        await pcCallee.addCandidate(c);
      }
      for (final c in calleeCandidates) {
        await pcCaller.addCandidate(c);
      }

      // 3. Verification
      await expectLater(callerConnected.future.timeout(const Duration(seconds: 10)), completes);
      await expectLater(calleeConnected.future.timeout(const Duration(seconds: 10)), completes);

      expect(await manager.retrieve(callerId), equals(pcCaller));
      expect(await manager.retrieve(calleeId), equals(pcCallee));

      // 4. Cleanup & Disposal Check
      await manager.disposePeerConnection(callerId);

      expect(await manager.retrieve(callerId, allowWaiting: false), isNull);

      await _waitForSignalingState(pcCaller, RTCSignalingState.RTCSignalingStateClosed);
      expect(pcCaller.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));

      // Callee should still be alive
      expect(await manager.retrieve(calleeId), isNotNull);

      await tester.pumpAndSettle();
    });

    testWidgets('Real Race Condition: dispose while negotiating', (tester) async {
      const raceUuid = 'race-uuid';
      manager.add(raceUuid);

      // Start creating a real connection
      final futurePc = manager.createPeerConnection(raceUuid, observer: const PeerConnectionObserver());

      // Trigger dispose IMMEDIATELY while creation is in flight
      final disposeFuture = manager.disposePeerConnection(raceUuid);

      final pc = await futurePc;
      await disposeFuture;

      // The manager should detect it was disposed and close the orphan
      manager.complete(raceUuid, pc);

      expect(await manager.retrieve(raceUuid), isNull);

      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);
      expect(pc.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));

      await tester.pumpAndSettle();
    });
  });

  group('PeerConnectionManager Integration (Bloc Scenarios)', () {
    testWidgets('Scenario: Full outgoing call lifecycle (Happy Path)', (tester) async {
      const callId = 'outgoing-call-uuid';

      manager.add(callId);
      final pc = await manager.createPeerConnection(callId, observer: const PeerConnectionObserver());

      // Simulate adding tracks/channels
      await pc.createDataChannel('test', RTCDataChannelInit());
      final offer = await pc.createOffer({});
      await pc.setLocalDescription(offer);

      manager.complete(callId, pc);

      final retrievedPc = await manager.retrieve(callId);
      expect(retrievedPc, equals(pc));
      expect(retrievedPc!.signalingState, equals(RTCSignalingState.RTCSignalingStateHaveLocalOffer));

      await manager.disposePeerConnection(callId);

      expect(await manager.retrieve(callId, allowWaiting: false), isNull);
      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);

      await tester.pumpAndSettle();
    });

    testWidgets('Scenario: Call setup failure (e.g. UserMedia/SDP error)', (tester) async {
      const callId = 'error-call-uuid';
      final expectedError = Exception('Simulated UserMedia Error');

      manager.add(callId);
      final pc = await manager.createPeerConnection(callId, observer: const PeerConnectionObserver());

      // Simulate failure logic in Bloc
      manager.completeError(callId, expectedError);

      expect(
        manager.retrieve(callId),
        throwsA(equals(expectedError)),
        reason: 'Manager should propagate the setup error to any waiters',
      );

      await manager.disposePeerConnection(callId);
      await pc.close(); // Cleanup manual instance
      await tester.pumpAndSettle();
    });

    testWidgets('Scenario: Rapid Reconnect (Disposal Barrier on Real Hardware)', (tester) async {
      const callId = 'reconnect-uuid';

      // Cycle 1
      manager.add(callId);
      final pc1 = await manager.createPeerConnection(callId, observer: const PeerConnectionObserver());
      manager.complete(callId, pc1);

      final disposeFuture = manager.disposePeerConnection(callId);

      // Cycle 2 (Same ID, immediate re-add)
      manager.add(callId);
      final pc2 = await manager.createPeerConnection(callId, observer: const PeerConnectionObserver());

      await disposeFuture;
      manager.complete(callId, pc2);

      expect(
        pc1.signalingState,
        anyOf(equals(RTCSignalingState.RTCSignalingStateClosed), isNull),
        reason: 'Cycle 1 PC should be closed',
      );

      expect(pc2, isNot(equals(pc1)), reason: 'Cycle 2 PC must be a new instance');

      // Functional Liveness Check
      await expectLater(
        () async {
          final offer = await pc2.createOffer();
          expect(offer.sdp, isNotNull, reason: 'Generated SDP should not be null');
          expect(offer.sdp, isNotEmpty, reason: 'Generated SDP should not be empty');
        }(),
        completes,
        reason: 'Cycle 2 PC failed to create offer. The native object may be invalid.',
      );

      await tester.pumpAndSettle();
    });

    testWidgets('Scenario: Hangup during initialization (Orphan Handling)', (tester) async {
      const callId = 'orphan-uuid';
      manager.add(callId);

      final pcFuture = manager.createPeerConnection(callId, observer: const PeerConnectionObserver());

      // User hangs up immediately
      final disposeFuture = manager.disposePeerConnection(callId);

      final pc = await pcFuture;
      manager.complete(callId, pc);

      await disposeFuture;

      expect(await manager.retrieve(callId, allowWaiting: false), isNull);
      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);

      await tester.pumpAndSettle();
    });
  });

  group('PeerConnectionManager Integration (Advanced Concurrency & Error Handling)', () {
    testWidgets('Scenario: Concurrent Calls (Line 1 & Line 2 isolation)', (tester) async {
      const callId1 = 'line-1-uuid';
      const callId2 = 'line-2-uuid';

      manager.add(callId1);
      manager.add(callId2);

      final pc1 = await manager.createPeerConnection(callId1, observer: const PeerConnectionObserver());
      final pc2 = await manager.createPeerConnection(callId2, observer: const PeerConnectionObserver());

      manager.complete(callId1, pc1);
      manager.complete(callId2, pc2);

      expect(await manager.retrieve(callId1), equals(pc1));
      expect(await manager.retrieve(callId2), equals(pc2));

      // Dispose Line 1 only
      await manager.disposePeerConnection(callId1);

      expect(await manager.retrieve(callId1, allowWaiting: false), isNull);
      await _waitForSignalingState(pc1, RTCSignalingState.RTCSignalingStateClosed);

      // Line 2 must remain untouched
      final retrievedPc2 = await manager.retrieve(callId2);
      expect(retrievedPc2?.signalingState, isNot(equals(RTCSignalingState.RTCSignalingStateClosed)));

      await tester.pumpAndSettle();
    });

    testWidgets('Scenario: Retrieve Timeout (Deadlock prevention)', (tester) async {
      const callId = 'timeout-uuid';
      final fastManager = PeerConnectionManager(
        factory: const DefaultPeerConnectionFactory(),
        retrieveTimeout: const Duration(milliseconds: 200),
      );
      addTearDown(fastManager.dispose);

      fastManager.add(callId);
      // Purposefully do NOT call complete()

      final stopwatch = Stopwatch()..start();
      await expectLater(fastManager.retrieve(callId), throwsA(isA<TimeoutException>()));
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(200));
      await tester.pumpAndSettle();
    });

    testWidgets('Scenario: Conditional Error Completion (Handshake Logic)', (tester) async {
      const pendingCallId = 'ghost-uuid';
      const activeCallId = 'active-uuid';
      final error = Exception('Request Terminated');

      manager.add(pendingCallId);
      manager.add(activeCallId);

      final pc = await manager.createPeerConnection(activeCallId, observer: const PeerConnectionObserver());
      manager.complete(activeCallId, pc);

      // Kill both via Handshake logic
      manager.conditionalCompleteError(pendingCallId, error);
      manager.conditionalCompleteError(activeCallId, error);

      // Pending call should throw
      await expectLater(manager.retrieve(pendingCallId), throwsA(equals(error)));

      // Active call should IGNORE error
      expect(await manager.retrieve(activeCallId), equals(pc));
      expect(pc.signalingState, isNot(equals(RTCSignalingState.RTCSignalingStateClosed)));

      await tester.pumpAndSettle();
    });

    testWidgets('Scenario: Bulk Dispose (App Logout)', (tester) async {
      const idActive = 'active';
      const idPending = 'pending';
      const idDisposing = 'disposing';

      manager.add(idActive);
      final pc = await manager.createPeerConnection(idActive, observer: const PeerConnectionObserver());
      manager.complete(idActive, pc);

      manager.add(idPending);

      manager.add(idDisposing);
      final pcDisposing = await manager.createPeerConnection(idDisposing, observer: const PeerConnectionObserver());
      manager.complete(idDisposing, pcDisposing);
      final disposalFuture = manager.disposePeerConnection(idDisposing);

      // Perform Global Dispose
      await manager.dispose();
      await disposalFuture;

      expect(await manager.retrieve(idActive, allowWaiting: false), isNull);
      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);

      expect(await manager.retrieve(idPending, allowWaiting: false), isNull);
      expect(await manager.retrieve(idDisposing, allowWaiting: false), isNull);

      await tester.pumpAndSettle();
    });
  });

  group('PeerConnectionManager Integration (Edge Cases)', () {
    testWidgets('Scenario: Late Completion (Zombie PC Cleanup)', (tester) async {
      const callId = 'zombie-uuid';
      manager.add(callId);

      // Manually created to control timing
      final pc = await const DefaultPeerConnectionFactory().create();

      // User hangs up BEFORE completion
      await manager.disposePeerConnection(callId);

      // Factory finishes late
      manager.complete(callId, pc);

      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);
      expect(pc.signalingState, equals(RTCSignalingState.RTCSignalingStateClosed));

      await tester.pumpAndSettle();
    });

    testWidgets('Scenario: Idempotent Dispose (Double Hangup)', (tester) async {
      const callId = 'double-tap-uuid';

      manager.add(callId);
      final pc = await manager.createPeerConnection(callId, observer: const PeerConnectionObserver());
      manager.complete(callId, pc);

      await manager.disposePeerConnection(callId);
      // Duplicate call should not throw
      await manager.disposePeerConnection(callId);

      expect(await manager.retrieve(callId, allowWaiting: false), isNull);
      await _waitForSignalingState(pc, RTCSignalingState.RTCSignalingStateClosed);

      await tester.pumpAndSettle();
    });

    testWidgets('Scenario: External Native Close (Resilience)', (tester) async {
      const callId = 'native-crash-uuid';

      manager.add(callId);
      final pc = await manager.createPeerConnection(callId, observer: const PeerConnectionObserver());
      manager.complete(callId, pc);

      // Simulate external/native closure
      await pc.close();

      // Manager should still hold the reference for cleanup
      final retrievedPc = await manager.retrieve(callId);
      expect(retrievedPc, equals(pc));

      await manager.disposePeerConnection(callId);
      expect(await manager.retrieve(callId, allowWaiting: false), isNull);

      await tester.pumpAndSettle();
    });

    testWidgets('Scenario: Pre-emptive Dispose (Cancel before Start)', (tester) async {
      const callId = 'pre-emptive-uuid';
      manager.add(callId);

      final retrieveFuture = manager.retrieve(callId);
      final expectation = expectLater(retrieveFuture, throwsA(isA<StateError>()));

      // Trigger Dispose (causes the error in retrieveFuture)
      await manager.disposePeerConnection(callId);
      await expectation;

      await tester.pumpAndSettle();
    });
  });
}

/// Helper to poll for a specific signaling state.
Future<void> _waitForSignalingState(RTCPeerConnection pc, RTCSignalingState expectedState) async {
  if (pc.signalingState == expectedState) return;

  final completer = Completer<void>();
  final timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
    if (pc.signalingState == expectedState) {
      timer.cancel();
      if (!completer.isCompleted) completer.complete();
    }
  });

  try {
    await completer.future.timeout(const Duration(seconds: 5));
  } on TimeoutException {
    timer.cancel();
    throw TimeoutException('Signaling state did not become $expectedState. Current: ${pc.signalingState}');
  }
}
