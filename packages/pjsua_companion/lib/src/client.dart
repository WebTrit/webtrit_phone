import 'dart:convert';
import 'dart:io';

class PjsuaCompanionClient {
  const PjsuaCompanionClient({required this.host, required this.port});

  final String host;
  final int port;

  Future<int> call(
    String callee, {
    required String sipServer,
    required String sipUsername,
    required String sipPassword,
    Duration callDuration = const Duration(seconds: 60),
  }) async {
    final body = await _get('/call', {
      'calle': callee,
      'sip_server': sipServer,
      'sip_username': sipUsername,
      'sip_password': sipPassword,
      'duration': callDuration.inSeconds.toString(),
    });
    return int.parse(body.trim());
  }

  Future<int> registerAutoanswer({
    required String sipServer,
    required String sipUsername,
    required String sipPassword,
    Duration callDuration = const Duration(seconds: 60),
  }) async {
    final body = await _get('/register_autoanswer', {
      'sip_server': sipServer,
      'sip_username': sipUsername,
      'sip_password': sipPassword,
      'duration': callDuration.inSeconds.toString(),
    });
    return int.parse(body.trim());
  }

  Future<void> close(int pid) async {
    await _get('/close', {'pid': '$pid'});
  }

  Future<void> hangup(int pid) async {
    await _get('/hangup', {'pid': '$pid'});
  }

  Future<void> hold(int pid) async {
    await _get('/hold', {'pid': '$pid'});
  }

  Future<void> unhold(int pid) async {
    await _get('/unhold', {'pid': '$pid'});
  }

  Future<String> _get(String path, Map<String, String> params) async {
    final uri = Uri.http('$host:$port', path, params);
    final client = HttpClient();
    try {
      final req = await client.getUrl(uri).timeout(const Duration(seconds: 10));
      final response = await req.close().timeout(const Duration(seconds: 10));
      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode != HttpStatus.ok) {
        throw Exception('pjsua call server responded ${response.statusCode} for $uri: $body');
      }
      return body;
    } finally {
      client.close();
    }
  }
}
