import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/call/call_events.dart';
import 'package:webtrit_signaling/src/events/call_event.dart';

import '../event_jsons.dart';

void main() {
  void testFromJson(String description, Map<String, dynamic> actual, NotifyEvent expected) {
    test(description, () {
      expect(NotifyEvent.fromJson(actual), equals(expected));
      expect(CallEvent.fromJson(actual), equals(expected));
    });
  }

  // --- ReferProvisional (1xx) ---

  testFromJson(
    'ReferNotifyEvent: 100 Trying → ReferProvisional',
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
    ''')
        as Map<String, dynamic>,
    ReferNotifyEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      subscriptionState: SubscriptionState.active,
      state: const ReferProvisional(sipCode: 100, reason: 'Trying'),
    ),
  );

  testFromJson(
    'ReferNotifyEvent: 100 Trying without transaction → ReferProvisional',
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
    ''')
        as Map<String, dynamic>,
    ReferNotifyEvent(
      line: 0,
      callId: 'qwerty',
      subscriptionState: SubscriptionState.active,
      state: const ReferProvisional(sipCode: 100, reason: 'Trying'),
    ),
  );

  // --- ReferAccepted (2xx) ---

  testFromJson(
    'ReferNotifyEvent: 200 OK → ReferAccepted',
    json.decode(r'''
    {
      "transaction": "transaction 1",
      "line": 0,
      "call_id": "qwerty",
      "event": "notify",
      "notify": "refer",
      "subscription_state": "terminated",
      "content_type": "message/sipfrag",
      "content": "SIP/2.0 200 OK"
    }
    ''')
        as Map<String, dynamic>,
    ReferNotifyEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      subscriptionState: SubscriptionState.terminated,
      state: const ReferAccepted(),
    ),
  );

  // --- ReferFailed (non-2xx) ---

  testFromJson(
    'ReferNotifyEvent: 603 Decline → ReferFailed',
    json.decode(r'''
    {
      "transaction": "transaction 1",
      "line": 0,
      "call_id": "qwerty",
      "event": "notify",
      "notify": "refer",
      "subscription_state": "terminated",
      "content_type": "message/sipfrag",
      "content": "SIP/2.0 603 Decline"
    }
    ''')
        as Map<String, dynamic>,
    ReferNotifyEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      subscriptionState: SubscriptionState.terminated,
      state: const ReferFailed(sipCode: 603, reason: 'Decline'),
    ),
  );

  testFromJson(
    'ReferNotifyEvent: 486 Busy Here → ReferFailed',
    json.decode(r'''
    {
      "transaction": "transaction 1",
      "line": 0,
      "call_id": "qwerty",
      "event": "notify",
      "notify": "refer",
      "subscription_state": "terminated",
      "content_type": "message/sipfrag",
      "content": "SIP/2.0 486 Busy Here"
    }
    ''')
        as Map<String, dynamic>,
    ReferNotifyEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      subscriptionState: SubscriptionState.terminated,
      state: const ReferFailed(sipCode: 486, reason: 'Busy Here'),
    ),
  );

  testFromJson(
    'ReferNotifyEvent: 480 Temporarily Unavailable → ReferFailed',
    json.decode(r'''
    {
      "transaction": "transaction 1",
      "line": 0,
      "call_id": "qwerty",
      "event": "notify",
      "notify": "refer",
      "subscription_state": "terminated",
      "content_type": "message/sipfrag",
      "content": "SIP/2.0 480 Temporarily Unavailable"
    }
    ''')
        as Map<String, dynamic>,
    ReferNotifyEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      subscriptionState: SubscriptionState.terminated,
      state: const ReferFailed(sipCode: 480, reason: 'Temporarily Unavailable'),
    ),
  );

  testFromJson(
    'ReferNotifyEvent: empty content → ReferFailed (malformed)',
    json.decode(r'''
    {
      "transaction": "transaction 1",
      "line": 0,
      "call_id": "qwerty",
      "event": "notify",
      "notify": "refer",
      "subscription_state": "terminated",
      "content_type": "message/sipfrag",
      "content": ""
    }
    ''')
        as Map<String, dynamic>,
    ReferNotifyEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: 'qwerty',
      subscriptionState: SubscriptionState.terminated,
      state: const ReferFailed(sipCode: null, reason: null),
    ),
  );

  test('NotifyEvent fromJson error on empty event', () {
    expect(() => NotifyEvent.fromJson(json.decode(eventJsonEmpty) as Map<String, dynamic>), throwsA(isArgumentError));
  });
}
