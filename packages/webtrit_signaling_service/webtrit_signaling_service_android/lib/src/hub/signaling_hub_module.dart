import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'signaling_hub_client.dart';

final _logger = Logger('SignalingHubModule');

/// [SignalingModule] implementation backed by a [SignalingHubClient].
///
/// Used by the main isolate when [SignalingHub] is already running in the
/// foreground-service isolate. Routes all execute calls through the hub's
/// WebSocket rather than opening an additional connection.
///
/// [connect] sends a [SignalingHubConnectCommand] to the foreground-service
/// isolate, which calls [SignalingModule.connect] on the real WebSocket module.
/// [disconnect] sends a [SignalingHubDisconnectCommand] similarly.
/// [dispose] unsubscribes from the hub and releases resources.
///
/// ## Two-level buffering
///
/// [SignalingHub] holds a session buffer and replays it to each new
/// [SignalingHubClient] on subscribe (isolate-boundary replay). This module
/// holds a second [SignalingEventBuffer] for same-isolate consumers of
/// [events]: a caller may subscribe to [events] after the hub's replay has
/// already been forwarded through [_hubClient], so the local buffer is
/// needed to serve those late subscribers.
///
/// Both buffers apply identical rules (cleared on [SignalingConnecting],
/// [SignalingProtocolEvent] items never included) and receive events in the
/// same order, so they cannot diverge.
class SignalingHubModule implements SignalingModule {
  SignalingHubModule(this._hubClient) {
    _sub = _hubClient.events.listen(_onHubEvent);
    _hubClient.start();
    _logger.fine('SignalingHubModule created, consumerId=${_hubClient.consumerId}');
  }

  final SignalingHubClient _hubClient;

  bool _connected = false;
  StreamSubscription<SignalingModuleEvent>? _sub;

  final _eventBuffer = SignalingEventBuffer();
  final _controller = StreamController<SignalingModuleEvent>.broadcast();

  @override
  Stream<SignalingModuleEvent> get events {
    return Stream.multi((sink) {
      final sub = _controller.stream.listen(sink.add, onError: sink.addError, onDone: sink.close);
      sink.onCancel = sub.cancel;
      for (final event in _eventBuffer.snapshot) {
        sink.add(event);
      }
    }, isBroadcast: true);
  }

  @override
  bool get isConnected => _connected;

  @override
  Future<void>? execute(Request request) {
    // DEBUG: log state at the moment execute is called on the main-isolate side
    _logger.info('SignalingHubModule execute: request=${request.runtimeType} _connected=$_connected');
    if (!_connected) return null;
    return _hubClient.execute(request);
  }

  /// Asks the hub to connect the background WebSocket.
  ///
  /// Sends a [SignalingHubConnectCommand] to the foreground-service isolate,
  /// which calls [SignalingModule.connect] on the real WebSocket module.
  /// The resulting [SignalingConnected] event arrives on [events] once the
  /// connection is established.
  @override
  void connect() => _hubClient.sendConnect();

  /// Asks the hub to disconnect the background WebSocket.
  ///
  /// Sends a [SignalingHubDisconnectCommand] to the foreground-service isolate,
  /// which calls [SignalingModule.disconnect] on the real WebSocket module.
  /// The resulting [SignalingDisconnected] event arrives on [events].
  @override
  Future<void> disconnect() async => _hubClient.sendDisconnect();

  /// No-op: [SignalingHubModule] routes requests directly through the hub
  /// WebSocket without a local queue, so there is nothing to cancel.
  @override
  void cancelRequestsByCallId(String callId) {}

  /// No-op: [SignalingHubModule] has no local request queue and therefore no
  /// terminating marks to clear.
  @override
  void clearTerminatingMark(String callId) {}

  @override
  Future<void> dispose() async {
    await _sub?.cancel();
    await _hubClient.dispose();
    await _controller.close();
    _eventBuffer.clear();
    _logger.fine('SignalingHubModule disposed');
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  void _onHubEvent(SignalingModuleEvent event) {
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
    _eventBuffer.onEvent(event);
    _controller.add(event);
  }
}
