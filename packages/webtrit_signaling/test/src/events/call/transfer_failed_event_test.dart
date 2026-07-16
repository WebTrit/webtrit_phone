import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/call/transfer_failed_event.dart';

void main() {
  test('$TransferFailedEvent fromJson with code', () {
    const transferFailedEventJson = '''
    {
      "event": "transfer_failed",
      "transaction": "transaction 1",
      "line": 0,
      "call_id": "qwerty",
      "code": 400
    }
    ''';

    final event = TransferFailedEvent(transaction: 'transaction 1', line: 0, callId: 'qwerty', code: 400);

    expect(TransferFailedEvent.fromJson(json.decode(transferFailedEventJson) as Map<String, dynamic>), equals(event));
  });

  test('$TransferFailedEvent fromJson without code', () {
    const transferFailedEventJson = '''
    {
      "event": "transfer_failed",
      "line": 0,
      "call_id": "qwerty"
    }
    ''';

    final event = TransferFailedEvent(line: 0, callId: 'qwerty');

    expect(TransferFailedEvent.fromJson(json.decode(transferFailedEventJson) as Map<String, dynamic>), equals(event));
  });

  test('$TransferFailedEvent toJson round-trips', () {
    const event = TransferFailedEvent(transaction: 'transaction 1', line: 0, callId: 'qwerty', code: 400);

    expect(TransferFailedEvent.fromJson(event.toJson()), equals(event));
  });
}
