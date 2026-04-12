import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

import 'package:webtrit_signaling/src/exceptions.dart';
import 'package:webtrit_signaling/src/transaction.dart';

void main() {
  const clientId = 0;
  const timeout = Duration(seconds: 5);

  // Helper to suppress unhandled future errors inside fakeAsync blocks.
  // catchError must return the same type as the future.
  void suppressError(Transaction tx) {
    unawaited(tx.future.catchError((_) => <String, dynamic>{}));
  }

  group('Transaction.handleResponse', () {
    test('completes future with response value', () async {
      final tx = Transaction(signalingClientId: clientId, timeoutDuration: timeout);
      tx.handleResponse({'response': 'ack'});
      expect(await tx.future, {'response': 'ack'});
    });

    test('cancels timeout — timer does not fire after response', () {
      fakeAsync((async) {
        final tx = Transaction(signalingClientId: clientId, timeoutDuration: timeout);
        tx.handleResponse({'response': 'ack'});

        Object? error;
        unawaited(
          tx.future.catchError((e) {
            error = e;
            return <String, dynamic>{};
          }),
        );
        async.elapse(timeout * 2);

        expect(error, isNull);
      });
    });

    test('second call is silently ignored — no StateError', () async {
      final tx = Transaction(signalingClientId: clientId, timeoutDuration: timeout);
      tx.handleResponse({'first': true});
      expect(() => tx.handleResponse({'second': true}), returnsNormally);
      expect(await tx.future, {'first': true});
    });

    test('late call after timeout does not throw StateError', () {
      fakeAsync((async) {
        final tx = Transaction(signalingClientId: clientId, timeoutDuration: timeout);
        suppressError(tx);
        async.elapse(timeout);
        expect(() => tx.handleResponse({'late': 'response'}), returnsNormally);
      });
    });
  });

  group('Transaction.terminateByDisconnect', () {
    test('completes future with disconnect error', () {
      final tx = Transaction(signalingClientId: clientId, timeoutDuration: timeout);
      tx.terminateByDisconnect(1000, 'normal');
      expect(tx.future, throwsA(isA<WebtritSignalingTransactionTerminateByDisconnectException>()));
    });

    test('cancels timeout — timer does not fire after disconnect', () {
      fakeAsync((async) {
        final tx = Transaction(signalingClientId: clientId, timeoutDuration: timeout);

        Object? capturedError;
        unawaited(
          tx.future.catchError((e) {
            capturedError = e;
            return <String, dynamic>{};
          }),
        );

        tx.terminateByDisconnect();
        async.flushMicrotasks();
        async.elapse(timeout * 2);

        expect(capturedError, isA<WebtritSignalingTransactionTerminateByDisconnectException>());
      });
    });

    test('late call after timeout does not throw StateError', () {
      fakeAsync((async) {
        final tx = Transaction(signalingClientId: clientId, timeoutDuration: timeout);
        suppressError(tx);
        async.elapse(timeout);
        expect(() => tx.terminateByDisconnect(1001, 'going away'), returnsNormally);
      });
    });
  });

  group('Transaction timeout', () {
    test('completes future with timeout error after duration elapses', () {
      fakeAsync((async) {
        final tx = Transaction(signalingClientId: clientId, timeoutDuration: timeout);

        Object? capturedError;
        unawaited(
          tx.future.catchError((e) {
            capturedError = e;
            return <String, dynamic>{};
          }),
        );

        expect(capturedError, isNull);
        async.elapse(timeout);
        expect(capturedError, isA<WebtritSignalingTransactionTimeoutException>());
      });
    });

    test('does not fire if handleResponse called first', () {
      fakeAsync((async) {
        final tx = Transaction(signalingClientId: clientId, timeoutDuration: timeout);
        tx.handleResponse({'ok': true});

        Object? error;
        unawaited(
          tx.future.catchError((e) {
            error = e;
            return <String, dynamic>{};
          }),
        );
        async.elapse(timeout * 2);

        expect(error, isNull);
      });
    });
  });
}
