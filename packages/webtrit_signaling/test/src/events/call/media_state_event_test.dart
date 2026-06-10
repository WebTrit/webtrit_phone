import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/call/call_events.dart';
import 'package:webtrit_signaling/src/events/call_event.dart';

void main() {
  void testFromJson(String description, Map<String, dynamic> actual, MediaStateEvent expected) {
    test(description, () {
      expect(MediaStateEvent.fromJson(actual), equals(expected));
      expect(CallEvent.fromJson(actual), equals(expected));
    });
  }

  testFromJson(
    'MediaStateEvent: video off with sender',
    json.decode(r'''
    {
      "transaction": "transaction 1",
      "line": 0,
      "call_id": "qwerty",
      "event": "media_state",
      "media": {"video": false},
      "sender": "555001"
    }
    ''')
        as Map<String, dynamic>,
    const MediaStateEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      media: {'video': false},
      sender: '555001',
    ),
  );

  testFromJson(
    'MediaStateEvent: video on without sender and transaction',
    json.decode(r'''
    {
      "line": 1,
      "call_id": "qwerty",
      "event": "media_state",
      "media": {"video": true}
    }
    ''')
        as Map<String, dynamic>,
    const MediaStateEvent(line: 1, callId: 'qwerty', media: {'video': true}),
  );

  test('MediaStateEvent: toJson round trip', () {
    const event = MediaStateEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      media: {'video': false},
      sender: '555001',
    );

    expect(MediaStateEvent.fromJson(event.toJson()), equals(event));
  });
}
