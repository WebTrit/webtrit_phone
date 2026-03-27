import 'dart:async';

import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('SignalingModule');

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------

sealed class SignalingModuleEvent {}

class SignalingConnecting extends SignalingModuleEvent {}

class SignalingConnected extends SignalingModuleEvent {}

/// Connect attempt failed (SocketException, TlsException, etc.).
///
/// [isRepeated] is true when the error matches the previous connect attempt.
/// Consumers may suppress duplicate notifications when [isRepeated] is true.
///
/// [recommendedReconnectDelay] is always [kSignalingClientReconnectDelay].
/// Consumers decide whether to act on it based on app state and network.
class SignalingConnectionFailed extends SignalingModuleEvent {
  SignalingConnectionFailed({required this.error, required this.isRepeated, required this.recommendedReconnectDelay});

  final Object error;
  final bool isRepeated;
  final Duration recommendedReconnectDelay;
}

class SignalingDisconnecting extends SignalingModuleEvent {}

/// Connection closed by the server or client.
///
/// [recommendedReconnectDelay]:
///   - [Duration.zero]          — reconnect immediately (e.g. code 4441)
///   - [Duration(seconds: 3)]   — slow reconnect (default)
///   - null                     — do not reconnect (e.g. protocolError)
///
/// Consumers decide whether to act based on app state and network availability.
class SignalingDisconnected extends SignalingModuleEvent {
  SignalingDisconnected({
    required this.code,
    required this.reason,
    required this.knownCode,
    required this.recommendedReconnectDelay,
  });

  final int? code;
  final String? reason;
  final SignalingDisconnectCode knownCode;
  final Duration? recommendedReconnectDelay;
}

class SignalingHandshakeReceived extends SignalingModuleEvent {
  SignalingHandshakeReceived({required this.handshake});

  final StateHandshake handshake;
}

class SignalingProtocolEvent extends SignalingModuleEvent {
  SignalingProtocolEvent({required this.event});

  final Event event;
}

// ---------------------------------------------------------------------------
// Module
// ---------------------------------------------------------------------------

/// Manages a single [WebtritSignalingClient] lifecycle and publishes typed
/// events via a broadcast stream.
///
/// Knows only the WebSocket protocol — nothing about [CallState], BLoC, emit,
/// notifications, or app lifecycle. Can be used in the main isolate, a
/// background isolate, or an integration test without any UI dependency.
class SignalingModule {
  SignalingModule({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    required this.trustedCertificates,
    required this.signalingClientFactory,
  });

  final String coreUrl;
  final String tenantId;
  final String token;
  final TrustedCertificates trustedCertificates;
  final SignalingClientFactory signalingClientFactory;

  final _controller = StreamController<SignalingModuleEvent>.broadcast();

  WebtritSignalingClient? _client;
  bool _disposed = false;

  /// Last connect error as string for deduplication.
  String? _lastConnectErrorString;

  /// Broadcast stream of all module events. Supports multiple listeners.
  Stream<SignalingModuleEvent> get events => _controller.stream;

  /// Direct access to the connected client for sending requests
  /// (e.g. [HangupRequest], [AcceptRequest], [OutgoingCallRequest]).
  /// Null when not connected.
  WebtritSignalingClient? get signalingClient => _client;

  /// Initiates a connection. Fire-and-forget — returns immediately.
  /// The result arrives via [events] as [SignalingConnected] or
  /// [SignalingConnectionFailed].
  void connect() {
    if (_disposed) return;
    _connectAsync();
  }

  /// Disconnects the current client gracefully. Emits [SignalingDisconnecting]
  /// followed by [SignalingDisconnected] via [events].
  Future<void> disconnect() async {
    final client = _client;
    if (client == null) return;
    _client = null;
    _emit(SignalingDisconnecting());
    try {
      await client.disconnect(SignalingDisconnectCode.goingAway.code);
    } catch (e, s) {
      _logger.warning('disconnect error', e, s);
    }
  }

  /// Disconnects and closes the event stream. After [dispose], the module
  /// must not be used.
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await disconnect();
    await _controller.close();
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  Future<void> _connectAsync() async {
    // If already connected, disconnect first.
    final existing = _client;
    if (existing != null) {
      _client = null;
      try {
        await existing.disconnect();
      } catch (e, s) {
        _logger.warning('_connectAsync pre-disconnect error', e, s);
      }
    }

    if (_disposed) return;

    _emit(SignalingConnecting());

    try {
      final url = WebtritSignalingUtils.parseCoreUrlToSignalingUrl(coreUrl);
      final client = await signalingClientFactory(
        url: url,
        tenantId: tenantId,
        token: token,
        connectionTimeout: kSignalingClientConnectionTimeout,
        certs: trustedCertificates,
        force: true,
      );

      if (_disposed) {
        await client.disconnect(SignalingDisconnectCode.goingAway.code);
        return;
      }

      client.listen(onStateHandshake: _onHandshake, onEvent: _onEvent, onError: _onError, onDisconnect: _onDisconnect);

      _client = client;
      _lastConnectErrorString = null;
      _emit(SignalingConnected());
    } catch (e, s) {
      if (_disposed) return;
      _logger.warning('_connectAsync failed', e, s);

      final errorString = e.toString();
      final isRepeated = _lastConnectErrorString == errorString;
      _lastConnectErrorString = errorString;

      _emit(
        SignalingConnectionFailed(
          error: e,
          isRepeated: isRepeated,
          recommendedReconnectDelay: kSignalingClientReconnectDelay,
        ),
      );
    }
  }

  void _onHandshake(StateHandshake handshake) {
    if (_disposed) return;
    _emit(SignalingHandshakeReceived(handshake: handshake));
  }

  void _onEvent(Event event) {
    if (_disposed) return;
    _emit(SignalingProtocolEvent(event: event));
  }

  void _onError(Object error, [StackTrace? stackTrace]) {
    if (_disposed) return;
    _logger.severe('_onError', error, stackTrace);
    // Drop the client reference — the connection is broken.
    // The consumer is responsible for scheduling a reconnect.
    _client = null;

    final errorString = error.toString();
    final isRepeated = _lastConnectErrorString == errorString;
    _lastConnectErrorString = errorString;

    _emit(
      SignalingConnectionFailed(
        error: error,
        isRepeated: isRepeated,
        recommendedReconnectDelay: kSignalingClientReconnectDelay,
      ),
    );
  }

  void _onDisconnect(int? code, String? reason) {
    if (_disposed) return;
    _client = null;

    final knownCode = SignalingDisconnectCode.values.byCode(code ?? -1);
    final recommendedDelay = _reconnectDelay(knownCode);

    _logger.fine('_onDisconnect code=$code reason=$reason knownCode=$knownCode delay=$recommendedDelay');

    _emit(
      SignalingDisconnected(
        code: code,
        reason: reason,
        knownCode: knownCode,
        recommendedReconnectDelay: recommendedDelay,
      ),
    );
  }

  /// Maps a disconnect code to the recommended reconnect delay.
  ///
  /// - [Duration.zero] — reconnect immediately (server evicted a duplicate session)
  /// - [kSignalingClientReconnectDelay] — standard slow reconnect
  /// - null — do not reconnect (protocol-level error or intentional close)
  Duration? _reconnectDelay(SignalingDisconnectCode code) {
    if (code == SignalingDisconnectCode.controllerForceAttachClose) {
      return Duration.zero;
    }
    if (code == SignalingDisconnectCode.protocolError) {
      return null;
    }
    return kSignalingClientReconnectDelay;
  }

  void _emit(SignalingModuleEvent event) {
    if (_controller.isClosed) return;
    _controller.add(event);
  }
}
