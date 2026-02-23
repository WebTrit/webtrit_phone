import 'dart:async';
import 'dart:convert';

import 'package:fake_async/fake_async.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

class MockWebSocketChannel extends Mock implements WebSocketChannel {}

class MockWebSocketSink extends Mock implements WebSocketSink {}

/// Helper to create a valid handshake state JSON string.
String _handshakeJson({int keepaliveInterval = 100}) {
  return jsonEncode({
    'handshake': 'state',
    'timestamp': 1705322000000,
    'keepalive_interval': keepaliveInterval,
    'registration': {'status': 'registered'},
    'lines': [],
    'user_active_calls': [],
    'presence_contacts_info': {},
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
    when(() => mockSink.close(any(), any())).thenAnswer((_) => Future.value());
  });

  tearDown(() {
    streamController.close();
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
        async.elapse(const Duration(milliseconds: 200));

        verify(() => mockSink.add(any())).called(greaterThan(0));
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
        async.flushMicrotasks();

        // Simulate socket closed before next keepalive.
        when(() => mockChannel.closeCode).thenReturn(1000);

        // Wait well beyond second keepalive interval — timer should not restart.
        async.elapse(const Duration(milliseconds: 500));
        async.flushMicrotasks();

        // Only one keepalive request should have been sent.
        expect(keepaliveRequestCount, equals(1));
      });
    });
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

      await expectLater(() => client.execute(request), throwsA(isA<WebtritSignalingBadStateException>()));
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

      await expectLater(() => client.execute(request), throwsA(isA<WebtritSignalingBadStateException>()));
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
