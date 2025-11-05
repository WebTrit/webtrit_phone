import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/responses/responses.dart';

void main() {
  test('$AckResponse fromJson 1', () {
    final ackResponseJson = '''
    {
      "response": "ack"
    }
    ''';

    final ackResponse = AckResponse();

    expect(
      AckResponse.fromJson(
          json.decode(ackResponseJson) as Map<String, dynamic>),
      equals(ackResponse),
    );
  });

  test('$AckResponse fromJson 2', () {
    final ackResponseJson = '''
    {
      "response": "ack",
      "line": 0
    }
    ''';

    final ackResponse = AckResponse(
      line: 0,
    );

    expect(
      AckResponse.fromJson(
          json.decode(ackResponseJson) as Map<String, dynamic>),
      equals(ackResponse),
    );
  });

  test('$AckResponse fromJson 3', () {
    final ackResponseJson = '''
    {
      "response": "ack",
      "line": 1,
      "call_id": "qwerty"
    }
    ''';

    final ackResponse = AckResponse(
      line: 1,
      callId: 'qwerty',
    );

    expect(
      AckResponse.fromJson(
          json.decode(ackResponseJson) as Map<String, dynamic>),
      equals(ackResponse),
    );
  });
}
