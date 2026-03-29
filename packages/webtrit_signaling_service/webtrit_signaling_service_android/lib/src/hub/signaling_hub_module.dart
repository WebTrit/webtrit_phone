import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'signaling_hub_client.dart';

final _logger = Logger('SignalingHubModule');

/// [SignalingModuleInterface] implementation backed by a [SignalingHubClient].
///
/// Used by the main isolate when [SignalingHub] is already running in the
/// foreground-service isolate. Routes all execute calls through the hub's
/// WebSocket rather than opening an additional connection.
///
/// [connect] and [disconnect] are no-ops -- the hub owns the connection
/// lifecycle. [dispose] unsubscribes from the hub and releases resources.
class SignalingHubModule implements SignalingModuleInterface {
  SignalingHubModule(this._hubClient) {
    _sub = _hubClient.events.listen(_onHubEvent);
    _hubClient.start();
    _logger.fine('SignalingHubModule created, consumerId=${_hubClient.consumerId}');
  }

  final SignalingHubClient _hubClient;

  bool _connected = false;
  StreamSubscription<SignalingModuleEvent>? _sub;

  final _sessionBuffer = <SignalingModuleEvent>[];
  final _controller = StreamController<SignalingModuleEvent>.broadcast();

  @override
  Stream<SignalingModuleEvent> get events {
    final liveController = StreamController<SignalingModuleEvent>(sync: true);
    final liveSub = _controller.stream.listen(
      liveController.add,
      onError: liveController.addError,
      onDone: liveController.close,
    );
    liveController.onCancel = liveSub.cancel;
    for (final event in List<SignalingModuleEvent>.of(_sessionBuffer)) {
      liveController.add(event);
    }
    return liveController.stream;
  }

  @override
  bool get isConnected => _connected;

  @override
  Future<void>? execute(Request request) {
    if (!_connected) return null;
    return _hubClient.execute(request);
  }

  /// No-op -- the hub owns the WebSocket connection lifecycle.
  @override
  void connect() {}

  /// No-op -- the hub owns the WebSocket connection lifecycle.
  @override
  Future<void> disconnect() async {}

  @override
  Future<void> dispose() async {
    await _sub?.cancel();
    await _hubClient.dispose();
    await _controller.close();
    _sessionBuffer.clear();
    _logger.fine('SignalingHubModule disposed');
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  void _onHubEvent(SignalingModuleEvent event) {
    if (event is SignalingConnecting) _sessionBuffer.clear();

    switch (event) {
      case SignalingConnected():
        _connected = true;
        _logger.info('hub event: connected');
      case SignalingDisconnected(:final code, :final reason):
        _connected = false;
        _logger.info('hub event: disconnected code=$code reason=$reason');
      case SignalingConnectionFailed(:final error, :final isRepeated):
        _connected = false;
        _logger.warning('hub event: connection failed isRepeated=$isRepeated -- $error');
      case SignalingHandshakeReceived(:final handshake):
        _logger.info('hub event: handshake lines=${handshake.lines}');
      case SignalingProtocolEvent(:final event):
        _logger.fine('hub event: protocol ${event.runtimeType}');
      default:
        _logger.fine('hub event: ${event.runtimeType}');
    }

    if (_controller.isClosed) return;
    _sessionBuffer.add(event);
    _controller.add(event);
  }
}
