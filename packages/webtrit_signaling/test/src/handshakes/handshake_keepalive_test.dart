import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/handshakes/handshakes.dart';

void main() {
  final keepaliveHandshakeJson = '''
  {
    "handshake": "keepalive",
    "some property": "some value"
  }
  ''';

  final keepaliveHandshake = KeepaliveHandshake();

  test('$KeepaliveHandshake fromJson', () {
    expect(
      KeepaliveHandshake.fromJson(
          json.decode(keepaliveHandshakeJson) as Map<String, dynamic>),
      equals(keepaliveHandshake),
    );
  });
}
