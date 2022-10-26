import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/call/call_error_event.dart';

import '../error_event_jsons.dart';
import '../event_jsons.dart';

void main() {
  test('$CallErrorEvent tryFromJson', () {
    final callErrorEvent = CallErrorEvent(
      transaction: 'transaction 1',
      line: 0,
      callId: "qwerty",
      code: 123,
      reason: 'some error message 1',
    );

    expect(
      CallErrorEvent.tryFromJson(json.decode(callErrorEventJson1) as Map<String, dynamic>),
      equals(callErrorEvent),
    );
  });

  test('$CallErrorEvent tryFromJson', () {
    final callErrorEvent = CallErrorEvent(
      line: 0,
      callId: "qwerty",
      code: 123,
      reason: 'some error message 1',
    );

    expect(
      CallErrorEvent.tryFromJson(json.decode(callErrorEventJson2) as Map<String, dynamic>),
      equals(callErrorEvent),
    );
  });

  test('$CallErrorEvent tryFromJson', () {
    expect(
      CallErrorEvent.tryFromJson(json.decode(lineErrorEventJson1) as Map<String, dynamic>),
      equals(null),
    );
  });

  test('$CallErrorEvent tryFromJson', () {
    expect(
      CallErrorEvent.tryFromJson(json.decode(lineErrorEventJson2) as Map<String, dynamic>),
      equals(null),
    );
  });

  test('$CallErrorEvent tryFromJson', () {
    expect(
      CallErrorEvent.tryFromJson(json.decode(sessionErrorEventJson1) as Map<String, dynamic>),
      equals(null),
    );
  });

  test('$CallErrorEvent tryFromJson', () {
    expect(
      CallErrorEvent.tryFromJson(json.decode(sessionErrorEventJson2) as Map<String, dynamic>),
      equals(null),
    );
  });

  test('$CallErrorEvent tryFromJson', () {
    expect(
      CallErrorEvent.tryFromJson(json.decode(eventJsonEmpty) as Map<String, dynamic>),
      equals(null),
    );
  });
}
