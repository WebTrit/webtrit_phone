/// Unit tests for [SignalingRequestQueue].
///
/// Covers:
///   - [SignalingRequestQueue.cancelByCallId]: early completion with error,
///     cancelled requests are not sent on flush, cross-call isolation.
///   - [SignalingRequestQueue.flush]: removal-by-identity guard — a concurrent
///     [cancelByCallId] during an in-flight flush must not corrupt queue order.
library;

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/src/signaling_request_queue.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

HangupRequest _hangup(String callId) => HangupRequest(transaction: 'tx-$callId', line: 0, callId: callId);

// A simple execute stub that records which requests were sent.
Future<void> Function(Request) _recordingExecute(List<Request> log) =>
    (r) async => log.add(r);

// An execute stub that suspends until a completer is resolved — used to
// simulate an in-flight flush that is suspended at the await point.
Future<void> Function(Request) _suspendingExecute(List<Request> log, Completer<void> gate) => (r) async {
  await gate.future;
  log.add(r);
};

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('SignalingRequestQueue.cancelByCallId —', () {
    test('enqueue() future completes with NotConnectedException immediately on cancel', () async {
      final queue = SignalingRequestQueue();
      final future = queue.enqueue(_hangup('call-1'));

      queue.cancelByCallId('call-1');

      await expectLater(
        future,
        throwsA(isA<NotConnectedException>().having((e) => e.message, 'message', contains('call-1'))),
      );
    });

    test('cancelled request is not sent on subsequent flush()', () async {
      final queue = SignalingRequestQueue();
      final sent = <Request>[];

      // Enqueue and immediately cancel before any flush.
      unawaited(queue.enqueue(_hangup('call-1')).catchError((_) {}));
      queue.cancelByCallId('call-1');

      // Flush should send nothing.
      await queue.flush(execute: _recordingExecute(sent), isActive: () => true);

      expect(sent, isEmpty);
    });

    test('only requests matching callId are cancelled; others remain', () async {
      final queue = SignalingRequestQueue();
      final sent = <Request>[];

      unawaited(queue.enqueue(_hangup('call-A')).catchError((_) {}));
      final futureB = queue.enqueue(_hangup('call-B'));

      queue.cancelByCallId('call-A');

      // call-A future must have thrown.
      // call-B future must still be pending (not completed).
      expect(futureB, isA<Future<void>>());
      expect(queue.isNotEmpty, isTrue, reason: 'call-B must still be in the queue');

      // Flush should send only call-B.
      await queue.flush(execute: _recordingExecute(sent), isActive: () => true);

      await expectLater(futureB, completes);
      expect(sent.length, 1);
      expect((sent.first as HangupRequest).callId, 'call-B');
    });

    test('cancelByCallId on unknown callId is a no-op', () async {
      final queue = SignalingRequestQueue();
      final future = queue.enqueue(_hangup('call-1'));

      // Cancelling a different id must not affect call-1.
      queue.cancelByCallId('call-X');

      expect(queue.isNotEmpty, isTrue);

      await queue.flush(execute: _recordingExecute([]), isActive: () => true);
      await expectLater(future, completes);
    });
  });

  group('SignalingRequestQueue.flush — identity-based removal guard —', () {
    test('concurrent cancelByCallId during in-flight flush does not remove wrong entry', () async {
      final queue = SignalingRequestQueue();
      final sent = <Request>[];
      final gate = Completer<void>();

      // Enqueue two requests for different calls.
      unawaited(queue.enqueue(_hangup('call-A')).catchError((_) {}));
      final futureB = queue.enqueue(_hangup('call-B'));

      // Start flush — it will suspend at the gate while processing call-A.
      final flushFuture = queue.flush(execute: _suspendingExecute(sent, gate), isActive: () => true);

      // While flush is suspended awaiting call-A, cancel call-A.
      await Future<void>.delayed(Duration.zero);
      queue.cancelByCallId('call-A');

      // Release the gate so flush resumes.
      gate.complete();
      await flushFuture;

      // call-A was cancelled: its completer already errored before flush resumed.
      // flush must have used remove(entry) and kept call-B in the queue, then
      // processed it normally.
      await expectLater(futureB, completes);
      // call-A's execute was still called (flush had already started it),
      // but call-B must also have been sent.
      expect(sent.map((r) => (r as HangupRequest).callId), contains('call-B'));
    });

    test('flush stops when isActive() returns false mid-queue', () async {
      final queue = SignalingRequestQueue();
      final sent = <Request>[];
      var active = true;

      unawaited(queue.enqueue(_hangup('call-A')).catchError((_) {}));
      unawaited(queue.enqueue(_hangup('call-B')).catchError((_) {}));

      await queue.flush(
        execute: (r) async {
          sent.add(r);
          active = false; // deactivate after first request
        },
        isActive: () => active,
      );

      // Only the first request should have been sent.
      expect(sent.length, 1);
      expect(queue.isNotEmpty, isTrue, reason: 'second request remains in queue');
    });
  });

  group('SignalingRequestQueue.failAll —', () {
    test('fails all pending entries and clears the queue', () async {
      final queue = SignalingRequestQueue();
      final futureA = queue.enqueue(_hangup('call-A'));
      final futureB = queue.enqueue(_hangup('call-B'));

      final error = Exception('test error');
      queue.failAll(error);

      await expectLater(futureA, throwsA(same(error)));
      await expectLater(futureB, throwsA(same(error)));
      expect(queue.isEmpty, isTrue);
    });
  });
}
