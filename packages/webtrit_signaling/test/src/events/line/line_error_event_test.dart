import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/line/line_error_event.dart';

import '../error_event_jsons.dart';
import '../event_jsons.dart';

void main() {
  test('$LineErrorEvent tryFromJson', () {
    expect(
      LineErrorEvent.tryFromJson(
          json.decode(callErrorEventJson1) as Map<String, dynamic>),
      equals(isNotNull),
    );
  });

  test('$LineErrorEvent tryFromJson', () {
    expect(
      LineErrorEvent.tryFromJson(
          json.decode(callErrorEventJson2) as Map<String, dynamic>),
      equals(isNotNull),
    );
  });

  test('$LineErrorEvent tryFromJson', () {
    final lineErrorEvent = LineErrorEvent(
      transaction: 'transaction 1',
      line: 0,
      code: 123,
      reason: 'some error message 1',
    );

    expect(
      LineErrorEvent.tryFromJson(
          json.decode(lineErrorEventJson1) as Map<String, dynamic>),
      equals(lineErrorEvent),
    );
  });

  test('$LineErrorEvent tryFromJson', () {
    final lineErrorEvent = LineErrorEvent(
      line: 0,
      code: 123,
      reason: 'some error message 1',
    );

    expect(
      LineErrorEvent.tryFromJson(
          json.decode(lineErrorEventJson2) as Map<String, dynamic>),
      equals(lineErrorEvent),
    );
  });

  test('$LineErrorEvent tryFromJson', () {
    expect(
      LineErrorEvent.tryFromJson(
          json.decode(sessionErrorEventJson1) as Map<String, dynamic>),
      equals(null),
    );
  });

  test('$LineErrorEvent tryFromJson', () {
    expect(
      LineErrorEvent.tryFromJson(
          json.decode(sessionErrorEventJson2) as Map<String, dynamic>),
      equals(null),
    );
  });

  test('$LineErrorEvent tryFromJson', () {
    expect(
      LineErrorEvent.tryFromJson(
          json.decode(eventJsonEmpty) as Map<String, dynamic>),
      equals(null),
    );
  });
}
