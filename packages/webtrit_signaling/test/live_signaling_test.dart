@Tags(['live'])
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

// ---------------------------------------------------------------------------
// Credentials — read from environment variables.
// Match the keys in dart_define.integration_test.json so the same CI config
// works for both app-level and signaling live tests.
//
// Run example:
//   WEBTRIT_APP_TEST_CUSTOM_CORE_URL=core.demo.turbocompany.com \
//   WEBTRIT_APP_TEST_EMAIL_CREDENTIAL=test@turbomail.com \
//   WEBTRIT_APP_TEST_EMAIL_VERIFY_CREDENTIAL=turbopassword \
//   dart test test/live_signaling_test.dart --tags live
// ---------------------------------------------------------------------------

String _env(String key, {String defaultValue = ''}) => Platform.environment[key] ?? defaultValue;

const _coreUrlKey = 'WEBTRIT_APP_TEST_CUSTOM_CORE_URL';
const _loginKey = 'WEBTRIT_APP_TEST_EMAIL_CREDENTIAL';
const _passwordKey = 'WEBTRIT_APP_TEST_EMAIL_VERIFY_CREDENTIAL';

bool get _credentialsProvided {
  return _env(_coreUrlKey).isNotEmpty && _env(_loginKey).isNotEmpty && _env(_passwordKey).isNotEmpty;
}

// ---------------------------------------------------------------------------
// Helper: obtain a session token via REST API POST /api/v1/session.
// Uses dart:io HttpClient directly so this package stays dep-free.
// ---------------------------------------------------------------------------

Future<({String token, String tenantId})> _fetchSessionToken() async {
  final coreUrl = _env(_coreUrlKey);
  final login = _env(_loginKey);
  final password = _env(_passwordKey);

  final uri = Uri.parse('https://$coreUrl/api/v1/session');
  // ignore: avoid_types_on_closure_parameters
  final client = HttpClient()
    ..connectionTimeout = const Duration(seconds: 15)
    ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

  try {
    final request = await client.postUrl(uri);
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.write(
      jsonEncode({'type': 'macos', 'identifier': 'com.webtrit.phone.test', 'login': login, 'password': password}),
    );

    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();

    if (response.statusCode != 200) {
      throw StateError('Session creation failed: HTTP ${response.statusCode} — $body');
    }

    final json = jsonDecode(body) as Map<String, dynamic>;
    final token = json['token'] as String;
    final tenantId = json['tenant_id'] as String? ?? '';

    return (token: token, tenantId: tenantId);
  } finally {
    client.close();
  }
}

// ---------------------------------------------------------------------------
// Proxy — raw TCP relay that can pause byte forwarding.
//
// Client connects to localhost:PORT over plain TCP.
// Proxy opens a TLS (SecureSocket) connection to the real server and relays
// raw bytes in both directions — below the WebSocket framing layer.
// Calling pause() silently drops all bytes, simulating a network blackhole
// (NAT timeout / Wi-Fi drop) in the middle of an active connection.
// ---------------------------------------------------------------------------

class _SignalingProxy {
  final String _realHost;
  final int _realPort;

  ServerSocket? _server;
  bool _paused = false;

  _SignalingProxy({required String host, int port = 443}) : _realHost = host, _realPort = port;

  Future<int> start() async {
    _server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    _acceptLoop();
    return _server!.port;
  }

  void _acceptLoop() async {
    await for (final clientSocket in _server!) {
      _relay(clientSocket);
    }
  }

  void _relay(Socket clientSocket) async {
    try {
      // SecureSocket uses _realHost as SNI — cert validation works correctly.
      final serverSocket = await SecureSocket.connect(_realHost, _realPort, timeout: const Duration(seconds: 15));

      // Phase 1: buffer bytes until HTTP headers are complete, then rewrite the
      // Host header (dart:io sets it to localhost:PORT) so the server accepts
      // the WebSocket upgrade request.
      // Phase 2: relay raw bytes transparently — below WebSocket framing.
      final headerBuf = <int>[];
      var headersDone = false;

      clientSocket.listen(
        (bytes) {
          if (headersDone) {
            if (!_paused) serverSocket.add(bytes);
            return;
          }

          headerBuf.addAll(bytes);
          final end = _crlfCrlfIndex(headerBuf);
          if (end == -1) return;

          headersDone = true;
          final headerStr = String.fromCharCodes(headerBuf.sublist(0, end + 4));
          final tail = headerBuf.sublist(end + 4);
          final rewritten = headerStr.replaceFirstMapped(
            RegExp(r'^Host: .+$', multiLine: true, caseSensitive: false),
            (_) => 'Host: $_realHost',
          );

          if (!_paused) {
            serverSocket.add(rewritten.codeUnits);
            if (tail.isNotEmpty) serverSocket.add(tail);
          }
        },
        onDone: () => serverSocket.destroy(),
        onError: (_) => serverSocket.destroy(),
        cancelOnError: true,
      );

      // Server → Client: raw bytes.
      serverSocket.listen(
        (bytes) {
          if (!_paused) clientSocket.add(bytes);
        },
        onDone: () => clientSocket.destroy(),
        onError: (_) => clientSocket.destroy(),
        cancelOnError: true,
      );
    } catch (_) {
      clientSocket.destroy();
    }
  }

  static int _crlfCrlfIndex(List<int> bytes) {
    for (var i = 0; i < bytes.length - 3; i++) {
      if (bytes[i] == 13 && bytes[i + 1] == 10 && bytes[i + 2] == 13 && bytes[i + 3] == 10) return i;
    }
    return -1;
  }

  void pause() => _paused = true;
  void resume() => _paused = false;

  Future<void> stop() async => _server?.close();
}

// ---------------------------------------------------------------------------

void main() {
  late WebtritSignalingClient client;
  late String sessionToken;
  late String tenantId;

  setUpAll(() async {
    if (!_credentialsProvided) return;

    final session = await _fetchSessionToken();
    sessionToken = session.token;
    tenantId = session.tenantId;
  });

  tearDown(() async {
    if (!_credentialsProvided) return;
    await client.disconnect();
  });

  group('Live signaling — real server', skip: _credentialsProvided ? false : 'credentials not set', () {
    test('should receive StateHandshake after connecting', () async {
      client = await WebtritSignalingClient.connect(
        Uri.parse('wss://${_env(_coreUrlKey)}'),
        tenantId,
        sessionToken,
        false,
        connectionTimeout: const Duration(seconds: 15),
      );

      final handshakeCompleter = Completer<StateHandshake>();

      client.listen(
        onStateHandshake: (sh) {
          if (!handshakeCompleter.isCompleted) handshakeCompleter.complete(sh);
        },
        onEvent: (_) {},
        onError: (e, st) => fail('Unexpected error: $e\n$st'),
        onDisconnect: (_, _) {},
      );

      final handshake = await handshakeCompleter.future.timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException('No StateHandshake received within 10 s'),
      );

      expect(handshake.keepaliveInterval, greaterThan(Duration.zero));
    });

    test(
      'should complete at least one keepalive cycle without error',
      timeout: const Timeout(Duration(minutes: 2)),
      () async {
        client = await WebtritSignalingClient.connect(
          Uri.parse('wss://${_env(_coreUrlKey)}'),
          tenantId,
          sessionToken,
          false,
          connectionTimeout: const Duration(seconds: 15),
        );

        final handshakeCompleter = Completer<StateHandshake>();
        Object? capturedError;

        client.listen(
          onStateHandshake: (sh) {
            if (!handshakeCompleter.isCompleted) handshakeCompleter.complete(sh);
          },
          onEvent: (_) {},
          onError: (e, _) => capturedError = e,
          onDisconnect: (_, _) {},
        );

        final handshake = await handshakeCompleter.future.timeout(const Duration(seconds: 10));

        // Wait for one full keepalive cycle + a small buffer.
        await Future.delayed(handshake.keepaliveInterval + const Duration(seconds: 3));

        expect(capturedError, isNull, reason: 'Keepalive error: $capturedError');
      },
    );

    test('should NOT call onDisconnect when disconnect is called manually', () async {
      client = await WebtritSignalingClient.connect(
        Uri.parse('wss://${_env(_coreUrlKey)}'),
        tenantId,
        sessionToken,
        false,
        connectionTimeout: const Duration(seconds: 15),
      );

      var disconnectFired = false;
      final handshakeCompleter = Completer<void>();

      client.listen(
        onStateHandshake: (_) {
          if (!handshakeCompleter.isCompleted) handshakeCompleter.complete();
        },
        onEvent: (_) {},
        onError: (e, st) => fail('Unexpected error: $e\n$st'),
        onDisconnect: (_, _) => disconnectFired = true,
      );

      await handshakeCompleter.future.timeout(const Duration(seconds: 10));

      // disconnect() cancels the stream subscription before closing — onDisconnect must NOT fire.
      await client.disconnect(1000, 'normal closure');
      await Future.delayed(const Duration(milliseconds: 200));

      expect(disconnectFired, isFalse);
    });
  });

  group('Network simulation via proxy', skip: _credentialsProvided ? false : 'credentials not set', () {
    late _SignalingProxy proxy;
    late int proxyPort;

    setUp(() async {
      proxy = _SignalingProxy(host: _env(_coreUrlKey));
      proxyPort = await proxy.start();
    });

    tearDown(() async => proxy.stop());

    test(
      'should fire WebtritSignalingKeepaliveTransactionTimeoutException when packets are dropped mid-connection',
      timeout: const Timeout(Duration(minutes: 2)),
      () async {
        client = await WebtritSignalingClient.connect(
          Uri.parse('ws://localhost:$proxyPort'),
          tenantId,
          sessionToken,
          false,
          connectionTimeout: const Duration(seconds: 15),
        );

        final handshakeCompleter = Completer<StateHandshake>();
        final errorCompleter = Completer<Object>();

        client.listen(
          onStateHandshake: (sh) {
            if (!handshakeCompleter.isCompleted) handshakeCompleter.complete(sh);
          },
          onEvent: (_) {},
          onError: (e, _) {
            if (!errorCompleter.isCompleted) errorCompleter.complete(e);
          },
          onDisconnect: (_, _) {},
        );

        final handshake = await handshakeCompleter.future.timeout(const Duration(seconds: 10));

        // Simulate network blackhole — drop all packets in both directions.
        proxy.pause();

        // The next keepalive will be sent after keepaliveInterval.
        // It will wait 10 s for a response (defaultExecuteTransactionTimeoutDuration).
        // Total wait: keepaliveInterval + 10 s + small buffer.
        final error = await errorCompleter.future.timeout(
          handshake.keepaliveInterval + const Duration(seconds: 15),
          onTimeout: () => throw TimeoutException('No keepalive timeout error received'),
        );

        expect(error, isA<WebtritSignalingKeepaliveTransactionTimeoutException>());
      },
    );
  });
}
