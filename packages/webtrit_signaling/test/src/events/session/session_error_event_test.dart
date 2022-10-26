import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/session/session_error_event.dart';

import '../error_event_jsons.dart';
import '../event_jsons.dart';

void main() {
  test('$SessionErrorEvent tryFromJson', () {
    expect(
      SessionErrorEvent.tryFromJson(json.decode(callErrorEventJson1) as Map<String, dynamic>),
      equals(isNotNull),
    );
  });

  test('$SessionErrorEvent tryFromJson', () {
    expect(
      SessionErrorEvent.tryFromJson(json.decode(callErrorEventJson2) as Map<String, dynamic>),
      equals(isNotNull),
    );
  });

  test('$SessionErrorEvent tryFromJson', () {
    expect(
      SessionErrorEvent.tryFromJson(json.decode(lineErrorEventJson1) as Map<String, dynamic>),
      equals(isNotNull),
    );
  });

  test('$SessionErrorEvent tryFromJson', () {
    expect(
      SessionErrorEvent.tryFromJson(json.decode(lineErrorEventJson2) as Map<String, dynamic>),
      equals(isNotNull),
    );
  });

  test('$SessionErrorEvent tryFromJson', () {
    final sessionErrorEvent = SessionErrorEvent(
      transaction: 'transaction 1',
      code: 123,
      reason: 'some error message 1',
    );

    expect(
      SessionErrorEvent.tryFromJson(json.decode(sessionErrorEventJson1) as Map<String, dynamic>),
      equals(sessionErrorEvent),
    );
  });

  test('$SessionErrorEvent tryFromJson', () {
    final sessionErrorEvent = SessionErrorEvent(
      code: 123,
      reason: 'some error message 1',
    );

    expect(
      SessionErrorEvent.tryFromJson(json.decode(sessionErrorEventJson2) as Map<String, dynamic>),
      equals(sessionErrorEvent),
    );
  });

  test('$SessionErrorEvent tryFromJson', () {
    expect(
      SessionErrorEvent.tryFromJson(json.decode(eventJsonEmpty) as Map<String, dynamic>),
      equals(null),
    );
  });
}
