import 'dart:async';
import 'dart:convert';

import 'package:fake_async/fake_async.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

class MockWebSocketChannel extends Mock implements WebSocketChannel {}

class MockWebSocketSink extends Mock implements WebSocketSink {}

// Keepalive interval used by _handshakeJson() - drives all timing calculations below.
const _kKeepaliveIntervalMs = 100;
const _kKeepaliveInterval = Duration(milliseconds: _kKeepaliveIntervalMs);

/// Helper to create a valid handshake state JSON string.
String _handshakeJson({int keepaliveInterval = _kKeepaliveIntervalMs}) {
  return jsonEncode({
    'handshake': 'state',
    'timestamp': 1705322000000,
    'keepalive_interval': keepaliveInterval,
    'registration': {'status': 'registered'},
    'lines': [],
    'dialog_infos': [],
    'presence_infos': [],
    'guest_line': null,
  });
}

void main() {
  late MockWebSocketChannel mockChannel;
  late MockWebSocketSink mockSink;
  late StreamController<dynamic> streamController;

  setUp(() {
    mockChannel = MockWebSocketChannel();
    mockSink = MockWebSocketSink();
    streamController = StreamController<dynamic>();

    when(() => mockChannel.sink).thenReturn(mockSink);
    when(() => mockChannel.stream).thenAnswer((_) => streamController.stream);
    when(() => mockChannel.closeCode).thenReturn(null);
    when(() => mockChannel.closeReason).thenReturn(null);
    when(() => mockSink.close(any(), any())).thenAnswer((_) => Future.value());
  });

  tearDown(() async {
    await streamController.close();
  });

  group('Keepalive race condition', () {
    test('should gracefully stop keepalive loop when timer fires on a closed socket', () {
      fakeAsync((async) {
        final client = WebtritSignalingClient.inner(mockChannel);

        var errorReported = false;
        Object? reportedError;

        client.listen(
          onStateHandshake: (_) {},
          onEvent: (_) {},
          onError: (e, s) {
            errorReported = true;
            reportedError = e;
          },
          onDisconnect: (_, _) {},
        );

        var isPhysicalSocketClosed = false;

        when(() => mockSink.add(any())).thenAnswer((_) {
          if (isPhysicalSocketClosed) {
            throw StateError('Cannot add event after closing.');
          }
        });

        streamController.add(_handshakeJson());
        async.flushMicrotasks();

        // Simulate physical connection drop.
        isPhysicalSocketClosed = true;

        // Advance past the keepalive interval.
        async.elapse(_kKeepaliveInterval * 2);

        verify(() => mockSink.add(any())).called(1);
        expect(errorReported, isFalse, reason: 'Race condition leaked to onError: $reportedError');
      });
    });

    test('should not restart keepalive timer when closeCode is set after successful keepalive', () {
      fakeAsync((async) {
        final client = WebtritSignalingClient.inner(mockChannel);

        String? capturedTransactionId;
        var keepaliveRequestCount = 0;

        // Capture the transaction ID from outgoing keepalive requests.
        when(() => mockSink.add(any())).thenAnswer((invocation) {
          final data = invocation.positionalArguments[0] as String;
          final json = jsonDecode(data) as Map<String, dynamic>;
          if (json['handshake'] == 'keepalive') {
            capturedTransactionId = json['transaction'] as String?;
            keepaliveRequestCount++;
          }
        });

        client.listen(onStateHandshake: (_) {}, onEvent: (_) {}, onError: (_, _) {}, onDisconnect: (_, _) {});

        // Start keepalive timer via handshake (100ms interval).
        streamController.add(_handshakeJson());
        async.flushMicrotasks();

        // First keepalive fires.
        async.elapse(const Duration(milliseconds: 110));
        async.flushMicrotasks();
        expect(keepaliveRequestCount, equals(1));

        // Respond to first keepalive with matching transaction ID.
        streamController.add(jsonEncode({'handshake': 'keepalive', 'transaction': capturedTransactionId}));

        // Set closeCode BEFORE flushing so _onKeepalive sees it when it resumes.
        when(() => mockChannel.closeCode).thenReturn(1000);
        async.flushMicrotasks();

        // Wait well beyond second keepalive interval — timer should not restart.
        async.elapse(const Duration(milliseconds: 500));
        async.flushMicrotasks();

        // Only one keepalive request should have been sent.
        expect(keepaliveRequestCount, equals(1));

        // Verify closeCode was checked exactly twice: once in _addData (before write),
        // once in _onKeepalive (after response, as the 'no restart' guard).
        // If the timer restarted, closeCode would be accessed a third time.
        verify(() => mockChannel.closeCode).called(2);
      });
    });
  });

  group('Keepalive timeout', () {
    test('should report WebtritSignalingKeepaliveTransactionTimeoutException when server does not respond', () {
      fakeAsync((async) {
        final client = WebtritSignalingClient.inner(mockChannel);

        Object? capturedError;
        when(() => mockSink.add(any())).thenAnswer((_) {});

        client.listen(
          onStateHandshake: (_) {},
          onEvent: (_) {},
          onError: (e, _) => capturedError = e,
          onDisconnect: (_, _) {},
        );

        streamController.add(_handshakeJson());
        async.flushMicrotasks();

        // Keepalive fires after _kKeepaliveInterval, then waits defaultExecuteTransactionTimeoutDuration for a response.
        async.elapse(
          _kKeepaliveInterval +
              WebtritSignalingClient.defaultExecuteTransactionTimeoutDuration +
              const Duration(milliseconds: 100),
        );
        async.flushMicrotasks();

        expect(capturedError, isA<WebtritSignalingKeepaliveTransactionTimeoutException>());
      });
    });
  });

  group('Keepalive normal flow', () {
    test('should restart keepalive timer after successful echo and send second keepalive', () {
      fakeAsync((async) {
        final client = WebtritSignalingClient.inner(mockChannel);

        var keepaliveCount = 0;
        String? lastTransactionId;

        when(() => mockSink.add(any())).thenAnswer((invocation) {
          final data = invocation.positionalArguments[0] as String;
          final decoded = jsonDecode(data) as Map<String, dynamic>;
          if (decoded['handshake'] == 'keepalive') {
            keepaliveCount++;
            lastTransactionId = decoded['transaction'] as String?;
          }
        });

        client.listen(onStateHandshake: (_) {}, onEvent: (_) {}, onError: (_, _) {}, onDisconnect: (_, _) {});

        streamController.add(_handshakeJson());
        async.flushMicrotasks();

        // First keepalive fires.
        async.elapse(const Duration(milliseconds: 110));
        async.flushMicrotasks();
        expect(keepaliveCount, equals(1));

        // Echo the first keepalive.
        streamController.add(jsonEncode({'handshake': 'keepalive', 'transaction': lastTransactionId}));
        async.flushMicrotasks();

        // Second keepalive fires.
        async.elapse(const Duration(milliseconds: 110));
        async.flushMicrotasks();
        expect(keepaliveCount, equals(2));
      });
    });

    test('should complete three keepalive cycles without error', () {
      fakeAsync((async) {
        final client = WebtritSignalingClient.inner(mockChannel);

        var keepaliveCount = 0;
        var errorCount = 0;
        final transactionIds = <String?>[];

        when(() => mockSink.add(any())).thenAnswer((invocation) {
          final data = invocation.positionalArguments[0] as String;
          final decoded = jsonDecode(data) as Map<String, dynamic>;
          if (decoded['handshake'] == 'keepalive') {
            keepaliveCount++;
            transactionIds.add(decoded['transaction'] as String?);
          }
        });

        client.listen(
          onStateHandshake: (_) {},
          onEvent: (_) {},
          onError: (_, _) => errorCount++,
          onDisconnect: (_, _) {},
        );

        streamController.add(_handshakeJson());
        async.flushMicrotasks();

        for (var i = 0; i < 3; i++) {
          async.elapse(const Duration(milliseconds: 110));
          async.flushMicrotasks();
          expect(keepaliveCount, equals(i + 1));
          streamController.add(jsonEncode({'handshake': 'keepalive', 'transaction': transactionIds.last}));
          async.flushMicrotasks();
        }

        expect(errorCount, equals(0));
      });
    });
  });

  group('Disconnect handling', () {
    test('should call onDisconnect with code and reason when stream closes gracefully', () async {
      final client = WebtritSignalingClient.inner(mockChannel);

      int? disconnectCode;
      String? disconnectReason;

      client.listen(
        onStateHandshake: (_) {},
        onEvent: (_) {},
        onError: (_, _) {},
        onDisconnect: (code, reason) {
          disconnectCode = code;
          disconnectReason = reason;
        },
      );

      when(() => mockChannel.closeCode).thenReturn(1000);
      when(() => mockChannel.closeReason).thenReturn('normal closure');

      await streamController.close();
      await Future.delayed(Duration.zero);

      expect(disconnectCode, equals(1000));
      expect(disconnectReason, equals('normal closure'));
    });

    test('should call onError when stream emits an error', () async {
      final client = WebtritSignalingClient.inner(mockChannel);

      Object? capturedError;

      client.listen(
        onStateHandshake: (_) {},
        onEvent: (_) {},
        onError: (e, _) => capturedError = e,
        onDisconnect: (_, _) {},
      );

      final networkError = Exception('network dropped');
      streamController.addError(networkError);
      await Future.delayed(Duration.zero);

      expect(capturedError, equals(networkError));
    });

    test('should throw WebtritSignalingDisconnectedException when execute called after stream closes', () async {
      final client = WebtritSignalingClient.inner(mockChannel);

      client.listen(onStateHandshake: (_) {}, onEvent: (_) {}, onError: (_, _) {}, onDisconnect: (_, _) {});

      await streamController.close();
      await Future.delayed(Duration.zero);

      final request = HangupRequest(transaction: 'test-tx', line: 0, callId: 'test-call-id');
      await expectLater(client.execute(request), throwsA(isA<WebtritSignalingDisconnectedException>()));
    });
  });

  group('Request transaction timeout', () {
    test(
      'should throw WebtritSignalingTransactionTimeoutException (not keepalive variant) when server ignores request',
      () {
        fakeAsync((async) {
          final client = WebtritSignalingClient.inner(mockChannel);

          Object? executeError;
          when(() => mockSink.add(any())).thenAnswer((_) {});

          client.listen(onStateHandshake: (_) {}, onEvent: (_) {}, onError: (_, _) {}, onDisconnect: (_, _) {});

          // Long keepalive interval to prevent interference with the request timeout.
          streamController.add(_handshakeJson(keepaliveInterval: 100000));
          async.flushMicrotasks();

          client
              .execute(HangupRequest(transaction: 'test-tx', line: 0, callId: 'test-call-id'))
              .then<void>(
                (_) {},
                onError: (Object e, _) {
                  executeError = e;
                },
              );

          async.flushMicrotasks();

          // Advance past transaction timeout.
          async.elapse(
            WebtritSignalingClient.defaultExecuteTransactionTimeoutDuration + const Duration(milliseconds: 100),
          );
          async.flushMicrotasks();

          expect(executeError, isA<WebtritSignalingTransactionTimeoutException>());
          expect(executeError, isNot(isA<WebtritSignalingKeepaliveTransactionTimeoutException>()));
        });
      },
    );
  });

  group('Transaction cleanup on send failure', () {
    test('should throw WebtritSignalingBadStateException when sink.add throws StateError', () async {
      final client = WebtritSignalingClient.inner(mockChannel);

      client.listen(onStateHandshake: (_) {}, onEvent: (_) {}, onError: (_, _) {}, onDisconnect: (_, _) {});

      // Initialize client with handshake.
      streamController.add(_handshakeJson());
      await Future.delayed(Duration.zero);

      // Any sink.add throws StateError (socket broken).
      when(() => mockSink.add(any())).thenThrow(StateError('Cannot add event after closing.'));

      final request = HangupRequest(transaction: 'test-tx', line: 0, callId: 'test-call-id');

      await expectLater(client.execute(request), throwsA(isA<WebtritSignalingBadStateException>()));
    });

    test('should throw WebtritSignalingBadStateException when closeCode is already set', () async {
      final client = WebtritSignalingClient.inner(mockChannel);

      client.listen(onStateHandshake: (_) {}, onEvent: (_) {}, onError: (_, _) {}, onDisconnect: (_, _) {});

      // Initialize client with handshake.
      streamController.add(_handshakeJson());
      await Future.delayed(Duration.zero);

      // Socket already closed.
      when(() => mockChannel.closeCode).thenReturn(1000);

      final request = HangupRequest(transaction: 'test-tx', line: 0, callId: 'test-call-id');

      await expectLater(client.execute(request), throwsA(isA<WebtritSignalingBadStateException>()));
    });

    test('should not call sink.add when closeCode is detected before write', () async {
      final client = WebtritSignalingClient.inner(mockChannel);

      client.listen(onStateHandshake: (_) {}, onEvent: (_) {}, onError: (_, _) {}, onDisconnect: (_, _) {});

      // Initialize client with handshake.
      streamController.add(_handshakeJson());
      await Future.delayed(Duration.zero);

      // closeCode set — socket already closed.
      when(() => mockChannel.closeCode).thenReturn(1000);

      final request = HangupRequest(transaction: 'test-tx', line: 0, callId: 'test-call-id');

      try {
        await client.execute(request);
      } on WebtritSignalingBadStateException {
        // Expected.
      }

      // sink.add should NOT have been called — pre-check caught it.
      verifyNever(() => mockSink.add(any()));
    });
  });
}
