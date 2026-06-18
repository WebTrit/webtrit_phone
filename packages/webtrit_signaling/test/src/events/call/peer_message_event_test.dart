import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/call/call_events.dart';
import 'package:webtrit_signaling/src/events/call_event.dart';

void main() {
  void testFromJson(String description, Map<String, dynamic> actual, PeerMessageEvent expected) {
    test(description, () {
      expect(PeerMessageEvent.fromJson(actual), equals(expected));
      expect(CallEvent.fromJson(actual), equals(expected));
    });
  }

  testFromJson(
    'MediaStatePeerMessageEvent: video off with sender',
    json.decode(r'''
    {
      "transaction": "transaction 1",
      "line": 0,
      "call_id": "qwerty",
      "event": "peer_message",
      "type": "media_state",
      "data": {"video": false},
      "sender": "555001"
    }
    ''')
        as Map<String, dynamic>,
    const MediaStatePeerMessageEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      video: false,
      sender: '555001',
    ),
  );

  testFromJson(
    'MediaStatePeerMessageEvent: video on without sender and transaction',
    json.decode(r'''
    {
      "line": 1,
      "call_id": "qwerty",
      "event": "peer_message",
      "type": "media_state",
      "data": {"video": true}
    }
    ''')
        as Map<String, dynamic>,
    const MediaStatePeerMessageEvent(line: 1, callId: 'qwerty', video: true),
  );

  testFromJson(
    'UnknownPeerMessageEvent: unrecognized type kept raw',
    json.decode(r'''
    {
      "line": 0,
      "call_id": "qwerty",
      "event": "peer_message",
      "type": "peer_mute",
      "data": {"muted": true},
      "sender": "555001"
    }
    ''')
        as Map<String, dynamic>,
    const UnknownPeerMessageEvent(
      line: 0,
      callId: 'qwerty',
      type: 'peer_mute',
      data: {'muted': true},
      sender: '555001',
    ),
  );

  testFromJson(
    'UnknownPeerMessageEvent: malformed media_state data falls back to unknown',
    json.decode(r'''
    {
      "line": 0,
      "call_id": "qwerty",
      "event": "peer_message",
      "type": "media_state",
      "data": {"video": "not-a-bool"}
    }
    ''')
        as Map<String, dynamic>,
    const UnknownPeerMessageEvent(line: 0, callId: 'qwerty', type: 'media_state', data: {'video': 'not-a-bool'}),
  );

  test('MediaStatePeerMessageEvent: toJson round trip', () {
    const event = MediaStatePeerMessageEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      video: false,
      sender: '555001',
    );

    expect(PeerMessageEvent.fromJson(event.toJson()), equals(event));
  });
}
