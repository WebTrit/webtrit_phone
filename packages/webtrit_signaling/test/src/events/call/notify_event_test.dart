import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/call/call_events.dart';
import 'package:webtrit_signaling/src/events/call_event.dart';

import '../event_jsons.dart';

void main() {
  test('$NotifyEvent fromJson', () {
    final notifyEventJson = json.decode(r'''
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
    ''') as Map<String, dynamic>;

    final notifyEvent = NotifyEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      notify: 'refer',
      subscriptionState: SubscriptionState.active,
      contentType: 'message/sipfrag',
      content: 'SIP/2.0 100 Trying\r\n',
    );

    expect(
      NotifyEvent.fromJson(notifyEventJson),
      equals(notifyEvent),
    );
    expect(
      CallEvent.fromJson(notifyEventJson),
      equals(notifyEvent),
    );
  });

  test('$NotifyEvent fromJson error', () {
    expect(
      () => NotifyEvent.fromJson(json.decode(eventJsonEmpty) as Map<String, dynamic>),
      throwsA(isArgumentError),
    );
  });
}
