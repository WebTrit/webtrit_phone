// Run with real server credentials:
//
//   WEBTRIT_APP_TEST_CUSTOM_CORE_URL=core.demo.turbocompany.com \
//   WEBTRIT_APP_TEST_EMAIL_CREDENTIAL=test@turbomail.com \
//   WEBTRIT_APP_TEST_EMAIL_VERIFY_CREDENTIAL=turbopassword \
//   flutter test test/features/call/bloc/signaling_module_live_test.dart \
//     --tags live --timeout 120s
@Tags(['live'])
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/call/bloc/call_bloc.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

// ---------------------------------------------------------------------------
// Credentials — read from environment variables.
// ---------------------------------------------------------------------------

const _coreUrlKey = 'WEBTRIT_APP_TEST_CUSTOM_CORE_URL';
const _loginKey = 'WEBTRIT_APP_TEST_EMAIL_CREDENTIAL';
const _passwordKey = 'WEBTRIT_APP_TEST_EMAIL_VERIFY_CREDENTIAL';

String _env(String key) => Platform.environment[key] ?? '';

bool get _credentialsProvided =>
    _env(_coreUrlKey).isNotEmpty && _env(_loginKey).isNotEmpty && _env(_passwordKey).isNotEmpty;

// ---------------------------------------------------------------------------
// Helper: obtain a session token via REST POST /api/v1/session.
// ---------------------------------------------------------------------------

Future<({String token, String tenantId})> _fetchSessionToken() async {
  final uri = Uri.parse('https://${_env(_coreUrlKey)}/api/v1/session');
  final client = HttpClient()
    ..connectionTimeout = const Duration(seconds: 15)
    ..badCertificateCallback = (_, __, ___) => true;

  try {
    final request = await client.postUrl(uri);
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.write(
      jsonEncode({
        'type': 'macos',
        'identifier': 'com.webtrit.phone.test',
        'login': _env(_loginKey),
        'password': _env(_passwordKey),
      }),
    );

    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();

    if (response.statusCode != 200) {
      throw StateError('Session creation failed: HTTP ${response.statusCode} — $body');
    }

    final json = jsonDecode(body) as Map<String, dynamic>;
    return (token: json['token'] as String, tenantId: json['tenant_id'] as String? ?? '');
  } finally {
    client.close();
  }
}

// ---------------------------------------------------------------------------
// Minimal SignalingModuleDelegate for live tests.
// ---------------------------------------------------------------------------

class _LiveDelegate implements SignalingModuleDelegate {
  _LiveDelegate() : _state = const CallState();

  CallState _state;

  int connectRequests = 0;
  final List<Notification> notifications = [];
  final List<(int?, String?)> disconnectedNotifications = [];

  Completer<StateHandshake> _handshakeCompleter = Completer<StateHandshake>();

  /// Returns a future that completes when the next [StateHandshake] arrives.
  ///
  /// Safe to call multiple times — each call returns a fresh future for the
  /// subsequent handshake, even if a previous one has already completed.
  Future<StateHandshake> nextHandshake({Duration timeout = const Duration(seconds: 15)}) {
    if (_handshakeCompleter.isCompleted) {
      _handshakeCompleter = Completer<StateHandshake>();
    }
    return _handshakeCompleter.future.timeout(
      timeout,
      onTimeout: () => throw TimeoutException('No StateHandshake received within ${timeout.inSeconds}s'),
    );
  }

  @override
  CallState get currentState => _state;

  @override
  bool get isModuleClosed => false;

  void updateState(CallState s) => _state = s;

  @override
  void requestConnect() => connectRequests++;

  @override
  void requestDisconnect() {}

  @override
  void notifyDisconnected(int? code, String? reason) => disconnectedNotifications.add((code, reason));

  @override
  void onStateHandshake(StateHandshake sh) {
    if (!_handshakeCompleter.isCompleted) _handshakeCompleter.complete(sh);
  }

  @override
  void onSignalingEvent(Event event) {}

  @override
  void dispatchRegistrationChange(RegistrationStatus status, {int? code, String? reason}) {}

  @override
  void dispatchCompleteCall(String callId) {}

  @override
  void showNotification(Notification notification) => notifications.add(notification);
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late String coreUrl;
  late String sessionToken;
  late String tenantId;

  setUpAll(() async {
    if (!_credentialsProvided) return;
    coreUrl = _env(_coreUrlKey);
    final session = await _fetchSessionToken();
    sessionToken = session.token;
    tenantId = session.tenantId;
  });

  group(
    'SignalingModule live — real server',
    skip: _credentialsProvided ? null : 'Credentials not set. Provide $_coreUrlKey, $_loginKey, $_passwordKey.',
    () {
      late _LiveDelegate delegate;
      late SignalingModule module;
      final emittedStates = <CallState>[];

      void recordAndUpdate(CallState s) {
        emittedStates.add(s);
        delegate.updateState(s);
      }

      SignalingModule buildModule() => SignalingModule(
        coreUrl: 'https://$coreUrl',
        tenantId: tenantId,
        token: sessionToken,
        trustedCertificates: TrustedCertificates.empty,
        signalingClientFactory: defaultSignalingClientFactory,
        delegate: delegate,
      );

      setUp(() {
        emittedStates.clear();
        delegate = _LiveDelegate();
        module = buildModule();
      });

      tearDown(() async {
        try {
          await module.dispose();
        } catch (_) {}
      });

      // -----------------------------------------------------------------------

      test('performConnect emits connecting → connect status', () async {
        await module.performConnect(recordAndUpdate, () => false);

        expect(
          emittedStates.any((s) => s.callServiceState.signalingClientStatus == SignalingClientStatus.connecting),
          isTrue,
          reason: 'connecting state should be emitted before connect',
        );
        expect(
          emittedStates.last.callServiceState.signalingClientStatus,
          SignalingClientStatus.connect,
          reason: 'final emitted status should be connect',
        );
        expect(module.signalingClient, isNotNull);
      });

      test('performConnect delivers StateHandshake via delegate', () async {
        await module.performConnect(recordAndUpdate, () => false);

        final handshake = await delegate.nextHandshake();

        expect(handshake.keepaliveInterval, greaterThan(Duration.zero));
        expect(handshake.lines, isNotEmpty);
      });

      test('performDisconnect emits disconnecting → disconnect and clears signalingClient', () async {
        await module.performConnect(recordAndUpdate, () => false);
        await delegate.nextHandshake();

        emittedStates.clear();
        await module.performDisconnect(recordAndUpdate, () => false);

        expect(
          emittedStates.any((s) => s.callServiceState.signalingClientStatus == SignalingClientStatus.disconnecting),
          isTrue,
        );
        expect(emittedStates.last.callServiceState.signalingClientStatus, SignalingClientStatus.disconnect);
        expect(module.signalingClient, isNull);
      });

      test('second performConnect after disconnect re-establishes connection', () async {
        await module.performConnect(recordAndUpdate, () => false);
        await delegate.nextHandshake();

        await module.performDisconnect(recordAndUpdate, () => false);
        expect(module.signalingClient, isNull);

        // Fresh module with same delegate for the second connect.
        module = buildModule();
        await module.performConnect(recordAndUpdate, () => false);

        final handshake = await delegate.nextHandshake();
        expect(module.signalingClient, isNotNull);
        expect(handshake.keepaliveInterval, greaterThan(Duration.zero));
      });

      test(
        'keepalive cycle completes without triggering reconnect',
        timeout: const Timeout(Duration(minutes: 2)),
        () async {
          await module.performConnect(recordAndUpdate, () => false);
          final handshake = await delegate.nextHandshake();

          // Wait one full keepalive cycle plus a small buffer.
          await Future.delayed(handshake.keepaliveInterval + const Duration(seconds: 3));

          expect(
            delegate.connectRequests,
            0,
            reason: 'connectRequests > 0 means _onError fired and triggered a reconnect',
          );
          expect(module.signalingClient, isNotNull, reason: 'client should remain connected');
        },
      );

      test('reconnect(force: true) calls delegate.requestConnect after delay', () async {
        module.reconnect(delay: Duration.zero, force: true);

        await Future.delayed(const Duration(milliseconds: 50));

        expect(delegate.connectRequests, 1);
      });

      test('dispose cancels pending reconnect timer and disconnects client', () async {
        await module.performConnect(recordAndUpdate, () => false);
        await delegate.nextHandshake();

        module.reconnect(delay: const Duration(seconds: 60), force: true);

        await module.dispose();

        await Future.delayed(const Duration(milliseconds: 100));

        // Timer was cancelled — no additional connect requests should arrive.
        expect(delegate.connectRequests, 0);
        expect(module.signalingClient, isNull);
      });
    },
  );
}
