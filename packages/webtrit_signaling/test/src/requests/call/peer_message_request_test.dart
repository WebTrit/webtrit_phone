import 'package:test/test.dart';

import 'package:webtrit_signaling/src/requests/call/call_requests.dart';
import 'package:webtrit_signaling/src/requests/call_request.dart';
import 'package:webtrit_signaling/src/requests/request.dart';

void main() {
  test('MediaStatePeerMessageRequest: toJson', () {
    const request = MediaStatePeerMessageRequest(transaction: 'transaction 1', line: 0, callId: 'qwerty', video: false);

    expect(request.toJson(), {
      Request.typeKey: 'peer_message',
      'transaction': 'transaction 1',
      'line': 0,
      'call_id': 'qwerty',
      'type': 'media_state',
      'data': {'video': false},
    });
  });

  test('MediaStatePeerMessageRequest: fromJson round trip via CallRequest', () {
    const request = MediaStatePeerMessageRequest(transaction: 'transaction 1', line: 0, callId: 'qwerty', video: true);

    expect(CallRequest.fromJson(request.toJson()), equals(request));
  });

  test('PeerMessageRequest: unknown type throws', () {
    expect(
      () => PeerMessageRequest.fromJson({
        Request.typeKey: 'peer_message',
        'transaction': 'transaction 1',
        'line': 0,
        'call_id': 'qwerty',
        'type': 'something_new',
        'data': {'foo': 'bar'},
      }),
      throwsArgumentError,
    );
  });
}
