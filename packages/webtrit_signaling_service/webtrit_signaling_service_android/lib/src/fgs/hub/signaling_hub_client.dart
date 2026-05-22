import 'dart:async';
import 'dart:isolate';
import 'dart:ui' show IsolateNameServer;

import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import '../../constants.dart';
import 'signaling_hub_codec.dart';
import 'signaling_hub_command.dart';

// The hub execute timeout must cover the full _executeWithRetry budget:
// transactionTimeout × (maxRetryCount + 1) + a small overhead buffer.
// This ensures the hub timeout only fires when the background isolate stops
// responding entirely (hub death), not during a normal retry cycle.
Duration _defaultHubExecuteTimeout({
  Duration transactionTimeout = WebtritSignalingClient.defaultExecuteTransactionTimeoutDuration,
  int maxRetryCount = SignalingRequestQueue.defaultMaxRetryCount,
}) => transactionTimeout * (maxRetryCount + 1) + const Duration(seconds: 5);

final _logger = Logger('SignalingHubClient');

/// Client-side counterpart of [SignalingHub].
///
/// Used by the push notification isolate when a [SignalingHub] is running
/// in the foreground service isolate. Provides the same [Stream] of
/// [SignalingModuleEvent]s and an [execute] path that routes requests through
/// the hub's WebSocket -- so no extra WebSocket is opened.
///
/// Typical usage:
/// ```dart
/// final client = SignalingHubClient.tryConnect('push_${hashCode}');
/// if (client != null) {
///   final ackFuture = client.awaitAck(); // get future BEFORE start()
///   client.start();                      // sends SignalingHubSubscribeCommand -> hub replies with ack
///   final ackReceived = await ackFuture;
///   if (!ackReceived) await client.dispose();
/// }
/// ```
class SignalingHubClient {
  SignalingHubClient._({
    required this.consumerId,
    required SendPort hubPort,
    required Duration pingInterval,
    required Duration pongTimeout,
    required Duration executeTimeout,
  }) : _hubPort = hubPort,
       _pingInterval = pingInterval,
       _pongTimeout = pongTimeout,
       _executeTimeout = executeTimeout;

  /// Returns a [SignalingHubClient] connected to the hub, or null when no
  /// hub is currently registered in [IsolateNameServer].
  static SignalingHubClient? tryConnect(
    String consumerId, {
    Duration pingInterval = const Duration(seconds: 15),
    Duration pongTimeout = const Duration(seconds: 2),
    Duration? executeTimeout,
  }) {
    final port = IsolateNameServer.lookupPortByName(kSignalingHubPortName);
    if (port == null) return null;
    return SignalingHubClient._(
      consumerId: consumerId,
      hubPort: port,
      pingInterval: pingInterval,
      pongTimeout: pongTimeout,
      executeTimeout: executeTimeout ?? _defaultHubExecuteTimeout(),
    );
  }

  final String consumerId;
  final SendPort _hubPort;
  final Duration _pingInterval;
  final Duration _pongTimeout;
  final Duration _executeTimeout;
  final ReceivePort _receivePort = ReceivePort();
  final _controller = StreamController<SignalingModuleEvent>.broadcast();
  final Map<String, Completer<void>> _pendingExecutions = {};

  StreamSubscription<Object?>? _subscription;
  bool _started = false;
  Completer<bool>? _subAckCompleter;
  Timer? _pingTimer;
  Completer<void>? _pendingPong;

  /// Sends the subscribe command and begins forwarding hub events to [events].
  /// Safe to call more than once -- subsequent calls are no-ops.
  ///
  /// Also starts a periodic liveness ping. If the hub does not reply within
  /// [_pongTimeout] the client closes [events], signalling hub death to
  /// [HubConnectionManager] via its [onDone] handler.
  void start() {
    if (_started) return;
    _started = true;
    _subscription = _receivePort.listen((msg) => _onMessage(msg as List<Object?>));
    _hubPort.send(SignalingHubSubscribeCommand(consumerId: consumerId, replyPort: _receivePort.sendPort).encode());
    _logger.fine('Hub client $consumerId subscribed');
    _schedulePing();
  }

  void _schedulePing() {
    _pingTimer?.cancel();
    _pingTimer = Timer(_pingInterval, _sendPing);
  }

  void _sendPing() {
    if (_controller.isClosed) return;
    _logger.fine('Hub client $consumerId sending ping (interval=$_pingInterval pongTimeout=$_pongTimeout)');
    _pendingPong = Completer<void>();
    _hubPort.send(SignalingHubPingCommand(consumerId: consumerId).encode());
    _pendingPong!.future
        .timeout(_pongTimeout)
        .then((_) {
          _logger.fine('Hub client $consumerId pong received — hub alive');
          _schedulePing();
        })
        .catchError((_) {
          _logger.warning('Hub client $consumerId pong timeout after $_pongTimeout — hub unreachable, closing stream');
          _pingTimer?.cancel();
          _pendingPong = null;
          if (!_controller.isClosed) _controller.close();
        });
  }

  /// Returns [true] when the hub confirms subscription within [timeout],
  /// or [false] if the port is stale and no ack arrives.
  ///
  /// Must be called before [start] so the completer is in place before the
  /// ack message can arrive.
  Future<bool> awaitAck({Duration timeout = const Duration(milliseconds: 500)}) {
    _subAckCompleter = Completer<bool>();
    return _subAckCompleter!.future.timeout(timeout, onTimeout: () => false);
  }

  /// Stream of [SignalingModuleEvent]s forwarded from the hub.
  Stream<SignalingModuleEvent> get events => _controller.stream;

  /// Routes a [Request] through the hub's WebSocket connection.
  ///
  /// Throws [TimeoutException] if no reply arrives within [_executeTimeout].
  /// This handles the edge case where the subscriber unsubscribes between
  /// sending the exec command and the hub sending a reply -- without a timeout
  /// the completer would hang indefinitely.
  Future<void> execute(Request request) {
    final corrId = _generateId();
    final completer = Completer<void>();
    _pendingExecutions[corrId] = completer;
    _hubPort.send(
      SignalingHubExecuteCommand(consumerId: consumerId, correlationId: corrId, request: request.toJson()).encode(),
    );
    return completer.future.timeout(
      _executeTimeout,
      onTimeout: () {
        _pendingExecutions.remove(corrId);
        throw TimeoutException('Hub execute timed out for corr=$corrId', _executeTimeout);
      },
    );
  }

  /// Asks the hub to connect the background WebSocket.
  ///
  /// Fire-and-forget: the hub will call [SignalingModule.connect] in the
  /// background isolate. The resulting [SignalingConnected] event will arrive
  /// on [events] once the connection is established.
  void sendConnect() {
    _hubPort.send(SignalingHubConnectCommand(consumerId: consumerId).encode());
  }

  /// Asks the hub to disconnect the background WebSocket.
  ///
  /// Fire-and-forget: the hub will call [SignalingModule.disconnect] in the
  /// background isolate. The resulting [SignalingDisconnected] event will arrive
  /// on [events] once the connection is closed.
  void sendDisconnect() {
    _hubPort.send(SignalingHubDisconnectCommand(consumerId: consumerId).encode());
  }

  /// Sends the unsubscribe command and closes all resources.
  Future<void> dispose() async {
    _pingTimer?.cancel();
    _pingTimer = null;
    _pendingPong = null;
    _hubPort.send(SignalingHubUnsubscribeCommand(consumerId: consumerId).encode());
    await _subscription?.cancel();
    _receivePort.close();
    for (final c in _pendingExecutions.values) {
      if (!c.isCompleted) c.completeError(StateError('Hub client disposed'));
    }
    _pendingExecutions.clear();
    if (!_controller.isClosed) await _controller.close();
    _logger.fine('Hub client $consumerId disposed');
  }

  void _onMessage(List<Object?> msg) {
    if (msg.isEmpty) return;
    if (isSubAck(msg)) {
      final completer = _subAckCompleter;
      _subAckCompleter = null;
      if (completer != null && !completer.isCompleted) completer.complete(true);
      return;
    }
    if (isPong(msg)) {
      final completer = _pendingPong;
      _pendingPong = null;
      if (completer != null && !completer.isCompleted) completer.complete();
      return;
    }
    if (isExecuteResult(msg)) {
      final (:correlationId, :error) = decodeExecuteResult(msg);
      final completer = _pendingExecutions.remove(correlationId);
      if (completer == null) return;
      if (error != null) {
        completer.completeError(error);
      } else {
        completer.complete();
      }
      return;
    }
    final event = decodeHubEvent(msg);
    if (event != null && !_controller.isClosed) {
      _controller.add(event);
    }
  }

  static int _counter = 0;

  static String _generateId() => (++_counter).toRadixString(16);
}
