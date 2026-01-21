import 'dart:async';
import 'dart:convert';

import 'package:fake_async/fake_async.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

class MockWebSocketChannel extends Mock implements WebSocketChannel {}

class MockWebSocketSink extends Mock implements WebSocketSink {}

void main() {
  group('WebtritSignalingClient Keepalive Race Condition', () {
    late MockWebSocketChannel mockChannel;
    late MockWebSocketSink mockSink;
    late StreamController<dynamic> streamController;
    late WebtritSignalingClient client;

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

    test('should gracefully terminate keepalive loop without error when timer fires on a closed socket', () {
      fakeAsync((async) {
        client = WebtritSignalingClient.inner(mockChannel);

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

        // Throws StateError to simulate writing to a closed sink.
        when(() => mockSink.add(any())).thenAnswer((invocation) {
          if (isPhysicalSocketClosed) {
            throw StateError('Bad state: Cannot add event after closing.');
          }
        });

        // Initiates the Keepalive timer (100ms interval).
        final handshakeData = jsonEncode({
          'handshake': 'state',
          'timestamp': 1705322000000,
          'keepalive_interval': 100,
          'registration': {'status': 'registered'},
          'lines': [],
          'user_active_calls': [],
          'presence_contacts_info': {},
          'guest_line': null,
        });

        streamController.add(handshakeData);
        async.flushMicrotasks();

        // Simulates a physical connection drop without explicit client disconnection.
        // The client remains unaware of the transport failure, allowing the timer to persist.
        isPhysicalSocketClosed = true;

        // Advances time to trigger the Keepalive timer (100ms + buffer).
        async.elapse(const Duration(milliseconds: 200));

        // Confirms the write was attempted (validating the race condition logic executed).
        verify(() => mockSink.add(any())).called(greaterThan(0));

        // Ensures the internal exception was handled silently and not reported.
        expect(errorReported, isFalse, reason: 'Race condition caused an exception to leak to onError: $reportedError');
      });
    });
  });
}
