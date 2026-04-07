import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

// ---------------------------------------------------------------------------
// Fixture
// ---------------------------------------------------------------------------

final _kHandshake = StateHandshake(
  keepaliveInterval: const Duration(seconds: 30),
  timestamp: 1705322000000,
  registration: const Registration(status: RegistrationStatus.registered),
  lines: const [],
  userActiveCalls: const [],
  contactsPresenceInfo: const {},
  guestLine: null,
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // Stateless event construction
  // -------------------------------------------------------------------------

  group('SignalingConnecting', () {
    test('can be instantiated', () {
      expect(SignalingConnecting(), isA<SignalingModuleEvent>());
    });

    test('two instances are distinct objects', () {
      final a = SignalingConnecting();
      final b = SignalingConnecting();
      expect(identical(a, b), isFalse);
    });
  });

  group('SignalingConnected', () {
    test('can be instantiated', () {
      expect(SignalingConnected(), isA<SignalingModuleEvent>());
    });
  });

  group('SignalingDisconnecting', () {
    test('can be instantiated', () {
      expect(SignalingDisconnecting(), isA<SignalingModuleEvent>());
    });
  });

  // -------------------------------------------------------------------------
  // SignalingConnectionFailed
  // -------------------------------------------------------------------------

  group('SignalingConnectionFailed', () {
    test('stores error field', () {
      final error = Exception('TLS error');
      final event = SignalingConnectionFailed(
        error: error,
        isRepeated: false,
        recommendedReconnectDelay: const Duration(seconds: 3),
      );
      expect(event.error, same(error));
    });

    test('stores isRepeated: false', () {
      final event = SignalingConnectionFailed(
        error: Exception('err'),
        isRepeated: false,
        recommendedReconnectDelay: const Duration(seconds: 3),
      );
      expect(event.isRepeated, isFalse);
    });

    test('stores isRepeated: true', () {
      final event = SignalingConnectionFailed(
        error: Exception('err'),
        isRepeated: true,
        recommendedReconnectDelay: const Duration(seconds: 3),
      );
      expect(event.isRepeated, isTrue);
    });

    test('stores recommendedReconnectDelay', () {
      const delay = Duration(seconds: 5);
      final event = SignalingConnectionFailed(
        error: Exception('err'),
        isRepeated: false,
        recommendedReconnectDelay: delay,
      );
      expect(event.recommendedReconnectDelay, delay);
    });

    test('is a SignalingModuleEvent', () {
      expect(
        SignalingConnectionFailed(error: 'err', isRepeated: false, recommendedReconnectDelay: Duration.zero),
        isA<SignalingModuleEvent>(),
      );
    });
  });

  // -------------------------------------------------------------------------
  // SignalingDisconnected
  // -------------------------------------------------------------------------

  group('SignalingDisconnected', () {
    test('stores all fields with non-null values', () {
      const delay = Duration(seconds: 3);
      final event = SignalingDisconnected(
        code: 1000,
        reason: 'normal',
        knownCode: SignalingDisconnectCode.normalClosure,
        recommendedReconnectDelay: delay,
      );
      expect(event.code, 1000);
      expect(event.reason, 'normal');
      expect(event.knownCode, SignalingDisconnectCode.normalClosure);
      expect(event.recommendedReconnectDelay, delay);
    });

    test('allows null code and reason', () {
      final event = SignalingDisconnected(
        code: null,
        reason: null,
        knownCode: SignalingDisconnectCode.unmappedCode,
        recommendedReconnectDelay: const Duration(seconds: 3),
      );
      expect(event.code, isNull);
      expect(event.reason, isNull);
    });

    test('allows null recommendedReconnectDelay', () {
      final event = SignalingDisconnected(
        code: 1002,
        reason: null,
        knownCode: SignalingDisconnectCode.protocolError,
        recommendedReconnectDelay: null,
      );
      expect(event.recommendedReconnectDelay, isNull);
    });

    test('is a SignalingModuleEvent', () {
      expect(
        SignalingDisconnected(
          code: 1000,
          reason: null,
          knownCode: SignalingDisconnectCode.normalClosure,
          recommendedReconnectDelay: null,
        ),
        isA<SignalingModuleEvent>(),
      );
    });
  });

  // -------------------------------------------------------------------------
  // SignalingHandshakeReceived
  // -------------------------------------------------------------------------

  group('SignalingHandshakeReceived', () {
    test('stores handshake field', () {
      final event = SignalingHandshakeReceived(handshake: _kHandshake);
      expect(event.handshake, same(_kHandshake));
    });

    test('is a SignalingModuleEvent', () {
      expect(SignalingHandshakeReceived(handshake: _kHandshake), isA<SignalingModuleEvent>());
    });
  });

  // -------------------------------------------------------------------------
  // SignalingProtocolEvent
  // -------------------------------------------------------------------------

  group('SignalingProtocolEvent', () {
    test('stores event field', () {
      final inner = UnregisteredEvent();
      final event = SignalingProtocolEvent(event: inner);
      expect(event.event, same(inner));
    });

    test('is a SignalingModuleEvent', () {
      expect(SignalingProtocolEvent(event: RegisteredEvent()), isA<SignalingModuleEvent>());
    });
  });

  // -------------------------------------------------------------------------
  // Sealed class exhaustiveness
  // -------------------------------------------------------------------------

  group('SignalingModuleEvent sealed class', () {
    test('all known subtypes are SignalingModuleEvent', () {
      final List<SignalingModuleEvent> events = [
        SignalingConnecting(),
        SignalingConnected(),
        SignalingDisconnecting(),
        SignalingConnectionFailed(error: 'err', isRepeated: false, recommendedReconnectDelay: Duration.zero),
        SignalingDisconnected(
          code: 1000,
          reason: null,
          knownCode: SignalingDisconnectCode.normalClosure,
          recommendedReconnectDelay: null,
        ),
        SignalingHandshakeReceived(handshake: _kHandshake),
        SignalingProtocolEvent(event: RegisteredEvent()),
      ];

      for (final e in events) {
        expect(e, isA<SignalingModuleEvent>(), reason: '${e.runtimeType} must be SignalingModuleEvent');
      }
    });

    test('sealed switch matches all subtypes without default', () {
      SignalingModuleEvent makeEvent(int index) {
        return switch (index) {
          0 => SignalingConnecting(),
          1 => SignalingConnected(),
          2 => SignalingDisconnecting(),
          3 => SignalingConnectionFailed(error: 'e', isRepeated: false, recommendedReconnectDelay: Duration.zero),
          4 => SignalingDisconnected(
            code: 1000,
            reason: null,
            knownCode: SignalingDisconnectCode.normalClosure,
            recommendedReconnectDelay: null,
          ),
          5 => SignalingHandshakeReceived(handshake: _kHandshake),
          _ => SignalingProtocolEvent(event: RegisteredEvent()),
        };
      }

      for (var i = 0; i < 7; i++) {
        final e = makeEvent(i);
        // If the sealed exhaustive switch compiles and runs, all subtypes are handled.
        final matched = switch (e) {
          SignalingConnecting() => 'connecting',
          SignalingConnected() => 'connected',
          SignalingConnectionFailed() => 'failed',
          SignalingDisconnecting() => 'disconnecting',
          SignalingDisconnected() => 'disconnected',
          SignalingHandshakeReceived() => 'handshake',
          SignalingProtocolEvent() => 'protocol',
        };
        expect(matched, isNotEmpty);
      }
    });
  });
}
