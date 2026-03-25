import 'dart:async';

import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

/// A controllable fake [WebtritSignalingClient] for use in CallBloc tests.
///
/// Captures [listen] callbacks on construction so tests can drive the server
/// side by calling [simulateHandshake], [simulateEvent], [simulateError], and
/// [simulateDisconnect].
class FakeSignalingClient implements WebtritSignalingClient {
  StateHandshakeHandler? _onStateHandshake;
  EventHandler? _onEvent;
  ErrorHandler? _onError;
  DisconnectHandler? _onDisconnect;

  bool _disconnected = false;

  @override
  void listen({
    required StateHandshakeHandler onStateHandshake,
    required EventHandler onEvent,
    required ErrorHandler onError,
    required DisconnectHandler onDisconnect,
  }) {
    _onStateHandshake = onStateHandshake;
    _onEvent = onEvent;
    _onError = onError;
    _onDisconnect = onDisconnect;
  }

  @override
  Future<void> execute(Request request, [Duration? timeout]) async {}

  @override
  Future<void> disconnect([int? code, String? reason]) async {
    _disconnected = true;
  }

  bool get isDisconnected => _disconnected;

  void simulateHandshake(StateHandshake handshake) => _onStateHandshake?.call(handshake);
  void simulateEvent(Event event) => _onEvent?.call(event);
  void simulateError(Object error, [StackTrace? stackTrace]) => _onError?.call(error, stackTrace);
  void simulateDisconnect([int? code, String? reason]) => _onDisconnect?.call(code, reason);
}

/// A factory that immediately returns a pre-created [FakeSignalingClient].
///
/// Assign [client] before calling the factory. The factory completes
/// synchronously (no network I/O), so tests can rely on [FakeAsync] timers.
class FakeSignalingClientFactory {
  FakeSignalingClient? client;

  Future<WebtritSignalingClient> call({
    required Uri url,
    required String tenantId,
    required String token,
    required Duration connectionTimeout,
    required TrustedCertificates certs,
    required bool force,
  }) async {
    final c = client ?? FakeSignalingClient();
    client = c;
    return c;
  }
}

/// A minimal [StateHandshake] sufficient for bloc tests.
StateHandshake minimalStateHandshake({
  RegistrationStatus registrationStatus = RegistrationStatus.registered,
  int linesCount = 1,
}) {
  return StateHandshake(
    keepaliveInterval: const Duration(seconds: 30),
    timestamp: 0,
    registration: Registration(status: registrationStatus),
    lines: List.filled(linesCount, null),
    userActiveCalls: const [],
    contactsPresenceInfo: const {},
    guestLine: null,
  );
}
