import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

void main() {
  group('QueuedTerminationRequest', () {
    test('key is derived from type and callId', () {
      final request = QueuedTerminationRequest(type: QueuedTerminationRequestType.hangup, callId: 'call-100', line: 1);

      expect(request.key, 'hangup:call-100');
    });

    test('same callId with different type produces different keys', () {
      final hangup = QueuedTerminationRequest(type: QueuedTerminationRequestType.hangup, callId: 'call-100', line: 1);
      final decline = QueuedTerminationRequest(type: QueuedTerminationRequestType.decline, callId: 'call-100', line: 1);

      expect(hangup.key, isNot(decline.key));
    });
  });
}
