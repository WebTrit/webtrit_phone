/// Unit tests for [SignalingModuleImpl].
///
/// Two independent bug scenarios are covered:
///
/// 1. disconnect-during-connect race condition:
///    When [SignalingModuleImpl.disconnect] is called while [_connectAsync] is
///    still awaiting the client factory (_client == null, _connectToken != null),
///    disconnect() must cancel the in-flight attempt by clearing _connectToken.
///
/// 2. _errorHandled not reset on reconnect (WT-1403):
///    When _onError fires for clientA (sets _errorHandled=true), then clientB
///    connects, _errorHandled must be reset. If not, clientB's legitimate
///    disconnect is silently suppressed and no reconnect is triggered.
///
/// Tests labelled "BUG:" assert correct behavior — they fail on the unfixed code.
/// Tests labelled "after fix:" verify the same behavior stays correct.
library;

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

// ---------------------------------------------------------------------------
// Fake client
// ---------------------------------------------------------------------------

class _FakeClient extends Fake implements WebtritSignalingClient {
  DisconnectHandler? _onDisconnect;

  @override
  void listen({
    required StateHandshakeHandler onStateHandshake,
    required EventHandler onEvent,
    required ErrorHandler onError,
    required DisconnectHandler onDisconnect,
  }) {
    _onDisconnect = onDisconnect;
  }

  @override
  Future<void> disconnect([int? code, String? reason]) async {
    _onDisconnect?.call(code, reason);
  }

  @override
  Future<void> execute(Request request, [Duration? timeout]) async {}
}

// ---------------------------------------------------------------------------
// Controllable client — captures onError + onDisconnect for manual triggering
// ---------------------------------------------------------------------------

class _ControllableClient extends Fake implements WebtritSignalingClient {
  ErrorHandler? _capturedOnError;
  DisconnectHandler? _capturedOnDisconnect;

  @override
  void listen({
    required StateHandshakeHandler onStateHandshake,
    required EventHandler onEvent,
    required ErrorHandler onError,
    required DisconnectHandler onDisconnect,
  }) {
    _capturedOnError = onError;
    _capturedOnDisconnect = onDisconnect;
  }

  @override
  Future<void> disconnect([int? code, String? reason]) async {
    _capturedOnDisconnect?.call(code, reason);
  }

  @override
  Future<void> execute(Request request, [Duration? timeout]) async {}

  void triggerError(Object error) => _capturedOnError?.call(error, null);
  void triggerDisconnect(int? code, [String? reason]) => _capturedOnDisconnect?.call(code, reason);
}

// ---------------------------------------------------------------------------
// Controlled factory
// ---------------------------------------------------------------------------

/// A factory where each call gets its own [Completer].
/// Tracks how many times the factory was called and allows releasing each
/// call independently.
class _ControlledFactory {
  final _calls = <Completer<WebtritSignalingClient>>[];
  int get callCount => _calls.length;

  Completer<WebtritSignalingClient> get lastCall => _calls.last;

  SignalingClientFactory get factory =>
      ({
        required Uri url,
        required String tenantId,
        required String token,
        required Duration connectionTimeout,
        required TrustedCertificates certs,
        required bool force,
      }) {
        final c = Completer<WebtritSignalingClient>();
        _calls.add(c);
        return c.future;
      };

  void release(int callIndex, WebtritSignalingClient client) => _calls[callIndex].complete(client);
}

// ---------------------------------------------------------------------------
// Helper
// ---------------------------------------------------------------------------

SignalingModuleImpl _buildModule(SignalingClientFactory factory) => SignalingModuleImpl(
  coreUrl: 'https://example.com',
  tenantId: 'tenant',
  token: 'token',
  trustedCertificates: TrustedCertificates.empty,
  clientFactory: factory,
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('SignalingModuleImpl — disconnect() during in-flight connect()', () {
    // -----------------------------------------------------------------------
    // Core bug: disconnect while _client==null leaves _connecting=true
    // -----------------------------------------------------------------------

    test('BUG: second connect() is silently dropped because _connecting stays true after disconnect()', () async {
      // Arrange
      final factory = _ControlledFactory();
      final module = _buildModule(factory.factory);

      // Act: connect #1 → factory called, hangs
      module.connect();
      await Future<void>.delayed(Duration.zero);
      expect(factory.callCount, 1, reason: 'first connect() must call the factory');

      // disconnect() while _client==null — the bug: does not reset _connecting
      await module.disconnect();

      // connect #2 — must call the factory again; currently it is silently dropped
      module.connect();
      await Future<void>.delayed(Duration.zero);

      // BUG: factory was not called a second time — second connect() was dropped
      expect(
        factory.callCount,
        2,
        reason: 'second connect() was silently dropped: factory call count did not increase',
      );
    });

    // -----------------------------------------------------------------------
    // Consequence: stale connect completes and leaves module in wrong state
    // -----------------------------------------------------------------------

    test('BUG: stale in-flight connect completes after disconnect() and leaves module connected', () async {
      // Arrange
      final factory = _ControlledFactory();
      final module = _buildModule(factory.factory);
      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      // connect #1 → factory hangs
      module.connect();
      await Future<void>.delayed(Duration.zero);

      // disconnect() — no-op when _client==null (the bug)
      await module.disconnect();

      // Release the stale factory (simulates slow WebSocket that eventually connects)
      factory.release(0, _FakeClient());
      await Future<void>.delayed(Duration.zero);

      // BUG: module is now "connected" even though we explicitly disconnected
      expect(
        module.isConnected,
        isFalse,
        reason: 'stale connect() completed after disconnect() and incorrectly set _client',
      );
      expect(
        events.whereType<SignalingConnected>(),
        isEmpty,
        reason: 'SignalingConnected must not fire for a connect() superseded by disconnect()',
      );
    });

    // -----------------------------------------------------------------------
    // Expected correct behavior after the fix
    // -----------------------------------------------------------------------

    test('after fix: disconnect() cancels in-flight connect so second connect() reaches the factory', () async {
      final factory = _ControlledFactory();
      final module = _buildModule(factory.factory);
      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      // connect #1 → hangs
      module.connect();
      await Future<void>.delayed(Duration.zero);

      // disconnect() → must cancel connect #1 and reset _connecting
      await module.disconnect();

      // connect #2 → must be accepted (factory called again)
      module.connect();
      await Future<void>.delayed(Duration.zero);
      expect(factory.callCount, 2, reason: 'second connect() must call the factory');

      // Release connect #2 — module should become connected
      factory.release(1, _FakeClient());
      await Future<void>.delayed(Duration.zero);

      expect(module.isConnected, isTrue);
      expect(events.whereType<SignalingConnected>(), isNotEmpty);
    });

    test('after fix: stale factory result is discarded, SignalingConnected not emitted', () async {
      final factory = _ControlledFactory();
      final module = _buildModule(factory.factory);
      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      // connect #1 → hangs
      module.connect();
      await Future<void>.delayed(Duration.zero);

      // disconnect() cancels connect #1
      await module.disconnect();

      // Release the stale factory call AFTER disconnect
      factory.release(0, _FakeClient());
      await Future<void>.delayed(Duration.zero);

      // Stale result must be discarded
      expect(module.isConnected, isFalse);
      expect(events.whereType<SignalingConnected>(), isEmpty);
    });
  });

  // ---------------------------------------------------------------------------
  // WT-1403: _errorHandled not reset when a new client connects
  //
  // Sequence that triggers the bug:
  //   1. clientA connects → _client=clientA, _errorHandled=false
  //   2. clientA _onError fires → _errorHandled=true, _client=null
  //   3. connect() again → clientB connects → _client=clientB
  //      BUG: _errorHandled is NOT reset here
  //   4. stale clientA _onDisconnect fires → guard returns early (clientB!=clientA)
  //      _errorHandled stays true on buggy code
  //   5. clientB legitimate disconnect → _onDisconnect called → sees _errorHandled=true
  //      → silently suppresses SignalingDisconnected → no reconnect triggered
  //
  // Fix: add `_errorHandled = false;` in _connectAsync after `_client = client;`.
  // ---------------------------------------------------------------------------

  group('SignalingModuleImpl — _errorHandled not reset on reconnect (WT-1403)', () {
    SignalingModuleImpl _buildModuleWith(List<WebtritSignalingClient> clients) {
      var index = 0;
      return SignalingModuleImpl(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'token',
        trustedCertificates: TrustedCertificates.empty,
        clientFactory:
            ({
              required Uri url,
              required String tenantId,
              required String token,
              required Duration connectionTimeout,
              required TrustedCertificates certs,
              required bool force,
            }) async => clients[index++],
      );
    }

    test('BUG: SignalingDisconnected suppressed when _errorHandled left true after prior clientA error', () async {
      final clientA = _ControllableClient();
      final clientB = _ControllableClient();
      final module = _buildModuleWith([clientA, clientB]);
      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      // Step 1: connect → clientA established
      module.connect();
      await Future<void>.delayed(Duration.zero);
      expect(events.whereType<SignalingConnected>(), hasLength(1));

      // Step 2: clientA error → _errorHandled=true, _client=null
      clientA.triggerError(Exception('keepalive timeout'));
      expect(events.whereType<SignalingConnectionFailed>(), hasLength(1));
      expect(module.isConnected, isFalse);

      // Step 3: reconnect → clientB established
      // BUG: _errorHandled is NOT reset to false at _client=clientB
      module.connect();
      await Future<void>.delayed(Duration.zero);
      expect(events.whereType<SignalingConnected>(), hasLength(2));
      expect(module.isConnected, isTrue);

      // Step 4: stale clientA _onDisconnect fires (e.g. force-attach-close 4441)
      // Guard returns early — _errorHandled stays true on buggy code
      clientA.triggerDisconnect(4441, 'force attach close');

      // Step 5: clientB legitimate disconnect (server keepalive timeout 4502)
      clientB.triggerDisconnect(4502, 'keepalive timeout');

      // On buggy code: _errorHandled=true causes _onDisconnect to return early
      // without emitting SignalingDisconnected → this assertion FAILS on current code
      expect(
        events.whereType<SignalingDisconnected>(),
        hasLength(1),
        reason:
            'BUG: _errorHandled was not reset on reconnect — '
            'clientB disconnect silently suppressed, no reconnect triggered',
      );
    });

    test('BUG: SignalingDisconnected suppressed even without stale intermediate disconnect', () async {
      // Same bug manifests without the stale clientA disconnect in step 4:
      // just clientA error → clientB connects → clientB disconnects.
      final clientA = _ControllableClient();
      final clientB = _ControllableClient();
      final module = _buildModuleWith([clientA, clientB]);
      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      // clientA error → _errorHandled=true
      clientA.triggerError(Exception('timeout'));

      // clientB connects — _errorHandled NOT reset (buggy code)
      module.connect();
      await Future<void>.delayed(Duration.zero);

      // clientB legitimate disconnect — suppressed on buggy code
      clientB.triggerDisconnect(4502);

      expect(
        events.whereType<SignalingDisconnected>(),
        hasLength(1),
        reason: 'BUG: first disconnect after error always suppressed when _errorHandled not reset',
      );
    });

    test('after fix: SignalingDisconnected emitted for clientB with correct code and reconnect delay', () async {
      final clientA = _ControllableClient();
      final clientB = _ControllableClient();
      final module = _buildModuleWith([clientA, clientB]);
      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await Future<void>.delayed(Duration.zero);
      clientA.triggerError(Exception('keepalive timeout'));
      module.connect();
      await Future<void>.delayed(Duration.zero);

      clientA.triggerDisconnect(4441);
      clientB.triggerDisconnect(4502);

      final disconnects = events.whereType<SignalingDisconnected>().toList();
      expect(disconnects, hasLength(1));
      expect(disconnects.first.code, 4502);
      expect(
        disconnects.first.recommendedReconnectDelay,
        isNotNull,
        reason: 'code 4502 is not protocolError — reconnect delay must be provided',
      );
    });

    test('after fix: stale clientA disconnect alone does not emit SignalingDisconnected', () async {
      // Verifies the stale guard still works correctly after the fix:
      // only the stale disconnect fires (no clientB disconnect) → no event.
      final clientA = _ControllableClient();
      final clientB = _ControllableClient();
      final module = _buildModuleWith([clientA, clientB]);
      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await Future<void>.delayed(Duration.zero);
      clientA.triggerError(Exception('timeout'));
      module.connect();
      await Future<void>.delayed(Duration.zero);

      // Only stale clientA disconnect — clientB is still connected
      clientA.triggerDisconnect(4441);

      expect(module.isConnected, isTrue, reason: 'clientB should still be connected');
      expect(events.whereType<SignalingDisconnected>(), isEmpty);
    });
  });
}
