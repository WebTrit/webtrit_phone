/// Unit tests for [SignalingModuleImpl].
///
/// Reproduces the disconnect-during-connect race condition:
///
/// When [SignalingModuleImpl.disconnect] is called while [_connectAsync] is
/// still awaiting the client factory (_client == null, _connectToken != null),
/// disconnect() must cancel the in-flight attempt by clearing _connectToken.
/// The next connect() call must then be allowed to start a fresh attempt
/// instead of being blocked by the stale in-flight operation.
///
/// Tests labelled "BUG:" reproduce the broken behavior on the unfixed code.
/// Tests labelled "after fix:" verify the correct behavior.

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
}
