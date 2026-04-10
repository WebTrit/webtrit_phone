import 'dart:async';
import 'dart:isolate';
import 'dart:ui' show IsolateNameServer;

import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import '../constants.dart';
import 'signaling_hub_codec.dart';
import 'signaling_hub_command.dart';

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
  SignalingHubClient._({required this.consumerId, required SendPort hubPort}) : _hubPort = hubPort;

  /// Returns a [SignalingHubClient] connected to the hub, or null when no
  /// hub is currently registered in [IsolateNameServer].
  static SignalingHubClient? tryConnect(String consumerId) {
    final port = IsolateNameServer.lookupPortByName(kSignalingHubPortName);
    if (port == null) return null;
    return SignalingHubClient._(consumerId: consumerId, hubPort: port);
  }

  final String consumerId;
  final SendPort _hubPort;
  final ReceivePort _receivePort = ReceivePort();
  final _controller = StreamController<SignalingModuleEvent>.broadcast();
  final Map<String, Completer<void>> _pendingExecutions = {};

  StreamSubscription<Object?>? _subscription;
  bool _started = false;
  Completer<bool>? _subAckCompleter;

  /// Sends the subscribe command and begins forwarding hub events to [events].
  /// Safe to call more than once -- subsequent calls are no-ops.
  void start() {
    if (_started) return;
    _started = true;
    _subscription = _receivePort.listen((msg) => _onMessage(msg as List<Object?>));
    _hubPort.send(SignalingHubSubscribeCommand(consumerId: consumerId, replyPort: _receivePort.sendPort).encode());
    _logger.fine('Hub client $consumerId subscribed');
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
    _hubPort.send(SignalingHubUnsubscribeCommand(consumerId: consumerId).encode());
    await _subscription?.cancel();
    _receivePort.close();
    for (final c in _pendingExecutions.values) {
      if (!c.isCompleted) c.completeError(StateError('Hub client disposed'));
    }
    _pendingExecutions.clear();
    await _controller.close();
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
    if (isExecuteResult(msg)) {
      final (:correlationId, :error) = decodeExecuteResult(msg);
      final completer = _pendingExecutions.remove(correlationId);
      if (completer == null) return;
      if (error != null) {
        completer.completeError(Exception(error));
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

  // Slightly longer than WebtritSignalingClient's internal 10 s transaction timeout
  // so the signaling layer reports the error before this fires.
  static const _executeTimeout = Duration(seconds: 15);

  static int _counter = 0;

  static String _generateId() => (++_counter).toRadixString(16);
}
