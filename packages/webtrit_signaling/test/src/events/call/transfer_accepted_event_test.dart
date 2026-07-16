import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/call/transfer_accepted_event.dart';

void main() {
  test('$TransferAcceptedEvent fromJson with code', () {
    const transferAcceptedEventJson = '''
    {
      "event": "transfer_accepted",
      "transaction": "transaction 1",
      "line": 0,
      "call_id": "qwerty",
      "code": 202
    }
    ''';

    final event = TransferAcceptedEvent(transaction: 'transaction 1', line: 0, callId: 'qwerty', code: 202);

    expect(
      TransferAcceptedEvent.fromJson(json.decode(transferAcceptedEventJson) as Map<String, dynamic>),
      equals(event),
    );
  });

  test('$TransferAcceptedEvent fromJson without code', () {
    const transferAcceptedEventJson = '''
    {
      "event": "transfer_accepted",
      "line": 0,
      "call_id": "qwerty"
    }
    ''';

    final event = TransferAcceptedEvent(line: 0, callId: 'qwerty');

    expect(
      TransferAcceptedEvent.fromJson(json.decode(transferAcceptedEventJson) as Map<String, dynamic>),
      equals(event),
    );
  });

  test('$TransferAcceptedEvent toJson round-trips', () {
    const event = TransferAcceptedEvent(transaction: 'transaction 1', line: 0, callId: 'qwerty', code: 202);

    expect(TransferAcceptedEvent.fromJson(event.toJson()), equals(event));
  });
}
