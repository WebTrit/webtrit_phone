import 'dart:io';

const _defaultServerHost = '10.0.2.2'; // Android emulator → host localhost
const _defaultServerPort = 7788;

class PjsuaCallServerClient {
  const PjsuaCallServerClient({required this.host, required this.port});

  final String host;
  final int port;

  // TODO: return ref
  Future<void> call(String callee, {Duration callDuration = const Duration(seconds: 60)}) async {
    final uri = Uri.http('$host:$port', '/call', {'to': callee, 'duration': callDuration.inSeconds.toString()});

    final client = HttpClient();
    try {
      final req = await client.getUrl(uri).timeout(const Duration(seconds: 10));
      final response = await req.close().timeout(const Duration(seconds: 10));
      if (response.statusCode != HttpStatus.ok) {
        throw Exception('pjsua call server responded ${response.statusCode} for $uri');
      }
    } finally {
      client.close();
    }
  }

  Future<void> hangup({required String ref}) async {
    const host = String.fromEnvironment('WEBTRIT_APP_TEST_PJSUA_SERVER_HOST', defaultValue: _defaultServerHost);
    final port = int.fromEnvironment(
      // ignore: avoid_redundant_argument_values
      'WEBTRIT_APP_TEST_PJSUA_SERVER_PORT',
      defaultValue: _defaultServerPort,
    );

    final uri = Uri.http('$host:$port', '/hangup', {'ref': ref});

    final client = HttpClient();
    try {
      final req = await client.getUrl(uri).timeout(const Duration(seconds: 10));
      final response = await req.close().timeout(const Duration(seconds: 10));
      if (response.statusCode != HttpStatus.ok) {
        throw Exception('pjsua call server responded ${response.statusCode} for $uri');
      }
    } finally {
      client.close();
    }
  }

  Future<void> mute({required String ref}) async {
    const host = String.fromEnvironment('WEBTRIT_APP_TEST_PJSUA_SERVER_HOST', defaultValue: _defaultServerHost);
    final port = int.fromEnvironment(
      // ignore: avoid_redundant_argument_values
      'WEBTRIT_APP_TEST_PJSUA_SERVER_PORT',
      defaultValue: _defaultServerPort,
    );

    final uri = Uri.http('$host:$port', '/mute', {'ref': ref});

    final client = HttpClient();
    try {
      final req = await client.getUrl(uri).timeout(const Duration(seconds: 10));
      final response = await req.close().timeout(const Duration(seconds: 10));
      if (response.statusCode != HttpStatus.ok) {
        throw Exception('pjsua call server responded ${response.statusCode} for $uri');
      }
    } finally {
      client.close();
    }
  }

  Future<void> unmute({required String ref}) async {
    const host = String.fromEnvironment('WEBTRIT_APP_TEST_PJSUA_SERVER_HOST', defaultValue: _defaultServerHost);
    final port = int.fromEnvironment(
      // ignore: avoid_redundant_argument_values
      'WEBTRIT_APP_TEST_PJSUA_SERVER_PORT',
      defaultValue: _defaultServerPort,
    );

    final uri = Uri.http('$host:$port', '/unmute', {'ref': ref});

    final client = HttpClient();
    try {
      final req = await client.getUrl(uri).timeout(const Duration(seconds: 10));
      final response = await req.close().timeout(const Duration(seconds: 10));
      if (response.statusCode != HttpStatus.ok) {
        throw Exception('pjsua call server responded ${response.statusCode} for $uri');
      }
    } finally {
      client.close();
    }
  }
}
