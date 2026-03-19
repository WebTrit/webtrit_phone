@Tags(['live'])
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import 'package:_tcp_proxy/_tcp_proxy.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

// ---------------------------------------------------------------------------
// Credentials — read from environment variables.
// Match the keys in dart_define.integration_test.json so the same CI config
// works for both app-level and signaling live tests.
//
// Run example:
//   WEBTRIT_APP_TEST_CUSTOM_CORE_URL=core.support.portaone.com \
//   WEBTRIT_APP_TEST_EMAIL_CREDENTIAL=111000333 \
//   WEBTRIT_APP_TEST_EMAIL_VERIFY_CREDENTIAL=zzzxxx123 \
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
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 15);

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

void main() {
  WebtritSignalingClient? client;
  late String sessionToken;
  late String tenantId;

  setUpAll(() async {
    if (!_credentialsProvided) return;

    final session = await _fetchSessionToken();
    sessionToken = session.token;
    tenantId = session.tenantId;
  });

  tearDown(() async {
    await client?.disconnect();
    client = null;
  });

  group('Live signaling — real server', skip: _credentialsProvided ? false : 'credentials not set', () {
    test('should receive StateHandshake after connecting', () async {
      final signalingClient = await WebtritSignalingClient.connect(
        Uri.parse('wss://${_env(_coreUrlKey)}'),
        tenantId,
        sessionToken,
        false,
        connectionTimeout: const Duration(seconds: 15),
      );
      client = signalingClient;

      final handshakeCompleter = Completer<StateHandshake>();

      signalingClient.listen(
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
        final signalingClient = await WebtritSignalingClient.connect(
          Uri.parse('wss://${_env(_coreUrlKey)}'),
          tenantId,
          sessionToken,
          false,
          connectionTimeout: const Duration(seconds: 15),
        );
        client = signalingClient;

        final handshakeCompleter = Completer<StateHandshake>();
        Object? capturedError;

        signalingClient.listen(
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
      final signalingClient = await WebtritSignalingClient.connect(
        Uri.parse('wss://${_env(_coreUrlKey)}'),
        tenantId,
        sessionToken,
        false,
        connectionTimeout: const Duration(seconds: 15),
      );
      client = signalingClient;

      var disconnectFired = false;
      final handshakeCompleter = Completer<void>();

      signalingClient.listen(
        onStateHandshake: (_) {
          if (!handshakeCompleter.isCompleted) handshakeCompleter.complete();
        },
        onEvent: (_) {},
        onError: (e, st) => fail('Unexpected error: $e\n$st'),
        onDisconnect: (_, _) => disconnectFired = true,
      );

      await handshakeCompleter.future.timeout(const Duration(seconds: 10));

      // disconnect() cancels the stream subscription before closing — onDisconnect must NOT fire.
      await signalingClient.disconnect(1000, 'normal closure');
      await Future.delayed(const Duration(milliseconds: 200));

      expect(disconnectFired, isFalse);
    });
  });

  group('Network simulation via proxy', skip: _credentialsProvided ? false : 'credentials not set', () {
    late TcpProxy proxy;
    late int proxyPort;

    setUp(() async {
      proxy = TcpProxy(host: _env(_coreUrlKey), rewriteHostHeader: _env(_coreUrlKey));
      proxyPort = await proxy.start();
    });

    tearDown(() async => proxy.stop());

    test(
      'should fire WebtritSignalingKeepaliveTransactionTimeoutException when packets are dropped mid-connection',
      timeout: const Timeout(Duration(minutes: 2)),
      () async {
        final signalingClient = await WebtritSignalingClient.connect(
          Uri.parse('ws://127.0.0.1:$proxyPort'),
          tenantId,
          sessionToken,
          false,
          connectionTimeout: const Duration(seconds: 15),
        );
        client = signalingClient;

        final handshakeCompleter = Completer<StateHandshake>();
        final errorCompleter = Completer<Object>();

        signalingClient.listen(
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

        // Simulate network blackhole — drop all bytes in both directions.
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
