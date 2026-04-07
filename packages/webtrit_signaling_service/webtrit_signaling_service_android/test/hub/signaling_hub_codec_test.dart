import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service_android/src/hub/signaling_hub_codec.dart';

final _kHandshake = StateHandshake(
  keepaliveInterval: const Duration(seconds: 30),
  timestamp: 1705322000000,
  registration: const Registration(status: RegistrationStatus.registered),
  lines: const [],
  userActiveCalls: const [],
  contactsPresenceInfo: const {},
  guestLine: null,
);

T _roundtrip<T extends SignalingModuleEvent>(T event) {
  final encoded = encodeHubEvent(event);
  expect(encoded, isNotNull);
  final decoded = decodeHubEvent(encoded!);
  expect(decoded, isA<T>());
  return decoded as T;
}

void main() {
  group('SignalingHubCodec -- SignalingConnecting', () {
    test('encodes to [connecting]', () {
      expect(encodeHubEvent(SignalingConnecting()), equals(['connecting']));
    });

    test('roundtrip returns SignalingConnecting', () {
      _roundtrip(SignalingConnecting());
    });
  });

  group('SignalingHubCodec -- SignalingConnected', () {
    test('encodes to [connected]', () {
      expect(encodeHubEvent(SignalingConnected()), equals(['connected']));
    });

    test('roundtrip returns SignalingConnected', () {
      _roundtrip(SignalingConnected());
    });
  });

  group('SignalingHubCodec -- SignalingDisconnecting', () {
    test('encodes to [disconnecting]', () {
      expect(encodeHubEvent(SignalingDisconnecting()), equals(['disconnecting']));
    });

    test('roundtrip returns SignalingDisconnecting', () {
      _roundtrip(SignalingDisconnecting());
    });
  });

  group('SignalingHubCodec -- SignalingConnectionFailed', () {
    test('encodes error as string representation', () {
      final event = SignalingConnectionFailed(
        error: Exception('socket timeout'),
        isRepeated: false,
        recommendedReconnectDelay: const Duration(seconds: 3),
      );
      final encoded = encodeHubEvent(event)!;
      expect(encoded[0], 'connection_failed');
      expect(encoded[1], event.error.toString());
      expect(encoded[2], false);
      expect(encoded[3], 3000);
    });

    test('roundtrip preserves isRepeated: false', () {
      final decoded = _roundtrip(
        SignalingConnectionFailed(
          error: Exception('TLS error'),
          isRepeated: false,
          recommendedReconnectDelay: const Duration(seconds: 3),
        ),
      );
      expect(decoded.isRepeated, isFalse);
    });

    test('roundtrip preserves isRepeated: true', () {
      final decoded = _roundtrip(
        SignalingConnectionFailed(
          error: Exception('TLS error'),
          isRepeated: true,
          recommendedReconnectDelay: const Duration(seconds: 3),
        ),
      );
      expect(decoded.isRepeated, isTrue);
    });

    test('roundtrip preserves recommendedReconnectDelay', () {
      const delay = Duration(seconds: 5);
      final decoded = _roundtrip(
        SignalingConnectionFailed(error: Exception('err'), isRepeated: false, recommendedReconnectDelay: delay),
      );
      expect(decoded.recommendedReconnectDelay, delay);
    });

    test('decoded error is a String (original type information is lost)', () {
      final decoded = _roundtrip(
        SignalingConnectionFailed(
          error: Exception('some error'),
          isRepeated: false,
          recommendedReconnectDelay: const Duration(seconds: 3),
        ),
      );
      expect(decoded.error, isA<String>());
    });
  });

  group('SignalingHubCodec -- SignalingDisconnected', () {
    test('encodes knownCode as enum name, not index', () {
      final encoded = encodeHubEvent(
        SignalingDisconnected(
          code: 1000,
          reason: null,
          knownCode: SignalingDisconnectCode.normalClosure,
          recommendedReconnectDelay: const Duration(seconds: 3),
        ),
      )!;
      expect(encoded[3], 'normalClosure');
    });

    test('roundtrip preserves code and reason', () {
      final decoded = _roundtrip(
        SignalingDisconnected(
          code: 1000,
          reason: 'normal close',
          knownCode: SignalingDisconnectCode.normalClosure,
          recommendedReconnectDelay: const Duration(seconds: 3),
        ),
      );
      expect(decoded.code, 1000);
      expect(decoded.reason, 'normal close');
    });

    test('roundtrip preserves all SignalingDisconnectCode values', () {
      for (final knownCode in SignalingDisconnectCode.values) {
        final decoded = _roundtrip(
          SignalingDisconnected(
            code: 1000,
            reason: null,
            knownCode: knownCode,
            recommendedReconnectDelay: const Duration(seconds: 3),
          ),
        );
        expect(decoded.knownCode, knownCode);
      }
    });

    test('roundtrip preserves non-null recommendedReconnectDelay', () {
      const delay = Duration(seconds: 3);
      final decoded = _roundtrip(
        SignalingDisconnected(
          code: 1000,
          reason: null,
          knownCode: SignalingDisconnectCode.normalClosure,
          recommendedReconnectDelay: delay,
        ),
      );
      expect(decoded.recommendedReconnectDelay, delay);
    });

    test('roundtrip preserves null recommendedReconnectDelay', () {
      final decoded = _roundtrip(
        SignalingDisconnected(
          code: 1002,
          reason: null,
          knownCode: SignalingDisconnectCode.protocolError,
          recommendedReconnectDelay: null,
        ),
      );
      expect(decoded.recommendedReconnectDelay, isNull);
    });

    test('roundtrip preserves null code and null reason', () {
      final decoded = _roundtrip(
        SignalingDisconnected(
          code: null,
          reason: null,
          knownCode: SignalingDisconnectCode.unmappedCode,
          recommendedReconnectDelay: const Duration(seconds: 3),
        ),
      );
      expect(decoded.code, isNull);
      expect(decoded.reason, isNull);
    });

    test('Duration.zero roundtrip (code 4441)', () {
      final decoded = _roundtrip(
        SignalingDisconnected(
          code: SignalingDisconnectCode.controllerForceAttachClose.code,
          reason: null,
          knownCode: SignalingDisconnectCode.controllerForceAttachClose,
          recommendedReconnectDelay: Duration.zero,
        ),
      );
      expect(decoded.recommendedReconnectDelay, Duration.zero);
    });
  });

  group('SignalingHubCodec -- SignalingHandshakeReceived', () {
    test('roundtrip produces SignalingHandshakeReceived', () {
      final event = SignalingHandshakeReceived(handshake: _kHandshake);
      final encoded = encodeHubEvent(event);
      expect(encoded, isNotNull);
      final decoded = decodeHubEvent(encoded!);
      expect(decoded, isA<SignalingHandshakeReceived>());
    });

    test('roundtrip preserves keepaliveInterval', () {
      final event = SignalingHandshakeReceived(handshake: _kHandshake);
      final encoded = encodeHubEvent(event)!;
      final decoded = decodeHubEvent(encoded) as SignalingHandshakeReceived;
      expect(decoded.handshake.keepaliveInterval, _kHandshake.keepaliveInterval);
    });

    test('roundtrip preserves timestamp', () {
      final event = SignalingHandshakeReceived(handshake: _kHandshake);
      final encoded = encodeHubEvent(event)!;
      final decoded = decodeHubEvent(encoded) as SignalingHandshakeReceived;
      expect(decoded.handshake.timestamp, _kHandshake.timestamp);
    });

    test('roundtrip preserves registration status', () {
      final event = SignalingHandshakeReceived(handshake: _kHandshake);
      final encoded = encodeHubEvent(event)!;
      final decoded = decodeHubEvent(encoded) as SignalingHandshakeReceived;
      expect(decoded.handshake.registration.status, RegistrationStatus.registered);
    });

    test('malformed handshake payload returns null', () {
      final msg = [
        'handshake_received',
        <String, dynamic>{'bad': 'data'},
      ];
      final decoded = decodeHubEvent(msg);
      expect(decoded, isNull);
    });
  });

  group('SignalingHubCodec -- sub-ack', () {
    test('encodeSubAck returns [sub_ack]', () {
      expect(encodeSubAck(), equals(['sub_ack']));
    });

    test('isSubAck is true for [sub_ack]', () {
      expect(isSubAck(['sub_ack']), isTrue);
    });

    test('isSubAck is false for other tags', () {
      expect(isSubAck(['connecting']), isFalse);
      expect(isSubAck(['execute_result', 'id', null]), isFalse);
    });

    test('isSubAck is false for empty list', () {
      expect(isSubAck([]), isFalse);
    });
  });

  group('SignalingHubCodec -- execute result', () {
    test('encodeExecuteResult without error produces [execute_result, corrId, null]', () {
      final encoded = encodeExecuteResult('corr-1', null);
      expect(encoded[0], 'execute_result');
      expect(encoded[1], 'corr-1');
      expect(encoded[2], isNull);
    });

    test('encodeExecuteResult with error stringifies the error', () {
      final encoded = encodeExecuteResult('corr-2', Exception('boom'));
      expect(encoded[0], 'execute_result');
      expect(encoded[1], 'corr-2');
      expect(encoded[2], isA<String>());
      expect(encoded[2] as String, contains('boom'));
    });

    test('isExecuteResult is true for [execute_result, ...]', () {
      expect(isExecuteResult(['execute_result', 'id', null]), isTrue);
    });

    test('isExecuteResult is false for other tags', () {
      expect(isExecuteResult(['connecting']), isFalse);
      expect(isExecuteResult(['sub_ack']), isFalse);
    });

    test('isExecuteResult is false for empty list', () {
      expect(isExecuteResult([]), isFalse);
    });

    test('decodeExecuteResult extracts correlationId and null error', () {
      final encoded = encodeExecuteResult('abc123', null);
      final result = decodeExecuteResult(encoded);
      expect(result.correlationId, 'abc123');
      expect(result.error, isNull);
    });

    test('decodeExecuteResult extracts correlationId and error string', () {
      final errorMsg = Exception('request failed').toString();
      final encoded = encodeExecuteResult('xyz', Exception('request failed'));
      final result = decodeExecuteResult(encoded);
      expect(result.correlationId, 'xyz');
      expect(result.error, errorMsg);
    });
  });

  group('SignalingHubCodec -- edge cases', () {
    test('decodeHubEvent returns null for empty list', () {
      expect(decodeHubEvent([]), isNull);
    });

    test('decodeHubEvent returns null for unknown tag', () {
      expect(decodeHubEvent(['unknown_tag', 'data']), isNull);
    });

    test('encodeHubEvent -> decodeHubEvent is stable for all stateless events', () {
      final stateless = [SignalingConnecting(), SignalingConnected(), SignalingDisconnecting()];
      for (final event in stateless) {
        final encoded = encodeHubEvent(event);
        expect(encoded, isNotNull);
        expect(decodeHubEvent(encoded!), isNotNull);
      }
    });
  });
}
