import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/handshakes/handshakes.dart';

void main() {
  final handshakeKeepaliveJson = '''
  {
    "handshake": "keepalive",
    "some property": "some value"
  }
  ''';

  final handshakeKeepalive = HandshakeKeepalive();

  test('$HandshakeState fromJson', () {
    expect(
      HandshakeKeepalive.fromJson(json.decode(handshakeKeepaliveJson) as Map<String, dynamic>),
      equals(handshakeKeepalive),
    );
  });
}
