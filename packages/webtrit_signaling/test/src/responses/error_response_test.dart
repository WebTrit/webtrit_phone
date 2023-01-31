import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/responses/responses.dart';

void main() {
  test('$ErrorResponse fromJson 1', () {
    final errorResponseJson = '''
    {
      "response": "error",
      "code": -1,
      "reason": "some error message 1"
    }
    ''';

    final errorResponse = ErrorResponse(
      code: -1,
      reason: 'some error message 1',
    );

    expect(
      ErrorResponse.fromJson(json.decode(errorResponseJson) as Map<String, dynamic>),
      equals(errorResponse),
    );
  });

  test('$ErrorResponse fromJson 2', () {
    final errorResponseJson = '''
    {
      "response": "error",
      "line": 0,
      "code": -2,
      "reason": "some error message 2"
    }
    ''';

    final errorResponse = ErrorResponse(
      line: 0,
      code: -2,
      reason: 'some error message 2',
    );

    expect(
      ErrorResponse.fromJson(json.decode(errorResponseJson) as Map<String, dynamic>),
      equals(errorResponse),
    );
  });

  test('$ErrorResponse fromJson 3', () {
    final errorResponseJson = '''
    {
      "response": "error",
      "code": 123,
      "reason": "some error reason 3"
    }
    ''';

    final errorResponse = ErrorResponse(
      code: 123,
      reason: 'some error reason 3',
    );

    expect(
      ErrorResponse.fromJson(json.decode(errorResponseJson) as Map<String, dynamic>),
      equals(errorResponse),
    );
  });

  test('$ErrorResponse fromJson 4', () {
    final errorResponseJson = '''
    {
      "response": "error",
      "line": 1,
      "call_id": "qwerty",
      "code": 456,
      "reason": "some error reason 4"
    }
    ''';

    final errorResponse = ErrorResponse(
      line: 1,
      callId: 'qwerty',
      code: 456,
      reason: 'some error reason 4',
    );

    expect(
      ErrorResponse.fromJson(json.decode(errorResponseJson) as Map<String, dynamic>),
      equals(errorResponse),
    );
  });
}
