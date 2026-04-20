import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  group('QueuedTerminationRequestJsonMapper', () {
    final request = QueuedTerminationRequest(type: QueuedTerminationRequestType.decline, callId: 'call-42', line: 7);

    test('roundtrips request map through json', () {
      final source = <String, QueuedTerminationRequest>{request.key: request};

      final encoded = QueuedTerminationRequestJsonMapper.toJson(source);
      final decoded = QueuedTerminationRequestJsonMapper.fromJson(encoded);

      expect(decoded.length, 1);
      expect(decoded[request.key]?.type, QueuedTerminationRequestType.decline);
      expect(decoded[request.key]?.callId, 'call-42');
      expect(decoded[request.key]?.line, 7);
    });

    test('fromJson returns empty map for invalid json input', () {
      expect(QueuedTerminationRequestJsonMapper.fromJson('{bad-json'), isEmpty);
    });

    test('fromMap filters invalid items and parses valid double line values', () {
      final map = <dynamic, dynamic>{
        'decline:call-42': {'type': 'decline', 'callId': 'call-42', 'line': 9.0},
        123: {'type': 'hangup', 'callId': 'call-x', 'line': 1},
        'missing-type': {'callId': 'call-y', 'line': 2},
      };

      final decoded = QueuedTerminationRequestJsonMapper.fromMap(map);

      expect(decoded.length, 1);
      expect(decoded['decline:call-42']?.type, QueuedTerminationRequestType.decline);
      expect(decoded['decline:call-42']?.line, 9);
    });
  });
}
