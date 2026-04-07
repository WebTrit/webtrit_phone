import 'dart:async';
import 'dart:collection';

import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('SignalingModule');

const _queuedRequestTimeout = Duration(seconds: 30);
const _executeTimeoutRetryCount = 3;

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------

sealed class SignalingModuleEvent {}

class SignalingConnecting extends SignalingModuleEvent {}

class SignalingConnected extends SignalingModuleEvent {}

/// Initial connect attempt failed before a session was established
/// (SocketException, TlsException, DNS failure, timeout, etc.).
///
/// May be transient — consumers should apply a failure threshold before
/// surfacing a user-visible error. Reconnect delay is always
/// [kSignalingClientReconnectDelay].
class SignalingConnectionFailed extends SignalingModuleEvent {
  SignalingConnectionFailed({required this.error, required this.recommendedReconnectDelay});

  final Object error;
  final Duration recommendedReconnectDelay;
}

/// An already-established session was lost due to a runtime error.
///
/// Distinct from [SignalingConnectionFailed]: the connection reached
/// [SignalingConnected] before this error occurred. Consumers should treat
/// this as an immediate failure (no threshold needed).
/// Reconnect delay is always [kSignalingClientReconnectDelay].
class SignalingConnectionLost extends SignalingModuleEvent {
  SignalingConnectionLost({required this.error, required this.recommendedReconnectDelay});

  final Object error;
  final Duration recommendedReconnectDelay;
}

class SignalingDisconnecting extends SignalingModuleEvent {}

/// Connection closed by the server or client.
///
/// [recommendedReconnectDelay]:
///   - [Duration.zero]          - reconnect immediately (e.g. code 4441)
///   - [Duration(seconds: 3)]   - slow reconnect (default)
///   - null                     - do not reconnect (e.g. protocolError)
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
// Interface
// ---------------------------------------------------------------------------

/// Minimal interface required by [SignalingReconnectController].
///
/// Exposes only the subset of [SignalingModule] that the reconnect controller
/// needs: the event stream, connection state, and connect/disconnect commands.
/// Keeping this narrow lets the controller be tested and reused without
/// pulling in the full module contract.
abstract class SignalingReconnectable {
  /// Broadcast stream of lifecycle events ([SignalingConnected],
  /// [SignalingConnectionFailed], [SignalingConnectionLost],
  /// [SignalingDisconnected], etc.).
  Stream<SignalingModuleEvent> get events;

  /// Whether the signaling client is currently connected.
  bool get isConnected;

  /// Initiates a connection. Fire-and-forget — result arrives via [events].
  void connect();

  /// Disconnects the current client gracefully.
  Future<void> disconnect();
}

/// Contract for a signaling module used by [IsolateManager] and other consumers.
///
/// Abstracts the concrete [SignalingModuleIsolateImpl] so that the integration
/// layer can be swapped to a plugin-backed implementation without changing
/// consumers. When the webtrit_signaling_service plugin is integrated, this
/// interface will be replaced by the one from the plugin's platform-interface
/// package and this local definition removed.
abstract class SignalingModule implements SignalingReconnectable {
  /// Broadcast stream of all module lifecycle and protocol events.
  ///
  /// Each new subscriber immediately receives all lifecycle and handshake events
  /// buffered since the last [connect] call, followed by live events.
  /// [SignalingProtocolEvent] items are NOT replayed — they are delivered only
  /// to subscribers already listening when they occur.
  @override
  Stream<SignalingModuleEvent> get events;

  /// Whether the signaling client is currently connected.
  ///
  /// Returns `true` between a successful [connect] and the next [disconnect]
  /// or connection failure. Use this to guard [execute] calls.
  @override
  bool get isConnected;

  /// Initiates a connection. Fire-and-forget — returns immediately.
  ///
  /// The result arrives asynchronously via [events] as [SignalingConnected]
  /// or [SignalingConnectionFailed]. Calling [connect] when already connected
  /// or while a connection attempt is in progress is a no-op.
  @override
  void connect();

  /// Disconnects the current client gracefully.
  ///
  /// Emits [SignalingDisconnecting] immediately. [SignalingDisconnected] is
  /// emitted later once the underlying WebSocket close-ack arrives. Returns
  /// immediately — callers must not assume the connection is closed when the
  /// returned [Future] completes.
  @override
  Future<void> disconnect();

  /// Sends [request] via the active connection.
  ///
  /// When connected, the request is sent immediately.
  /// If send fails with [WebtritSignalingTransactionTimeoutException],
  /// it is retried up to 3 times.
  /// When not connected, the request is queued and sent on the next successful
  /// connection, or fails with [NotConnectedException] after 30 seconds.
  /// Returns a [Future] that completes when the request has been written to
  /// the transport.
  Future<void>? execute(Request request);

  /// Disconnects and closes the event stream.
  ///
  /// After [dispose] the module must not be used. Awaiting [dispose] gives
  /// [SignalingDisconnected] time to be emitted before the stream closes.
  Future<void> dispose();
}

// ---------------------------------------------------------------------------
// Module
// ---------------------------------------------------------------------------

/// Manages a single [WebtritSignalingClient] lifecycle and publishes typed
/// events via a broadcast stream.
///
/// Knows only the WebSocket protocol - nothing about [CallState], BLoC, emit,
/// notifications, or app lifecycle. Can be used in the main isolate, a
/// background isolate, or an integration test without any UI dependency.
class SignalingModuleIsolateImpl implements SignalingModule {
  SignalingModuleIsolateImpl({
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

  // sync: true ensures events are delivered to existing listeners in the same
  // call stack as _emit(), preserving ordering and eliminating async-dispatch
  // races where a late-arriving broadcast event could duplicate a replayed one.
  //
  // Reentrancy assumption: consumers must not call connect() or disconnect()
  // synchronously inside an event listener. Doing so would re-enter _emit()
  // in the same stack frame and produce unexpected ordering. All current
  // consumers (CallBloc.add(), IsolateManager timer callbacks) satisfy this -
  // they either queue events or schedule via Timer, never calling back directly.
  final _controller = StreamController<SignalingModuleEvent>.broadcast(sync: true);

  /// Events buffered since the last [connect] call. Cleared on every [connect]
  /// so that late subscribers receive only the current session's events.
  final List<SignalingModuleEvent> _sessionBuffer = [];
  final Queue<_QueuedRequest> _queuedRequests = Queue<_QueuedRequest>();

  WebtritSignalingClient? _client;
  bool _disposed = false;
  bool _connecting = false;

  /// Completer resolved by [_onDisconnect] after a graceful [disconnect] call.
  /// [dispose] awaits it (with timeout) before closing the controller so that
  /// [SignalingDisconnected] is emitted before the stream closes.
  Completer<void>? _disconnectAck;

  /// Set to true by [disconnect] so that [_onDisconnect] emits
  /// [SignalingDisconnected] with [recommendedReconnectDelay] = null,
  /// preventing consumers from scheduling a spurious reconnect after an
  /// intentional close (e.g. when the foreground isolate takes over).
  bool _intentionalDisconnect = false;

  /// Set to true by [_onError] so that the subsequent [_onDisconnect] callback
  /// (which fires when the underlying socket closes after an error) is
  /// suppressed - [_onError] already emits [SignalingConnectionLost] and
  /// consumers would otherwise receive two separate reconnect triggers.
  ///
  /// Ordering invariant: [_onDisconnect] for the failed socket always arrives
  /// before any reconnect-triggered [_connectAsync] completes, because reconnect
  /// is scheduled via [kSignalingClientReconnectDelay] (several seconds) while
  /// the socket close-ack is delivered in the current event loop iteration.
  /// [_onDisconnect] resets this flag to false, so a newly connected client
  /// starts with a clean state.
  bool _errorHandled = false;

  /// Broadcast stream of all module events.
  ///
  /// Each new subscriber immediately receives all lifecycle and handshake events
  /// buffered since the last [connect] call (e.g. [SignalingConnecting],
  /// [SignalingConnected], [SignalingHandshakeReceived]), followed by live events.
  /// This allows [SignalingModuleIsolateImpl] to be connected before [CallBloc] (or any
  /// other consumer) is created without missing session state.
  ///
  /// Note: [SignalingProtocolEvent] (call events) are NOT replayed - they are
  /// only delivered to subscribers already listening when they occur.
  ///
  /// Each call to [events] creates a new independent stream backed by a
  /// dedicated [StreamController] and a live subscription to the internal
  /// broadcast controller. Call [events] exactly once per consumer and hold
  /// the returned [StreamSubscription] for the consumer's lifetime; calling
  /// it multiple times without cancelling previous subscriptions leaks
  /// controllers.
  @override
  Stream<SignalingModuleEvent> get events {
    // Take a snapshot of the buffer BEFORE subscribing to the live stream so
    // that any event arriving between snapshot and subscribe is delivered only
    // via the live subscription and never replayed - preventing duplicates.
    final snapshot = List<SignalingModuleEvent>.of(_sessionBuffer);

    // sync: true so that events emitted via _controller.add() are forwarded
    // to the subscriber in the same stack frame, preserving ordering and
    // removing the extra async hop that would otherwise cause events to
    // arrive after an await returns.
    final liveController = StreamController<SignalingModuleEvent>(sync: true);
    // Subscribe to the live broadcast stream after the snapshot so no future
    // events are missed.
    final liveSub = _controller.stream.listen(
      liveController.add,
      onError: liveController.addError,
      onDone: liveController.close,
    );
    liveController.onCancel = () async {
      await liveSub.cancel();
      if (!liveController.isClosed) await liveController.close();
    };
    // Replay only the snapshot - events that arrived after the snapshot are
    // already in the live subscription queue and must not be replayed.
    for (final event in snapshot) {
      liveController.add(event);
    }
    return liveController.stream;
  }

  /// Direct access to the connected client for sending requests
  /// (e.g. [HangupRequest], [AcceptRequest], [OutgoingCallRequest]).
  /// Null when not connected.
  WebtritSignalingClient? get signalingClient => _client;

  @override
  bool get isConnected => _client != null;

  @override
  Future<void>? execute(Request request) {
    final client = _client;
    if (client != null) return _executeWithRetry(client, request);
    return _enqueueRequest(request);
  }

  /// Initiates a connection. Fire-and-forget - returns immediately.
  /// The result arrives via [events] as [SignalingConnected] or
  /// [SignalingConnectionFailed].
  ///
  /// Clears the session buffer so that late subscribers receive only events
  /// from the current session, not stale events from a previous one.
  @override
  void connect() {
    if (_disposed || _connecting) return;
    _sessionBuffer.clear();
    unawaited(_connectAsync());
  }

  /// Disconnects the current client gracefully. Emits [SignalingDisconnecting]
  /// immediately and returns. [SignalingDisconnected] is emitted later,
  /// asynchronously, only when the underlying WebSocket close-ack arrives via
  /// the [_onDisconnect] callback - it is NOT guaranteed to arrive before this
  /// Future completes.
  @override
  Future<void> disconnect() async {
    final client = _client;
    if (client == null) return;
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

  /// Disconnects and closes the event stream. After [dispose], the module
  /// must not be used.
  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _failAllQueuedRequests(NotConnectedException('Signaling module is disposed'));
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
            await client.disconnect(SignalingDisconnectCode.normalClosure.code);
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
        _emit(SignalingConnected());
        unawaited(_flushQueuedRequests(client));
      } catch (e, s) {
        if (_disposed) return;
        _logger.warning('_connectAsync failed', e, s);

        _emit(SignalingConnectionFailed(error: e, recommendedReconnectDelay: kSignalingClientReconnectDelay));
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
    // Drop the client reference - the connection is broken.
    // The consumer is responsible for scheduling a reconnect.
    _client = null;
    // Mark that we are handling this failure so that the subsequent
    // _onDisconnect callback (socket close after error) is suppressed.
    _errorHandled = true;

    _emit(SignalingConnectionLost(error: error, recommendedReconnectDelay: kSignalingClientReconnectDelay));
  }

  void _onDisconnect(int? code, String? reason) {
    _client = null;
    final ack = _disconnectAck;
    _disconnectAck = null;
    final wasIntentional = _intentionalDisconnect;
    _intentionalDisconnect = false;

    // _onError already emitted SignalingConnectionLost for this connection
    // failure. Skip SignalingDisconnected to avoid a double reconnect trigger.
    if (_errorHandled) {
      _errorHandled = false;
      ack?.complete();
      return;
    }

    if (!_disposed) {
      final knownCode = SignalingDisconnectCode.values.byCode(code ?? -1);
      // Suppress reconnect hint for intentional disconnects so consumers do not
      // schedule a spurious reconnect (e.g. foreground isolate taking over).
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

  Future<void> _enqueueRequest(Request request) {
    final completer = Completer<void>();
    late final _QueuedRequest queuedRequest;
    final timer = Timer(_queuedRequestTimeout, () => _onQueuedRequestTimeout(queuedRequest));
    queuedRequest = _QueuedRequest(request: request, completer: completer, timer: timer);
    _queuedRequests.add(queuedRequest);
    return completer.future;
  }

  Future<void> _flushQueuedRequests(WebtritSignalingClient client) async {
    while (_queuedRequests.isNotEmpty && identical(_client, client)) {
      final queuedRequest = _queuedRequests.first;
      try {
        await _executeWithRetry(client, queuedRequest.request);
        _queuedRequests.removeFirst();
        queuedRequest.timer.cancel();
        if (!queuedRequest.completer.isCompleted) queuedRequest.completer.complete();
      } catch (error, stackTrace) {
        if (!identical(_client, client)) return;
        _queuedRequests.removeFirst();
        queuedRequest.timer.cancel();
        if (!queuedRequest.completer.isCompleted) {
          queuedRequest.completer.completeError(error, stackTrace);
        }
      }
    }
  }

  Future<void> _executeWithRetry(WebtritSignalingClient client, Request request, [int timeoutRetry = 0]) async {
    try {
      await client.execute(request);
    } on WebtritSignalingTransactionTimeoutException catch (error, stackTrace) {
      if (!identical(_client, client) || timeoutRetry >= _executeTimeoutRetryCount) {
        Error.throwWithStackTrace(error, stackTrace);
      }
      _logger.warning('_executeWithRetry timeout, retrying... (retry #$timeoutRetry)', error, stackTrace);
      return _executeWithRetry(client, request, timeoutRetry + 1);
    }
  }

  void _onQueuedRequestTimeout(_QueuedRequest queuedRequest) {
    if (!_queuedRequests.remove(queuedRequest)) return;
    if (!queuedRequest.completer.isCompleted) {
      queuedRequest.completer.completeError(
        NotConnectedException('Timeout waiting for signaling connection to send request: ${queuedRequest.request}'),
      );
    }
  }

  void _failAllQueuedRequests(Object error) {
    while (_queuedRequests.isNotEmpty) {
      final queuedRequest = _queuedRequests.removeFirst();
      queuedRequest.timer.cancel();
      if (!queuedRequest.completer.isCompleted) queuedRequest.completer.completeError(error);
    }
  }

  /// Maps a disconnect code to the recommended reconnect delay.
  ///
  /// - [Duration.zero] - reconnect immediately (server evicted a duplicate session)
  /// - [kSignalingClientReconnectDelay] - standard slow reconnect
  /// - null - do not reconnect (protocol-level error or intentional close)
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
    // Protocol events are transient (IncomingCallEvent, HangupEvent, etc.) and
    // carry no persistent state that a late subscriber needs to reconstruct the
    // current session. Buffering them causes the replay list to grow without
    // bound in long sessions. Only lifecycle and handshake events are buffered.
    if (event is! SignalingProtocolEvent) {
      _sessionBuffer.add(event);
    }
    _controller.add(event);
  }
}

class NotConnectedException implements Exception {
  NotConnectedException([this.message = 'Signaling client is not connected']);

  final String message;

  @override
  String toString() => 'NotConnectedException: $message';
}

class _QueuedRequest {
  _QueuedRequest({required this.request, required this.completer, required this.timer});

  final Request request;
  final Completer<void> completer;
  final Timer timer;
}
