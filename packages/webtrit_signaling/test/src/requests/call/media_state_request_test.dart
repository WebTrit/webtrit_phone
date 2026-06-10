import 'package:test/test.dart';

import 'package:webtrit_signaling/src/requests/call/call_requests.dart';
import 'package:webtrit_signaling/src/requests/call_request.dart';
import 'package:webtrit_signaling/src/requests/request.dart';

void main() {
  test('MediaStateRequest: toJson', () {
    const request = MediaStateRequest(transaction: 'transaction 1', line: 0, callId: 'qwerty', media: {'video': false});

    expect(request.toJson(), {
      Request.typeKey: 'media_state',
      'transaction': 'transaction 1',
      'line': 0,
      'call_id': 'qwerty',
      'media': {'video': false},
    });
  });

  test('MediaStateRequest: fromJson round trip via CallRequest', () {
    const request = MediaStateRequest(transaction: 'transaction 1', line: 0, callId: 'qwerty', media: {'video': true});

    expect(CallRequest.fromJson(request.toJson()), equals(request));
  });
}
