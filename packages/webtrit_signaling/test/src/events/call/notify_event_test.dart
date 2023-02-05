import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/call/call_events.dart';
import 'package:webtrit_signaling/src/events/call_event.dart';

import '../event_jsons.dart';

void main() {
  void testFromJson(String description, Map<String, dynamic> actual, NotifyEvent expected) {
    test(description, () {
      expect(
        NotifyEvent.fromJson(actual),
        equals(expected),
      );
      expect(
        CallEvent.fromJson(actual),
        equals(expected),
      );
    });
  }

  testFromJson(
    '$NotifyEvent fromJson 1',
    json.decode(r'''
    {
      "transaction": "transaction 1",
      "line": 0,
      "call_id": "qwerty",
      "event": "notify",
      "notify": "refer",
      "subscription_state": "active",
      "content_type": "message/sipfrag",
      "content": "SIP/2.0 100 Trying\r\n"
    }
    ''') as Map<String, dynamic>,
    NotifyEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      notify: 'refer',
      subscriptionState: SubscriptionState.active,
      contentType: 'message/sipfrag',
      content: 'SIP/2.0 100 Trying\r\n',
    ),
  );

  testFromJson(
    '$NotifyEvent fromJson 2',
    json.decode(r'''
    {
      "line": 0,
      "call_id": "qwerty",
      "event": "notify",
      "notify": "refer",
      "subscription_state": "active",
      "content_type": "message/sipfrag",
      "content": "SIP/2.0 100 Trying\r\n"
    }
    ''') as Map<String, dynamic>,
    NotifyEvent(
      line: 0,
      callId: 'qwerty',
      notify: 'refer',
      subscriptionState: SubscriptionState.active,
      contentType: 'message/sipfrag',
      content: 'SIP/2.0 100 Trying\r\n',
    ),
  );

  test('$NotifyEvent fromJson error', () {
    expect(
      () => NotifyEvent.fromJson(json.decode(eventJsonEmpty) as Map<String, dynamic>),
      throwsA(isArgumentError),
    );
  });
}
