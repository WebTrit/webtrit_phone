import 'dart:async';
import 'dart:isolate';
import 'dart:ui' show IsolateNameServer;

import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import '../constants.dart';
import 'signaling_hub_codec.dart';
import 'signaling_hub_command.dart';

final _logger = Logger('SignalingHub');

/// Wraps a [SignalingModule] and exposes its event stream to other isolates
/// via [IsolateNameServer].
///
/// [SignalingForegroundIsolateManager] creates and owns one hub instance.
/// Any isolate (e.g. push notification isolate) can subscribe by looking up
/// [kSignalingHubPortName] via [IsolateNameServer].
///
/// Protocol -- subscriber -> hub (Map):
///   {cmd:'sub',  id:consumerId, port:SendPort}
///   {cmd:'unsub', id:consumerId}
///   {cmd:'exec',  id:consumerId, corr:correlationId, req:Map}
///
/// Protocol -- hub -> subscriber (List):
///   See [encodeHubEvent] / [decodeHubEvent] in signaling_hub_codec.dart.
///   Execute results use [encodeExecuteResult].
class SignalingHub {
  SignalingHub(this._signalingModule);

  final SignalingModule _signalingModule;
  final ReceivePort _receivePort = ReceivePort();

  /// consumerId -> subscriber SendPort
  final Map<String, SendPort> _subscribers = {};

  /// Encoded events since the last [SignalingConnecting] event.
  /// Replayed to late subscribers so they receive the current session state.
  final List<List<dynamic>> _sessionBuffer = [];

  StreamSubscription<SignalingModuleEvent>? _moduleSubscription;
  bool _started = false;

  /// Registers the hub port in [IsolateNameServer] and begins forwarding
  /// [SignalingModule] events to subscribers.
  ///
  /// Calling [start] more than once is a no-op.
  void start() {
    if (_started) return;
    _started = true;

    // Remove any stale mapping from a previous isolate that was destroyed without
    // calling dispose() -- registerPortWithName returns false (silently no-ops)
    // when the name is already taken, so we clear it first.
    IsolateNameServer.removePortNameMapping(kSignalingHubPortName);
    IsolateNameServer.registerPortWithName(_receivePort.sendPort, kSignalingHubPortName);
    _logger.fine('Hub started and registered as $kSignalingHubPortName');

    _moduleSubscription = _signalingModule.events.listen(_onModuleEvent);
    _receivePort.listen(_onCommand);
  }

  /// Removes the hub from [IsolateNameServer], cancels all subscriptions,
  /// and closes the receive port. After [dispose] the hub must not be used.
  Future<void> dispose() async {
    IsolateNameServer.removePortNameMapping(kSignalingHubPortName);
    await _moduleSubscription?.cancel();
    _receivePort.close();
    _subscribers.clear();
    _sessionBuffer.clear();
    _logger.fine('Hub disposed');
  }

  // ---------------------------------------------------------------------------
  // Module event forwarding
  // ---------------------------------------------------------------------------

  void _onModuleEvent(SignalingModuleEvent event) {
    if (event is SignalingConnecting) _sessionBuffer.clear();
    final encoded = encodeHubEvent(event);
    if (encoded == null) return;
    if (event is! SignalingProtocolEvent) _sessionBuffer.add(encoded);
    _broadcast(encoded);
  }

  void _broadcast(List<dynamic> encoded) {
    for (final port in _subscribers.values) {
      port.send(encoded);
    }
  }

  // ---------------------------------------------------------------------------
  // Command handling
  // ---------------------------------------------------------------------------

  void _onCommand(dynamic msg) {
    if (msg is! SignalingHubCommand) return;
    switch (msg) {
      case SignalingHubSubscribeCommand():
        _handleSubscribe(msg);
      case SignalingHubUnsubscribeCommand():
        _handleUnsubscribe(msg);
      case SignalingHubExecuteCommand():
        _handleExecute(msg);
    }
  }

  void _handleSubscribe(SignalingHubSubscribeCommand cmd) {
    _subscribers[cmd.consumerId] = cmd.replyPort;
    _logger.fine('Hub subscriber added: ${cmd.consumerId} (total: ${_subscribers.length})');
    // Ack first so the subscriber knows the hub port is alive (not stale).
    cmd.replyPort.send(encodeSubAck());
    // Replay current session buffer so the new subscriber gets the full state.
    for (final event in List<List<dynamic>>.from(_sessionBuffer)) {
      cmd.replyPort.send(event);
    }
  }

  void _handleUnsubscribe(SignalingHubUnsubscribeCommand cmd) {
    _subscribers.remove(cmd.consumerId);
    _logger.fine('Hub subscriber removed: ${cmd.consumerId} (total: ${_subscribers.length})');
  }

  void _handleExecute(SignalingHubExecuteCommand cmd) {
    final port = _subscribers[cmd.consumerId];
    if (port == null) {
      _logger.warning('Hub execute: unknown subscriber ${cmd.consumerId}, corr=${cmd.correlationId}');
      return;
    }
    unawaited(_executeAndReply(port, cmd.correlationId, cmd.request));
  }

  Future<void> _executeAndReply(SendPort replyPort, String correlationId, Map<String, dynamic> reqMap) async {
    try {
      final request = Request.fromJson(reqMap);
      if (!_signalingModule.isConnected) throw StateError('Signaling not connected');
      await _signalingModule.execute(request)!;
      replyPort.send(encodeExecuteResult(correlationId, null));
    } catch (e) {
      _logger.warning('Hub execute error: $e, corr=$correlationId');
      replyPort.send(encodeExecuteResult(correlationId, e));
    }
  }
}
