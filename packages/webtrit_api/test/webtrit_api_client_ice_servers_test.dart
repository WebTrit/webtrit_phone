import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

import 'package:webtrit_api/webtrit_api.dart';

void main() {
  const authority = 'demo.webtrit.com';
  const token = 'token_1';

  // Verbatim payload shape served by a deployment with bundled coturn.
  const responseBody = '''
{
  "ttl": 43200,
  "ice_servers": [
    {"urls": ["stun:turn.example.com:3478"]},
    {"username": "1788215689:8", "urls": ["turn:turn.example.com:3478?transport=udp"], "credential": "secret"},
    {"username": "1788215689:8", "urls": ["turns:turn.example.com:443?transport=tcp"], "credential": "secret"}
  ],
  "expires_at": "2026-08-31T22:34:49.607820Z"
}
''';

  WebtritApiClient clientAnswering(int statusCode, {String body = '', void Function(Request)? onRequest}) {
    Future<Response> handler(Request request) async {
      onRequest?.call(request);
      return Response(body, statusCode, request: request, headers: const {'content-type': 'application/json'});
    }

    return WebtritApiClient.inner(Uri.https(authority), '', httpClient: MockClient(handler));
  }

  group('getUserIceServers', () {
    test('requests the user ice-servers endpoint with the bearer token', () async {
      Request? captured;
      final apiClient = clientAnswering(200, body: responseBody, onRequest: (request) => captured = request);

      await apiClient.getUserIceServers(token);

      expect(captured!.method.toUpperCase(), 'GET');
      expect(captured!.url.path, '/api/v1/user/ice-servers');
      expect(captured!.headers['Authorization'], 'Bearer $token');
    });

    test('parses ttl, expiration and the server entries', () async {
      final apiClient = clientAnswering(200, body: responseBody);

      final response = await apiClient.getUserIceServers(token);

      expect(response.ttl, 43200);
      expect(response.expiresAt, DateTime.utc(2026, 8, 31, 22, 34, 49, 607, 820));
      expect(response.iceServers, hasLength(3));

      final stun = response.iceServers.first;
      expect(stun.urls, ['stun:turn.example.com:3478']);
      expect(stun.username, isNull);
      expect(stun.credential, isNull);

      final turn = response.iceServers[1];
      expect(turn.urls, ['turn:turn.example.com:3478?transport=udp']);
      expect(turn.username, '1788215689:8');
      expect(turn.credential, 'secret');
    });

    test('tolerates a payload without ttl and expiration', () async {
      final apiClient = clientAnswering(200, body: '{"ice_servers": [{"urls": ["stun:host:3478"]}]}');

      final response = await apiClient.getUserIceServers(token);

      expect(response.ttl, isNull);
      expect(response.expiresAt, isNull);
      expect(response.iceServers.single.urls, ['stun:host:3478']);
    });

    test('throws EndpointNotSupportedException when the core has no such endpoint', () {
      expect(clientAnswering(501).getUserIceServers(token), throwsA(isA<EndpointNotSupportedException>()));
      expect(clientAnswering(404).getUserIceServers(token), throwsA(isA<EndpointNotSupportedException>()));
    });
  });
}
