import 'dart:async';

import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'models/signaling_module.dart';
import 'models/signaling_module_event.dart';
import 'models/signaling_service_config.dart';
import 'signaling_event_buffer.dart';
import 'signaling_request_queue.dart';

final _logger = Logger('SignalingModuleImpl');

/// Factory function signature for creating a [WebtritSignalingClient].
///
/// The default implementation delegates directly to [WebtritSignalingClient.connect].
/// Override in tests to inject a mock transport.
typedef SignalingClientFactory =
    Future<WebtritSignalingClient> Function({
      required Uri url,
      required String tenantId,
      required String token,
      required Duration connectionTimeout,
      required TrustedCertificates certs,
      required bool force,
    });

Uri _coreUrlToSignalingUrl(String coreUrl) {
  final uri = Uri.parse(coreUrl);
  return uri.replace(scheme: uri.scheme.endsWith('s') ? 'wss' : 'ws');
}

Future<WebtritSignalingClient> _defaultClientFactory({
  required Uri url,
  required String tenantId,
  required String token,
  required Duration connectionTimeout,
  required TrustedCertificates certs,
  required bool force,
}) {
  return WebtritSignalingClient.connect(
    url,
    tenantId,
    token,
    force,
    connectionTimeout: connectionTimeout,
    certs: certs,
  );
}

/// Default factory that creates a [SignalingModuleImpl] from a [SignalingServiceConfig].
///
/// Annotated with [@pragma('vm:entry-point')] so that [PluginUtilities] can
/// serialize its handle for the Android background isolate.
/// Pass to [WebtritSignalingService.setModuleFactory] during app bootstrap.
@pragma('vm:entry-point')
SignalingModule createSignalingModule(SignalingServiceConfig config) {
  return SignalingModuleImpl(
    coreUrl: config.coreUrl,
    tenantId: config.tenantId,
    token: config.token,
    trustedCertificates: config.trustedCertificates,
  );
}

/// Default concrete implementation of [SignalingModule].
///
/// Owns a single [WebtritSignalingClient] lifecycle and publishes typed events
/// via a broadcast stream with session-replay buffering for late subscribers.
///
/// Knows only the WebSocket protocol -- nothing about UI, BLoC, or app
/// lifecycle. Safe to use in the main isolate, a background isolate, or an
/// integration test without any Flutter dependency.
///
/// Parameters:
/// - [connectionTimeout] -- how long to wait for the initial WebSocket handshake.
/// - [reconnectDelay] -- delay hint emitted in [SignalingConnectionFailed] and
///   [SignalingDisconnected] events; consumers use it to schedule reconnects.
/// - [clientFactory] -- override for testing; defaults to [WebtritSignalingClient.connect].
class SignalingModuleImpl implements SignalingModule {
  SignalingModuleImpl({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    required this.trustedCertificates,
    this.connectionTimeout = const Duration(seconds: 10),
    this.reconnectDelay = const Duration(seconds: 3),
    SignalingClientFactory? clientFactory,
  }) : _clientFactory = clientFactory ?? _defaultClientFactory;

  final String coreUrl;
  final String tenantId;
  final String token;
  final TrustedCertificates trustedCertificates;
  final Duration connectionTimeout;
  final Duration reconnectDelay;
  final SignalingClientFactory _clientFactory;

  // sync: true ensures events are delivered to existing listeners in the same
  // call stack as _emit(), preserving ordering and eliminating async-dispatch
  // races where a late-arriving broadcast event could duplicate a replayed one.
  //
  // Reentrancy assumption: consumers must not call connect() or disconnect()
  // synchronously inside an event listener. Doing so would re-enter _emit()
  // in the same stack frame and produce unexpected ordering.
  final _controller = StreamController<SignalingModuleEvent>.broadcast(sync: true);

  final _eventBuffer = SignalingEventBuffer();
  final _requestQueue = SignalingRequestQueue();

  WebtritSignalingClient? _client;
  bool _disposed = false;

  /// Identity token for the active connect attempt.
  ///
  /// Non-null while a [_connectAsync] is in progress (acts as [_connecting]).
  /// [connect] creates a fresh [Object] and passes it to [_connectAsync].
  /// [disconnect] sets it to null, which [_connectAsync] detects after each
  /// suspension point — the "latest wins" pattern for non-cancellable Futures.
  Object? _connectToken;

  /// Completer resolved by [_onDisconnect] after a graceful [disconnect] call.
  Completer<void>? _disconnectAck;

  /// Set to true by [disconnect] so that [_onDisconnect] emits
  /// [SignalingDisconnected] with [recommendedReconnectDelay] = null,
  /// preventing consumers from scheduling a spurious reconnect after an
  /// intentional close.
  bool _intentionalDisconnect = false;

  /// Set to true by [_onError] so that the subsequent [_onDisconnect] callback
  /// is suppressed -- [_onError] already emits [SignalingConnectionFailed] and
  /// consumers would otherwise receive two separate reconnect triggers.
  bool _errorHandled = false;

  /// Last connect error as string for deduplication.
  String? _lastConnectErrorString;

  /// Broadcast stream of all module events.
  ///
  /// Each new subscriber immediately receives buffered lifecycle and handshake
  /// events since the last [connect] call, followed by live events.
  /// See [SignalingEventBuffer] for the full buffering contract.
  ///
  /// Call [events] exactly once per consumer and hold the returned
  /// [StreamSubscription]; calling it multiple times leaks controllers.
  @override
  Stream<SignalingModuleEvent> get events {
    final snapshot = _eventBuffer.snapshot;
    final liveController = StreamController<SignalingModuleEvent>(sync: true);
    final liveSub = _controller.stream.listen(
      liveController.add,
      onError: liveController.addError,
      onDone: liveController.close,
    );
    liveController.onCancel = () async {
      await liveSub.cancel();
      if (!liveController.isClosed) await liveController.close();
    };
    for (final event in snapshot) {
      liveController.add(event);
    }
    return liveController.stream;
  }

  /// Direct access to the connected client for sending requests.
  /// Null when not connected.
  WebtritSignalingClient? get signalingClient => _client;

  @override
  bool get isConnected => _client != null;

  @override
  Future<void>? execute(Request request) {
    final client = _client;
    if (client != null) {
      return _requestQueue.executeNow(
        execute: client.execute,
        request: request,
        isActive: () => identical(_client, client),
      );
    }
    return _requestQueue.enqueue(request);
  }

  /// Initiates a connection. Fire-and-forget -- result arrives via [events].
  /// Clears the session buffer on each call.
  @override
  void connect() {
    if (_disposed || _connectToken != null) return;
    final token = _connectToken = Object();
    _eventBuffer.clear();
    unawaited(_connectAsync(token));
  }

  @override
  Future<void> disconnect() async {
    _connectToken = null; // invalidate any in-flight _connectAsync

    final client = _client;
    if (client == null) {
      _logger.fine('disconnect: no active client, in-flight connect cancelled');
      return;
    }
    _client = null;
    _intentionalDisconnect = true;
    _disconnectAck = Completer<void>();
    _emit(SignalingDisconnecting());
    try {
      await client.disconnect(SignalingDisconnectCode.normalClosure.code);
    } catch (e, s) {
      _logger.warning('disconnect error', e, s);
      _disconnectAck?.complete();
      _disconnectAck = null;
    }
  }

  /// Disconnects and closes the event stream. After [dispose], the instance
  /// must not be used.
  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _requestQueue.failAll(NotConnectedException('Signaling module is disposed'));
    _eventBuffer.clear();
    await disconnect();
    await _disconnectAck?.future.timeout(const Duration(seconds: 3), onTimeout: () {});
    await _controller.close();
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  Future<void> _connectAsync(Object connectToken) async {
    try {
      final existing = _client;
      if (existing != null) {
        _client = null;
        try {
          await existing.disconnect();
        } catch (e, s) {
          _logger.warning('_connectAsync pre-disconnect error', e, s);
        }
      }

      if (_connectToken != connectToken || _disposed) return;

      _emit(SignalingConnecting());

      try {
        final url = _coreUrlToSignalingUrl(coreUrl);
        final client = await _clientFactory(
          url: url,
          tenantId: tenantId,
          token: token,
          connectionTimeout: connectionTimeout,
          certs: trustedCertificates,
          force: true,
        );

        if (_connectToken != connectToken || _disposed) {
          // This connect was superseded by disconnect() or a newer connect() —
          // clean up the client without emitting events.
          _logger.fine('_connectAsync: stale connect discarded');
          try {
            await client.disconnect(SignalingDisconnectCode.normalClosure.code);
          } catch (e, s) {
            _logger.warning('_connectAsync stale-disconnect error', e, s);
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
        unawaited(_requestQueue.flush(execute: client.execute, isActive: () => identical(_client, client)));
      } catch (e, s) {
        if (_connectToken != connectToken || _disposed) return;
        _logger.warning('_connectAsync failed', e, s);

        final errorString = e.toString();
        final isRepeated = _lastConnectErrorString == errorString;
        _lastConnectErrorString = errorString;

        _emit(SignalingConnectionFailed(error: e, isRepeated: isRepeated, recommendedReconnectDelay: reconnectDelay));
      }
    } finally {
      // Only clear the token if this is still the active connect — a superseded
      // _connectAsync must not remove the token owned by the active one.
      if (_connectToken == connectToken) _connectToken = null;
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
    _client = null;
    _errorHandled = true;

    final errorString = error.toString();
    final isRepeated = _lastConnectErrorString == errorString;
    _lastConnectErrorString = errorString;

    _emit(SignalingConnectionFailed(error: error, isRepeated: isRepeated, recommendedReconnectDelay: reconnectDelay));
  }

  void _onDisconnect(int? code, String? reason) {
    _client = null;
    final ack = _disconnectAck;
    _disconnectAck = null;
    final wasIntentional = _intentionalDisconnect;
    _intentionalDisconnect = false;

    if (_errorHandled) {
      _errorHandled = false;
      ack?.complete();
      return;
    }

    if (!_disposed) {
      final knownCode = SignalingDisconnectCode.values.byCode(code ?? -1);
      final recommendedDelay = wasIntentional ? null : _reconnectDelay(knownCode);

      _logger.fine(
        '_onDisconnect code=$code reason=$reason knownCode=$knownCode delay=$recommendedDelay intentional=$wasIntentional',
      );

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
  /// - [Duration.zero] -- reconnect immediately (server evicted a duplicate session)
  /// - [reconnectDelay] -- standard slow reconnect
  /// - null -- do not reconnect (protocol error or intentional close)
  Duration? _reconnectDelay(SignalingDisconnectCode code) {
    if (code == SignalingDisconnectCode.controllerForceAttachClose) return Duration.zero;
    if (code == SignalingDisconnectCode.protocolError) return null;
    return reconnectDelay;
  }

  void _emit(SignalingModuleEvent event) {
    if (_controller.isClosed) return;
    _eventBuffer.onEvent(event);
    _controller.add(event);
  }
}
