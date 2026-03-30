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

  /// Events buffered since the last [connect] call. Cleared on every [connect]
  /// so that late subscribers receive only the current session's events.
  final List<SignalingModuleEvent> _sessionBuffer = [];

  WebtritSignalingClient? _client;
  bool _disposed = false;
  bool _connecting = false;

  /// Completer resolved by [_onDisconnect] after a graceful [disconnect] call.
  /// [dispose] awaits it (with timeout) before closing the controller so that
  /// [SignalingDisconnected] is emitted before the stream closes.
  Completer<void>? _disconnectAck;

  /// Last connect error as string for deduplication.
  String? _lastConnectErrorString;

  /// Broadcast stream of all module events.
  ///
  /// Each new subscriber immediately receives all events buffered since the
  /// last [connect] call, followed by live events. This allows [SignalingModule]
  /// to be connected before [CallBloc] (or any other consumer) is created —
  /// the consumer will not miss [SignalingConnected], [SignalingHandshakeReceived],
  /// or any protocol events that arrived in the interim.
  Stream<SignalingModuleEvent> get events {
    // sync: true so that events emitted via _controller.add() are forwarded
    // to the subscriber in the same stack frame, preserving ordering and
    // removing the extra async hop that would otherwise cause events to
    // arrive after an await returns.
    final liveController = StreamController<SignalingModuleEvent>(sync: true);
    // Subscribe to the live broadcast stream first so no future events are missed.
    final liveSub = _controller.stream.listen(
      liveController.add,
      onError: liveController.addError,
      onDone: liveController.close,
    );
    liveController.onCancel = liveSub.cancel;
    // Replay the current session's past events synchronously.
    for (final event in List<SignalingModuleEvent>.of(_sessionBuffer)) {
      liveController.add(event);
    }
    return liveController.stream;
  }

  /// Direct access to the connected client for sending requests
  /// (e.g. [HangupRequest], [AcceptRequest], [OutgoingCallRequest]).
  /// Null when not connected.
  WebtritSignalingClient? get signalingClient => _client;

  /// Initiates a connection. Fire-and-forget — returns immediately.
  /// The result arrives via [events] as [SignalingConnected] or
  /// [SignalingConnectionFailed].
  ///
  /// Clears the session buffer so that late subscribers receive only events
  /// from the current session, not stale events from a previous one.
  void connect() {
    if (_disposed) return;
    _sessionBuffer.clear();
    unawaited(_connectAsync());
  }

  /// Disconnects the current client gracefully. Emits [SignalingDisconnecting]
  /// immediately. [SignalingDisconnected] follows asynchronously once the
  /// underlying WebSocket confirms closure via the [_onDisconnect] callback.
  Future<void> disconnect() async {
    final client = _client;
    if (client == null) return;
    _client = null;
    _disconnectAck = Completer<void>();
    _emit(SignalingDisconnecting());
    try {
      await client.disconnect(SignalingDisconnectCode.goingAway.code);
    } catch (e, s) {
      _logger.warning('disconnect error', e, s);
      _disconnectAck?.complete();
      _disconnectAck = null;
    }
  }

  /// Disconnects and closes the event stream. After [dispose], the module
  /// must not be used.
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _sessionBuffer.clear();
    await disconnect();
    // Wait for _onDisconnect to fire so SignalingDisconnected is emitted before
    // the stream closes. Without this await, dispose() may close the controller
    // before the WS close-ack callback arrives, leaving consumers stuck in the
    // disconnecting state.
    await _disconnectAck?.future.timeout(const Duration(seconds: 3), onTimeout: () {});
    await _controller.close();
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  Future<void> _connectAsync() async {
    if (_connecting) return;
    _connecting = true;
    try {
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
          try {
            await client.disconnect(SignalingDisconnectCode.goingAway.code);
          } catch (e, s) {
            _logger.warning('_connectAsync dispose-disconnect error', e, s);
          }
          return;
        }

        client.listen(
          onStateHandshake: _onHandshake,
          onEvent: _onEvent,
          onError: _onError,
          onDisconnect: _onDisconnect,
        );

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
    } finally {
      _connecting = false;
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
    _client = null;
    final ack = _disconnectAck;
    _disconnectAck = null;

    // Emit even when _disposed is true so long as the controller is still open
    // — dispose() awaits _disconnectAck before closing, so this window exists.
    // _emit already guards against a closed controller.
    if (!_disposed) {
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

    ack?.complete();
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
    _sessionBuffer.add(event);
    _controller.add(event);
  }
}
