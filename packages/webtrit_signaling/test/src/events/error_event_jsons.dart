const callErrorEventJson1 = '''
{
  "event": "error",
  "transaction": "transaction 1",
  "line": 0,
  "call_id": "qwerty",
  "code": 123,
  "reason": "some error message 1"
}
''';
const callErrorEventJson2 = '''
{
  "event": "error",
  "line": 0,
  "call_id": "qwerty",
  "code": 123,
  "reason": "some error message 1"
}
''';

const lineErrorEventJson1 = '''
{
  "event": "error",
  "transaction": "transaction 1",
  "line": 0,
  "code": 123,
  "reason": "some error message 1"
}
''';
const lineErrorEventJson2 = '''
{
  "event": "error",
  "line": 0,
  "code": 123,
  "reason": "some error message 1"
}
''';

const sessionErrorEventJson1 = '''
{
  "event": "error",
  "transaction": "transaction 1",
  "code": 123,
  "reason": "some error message 1"
}
''';
const sessionErrorEventJson2 = '''
{
  "event": "error",
  "code": 123,
  "reason": "some error message 1"
}
''';
