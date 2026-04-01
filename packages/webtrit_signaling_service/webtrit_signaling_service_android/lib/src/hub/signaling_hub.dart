import 'dart:async';
import 'dart:isolate';
import 'dart:ui' show IsolateNameServer;

import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import '../constants.dart';
import 'signaling_hub_codec.dart';

final _logger = Logger('SignalingHub');

/// Wraps a [SignalingModuleInterface] and exposes its event stream to other isolates
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

  final SignalingModuleInterface _signalingModule;
  final ReceivePort _receivePort = ReceivePort();

  /// consumerId -> subscriber SendPort
  final Map<String, SendPort> _subscribers = {};

  /// Encoded events since the last [SignalingConnecting] event.
  /// Replayed to late subscribers so they receive the current session state.
  final List<List<dynamic>> _sessionBuffer = [];

  StreamSubscription<SignalingModuleEvent>? _moduleSubscription;
  bool _started = false;

  /// Registers the hub port in [IsolateNameServer] and begins forwarding
  /// [SignalingModuleInterface] events to subscribers.
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
    _sessionBuffer.add(encoded);
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
    if (msg is! Map) return;
    final cmd = msg['cmd'] as String?;
    switch (cmd) {
      case 'sub':
        _handleSubscribe(msg);
      case 'unsub':
        _handleUnsubscribe(msg);
      case 'exec':
        _handleExecute(msg);
    }
  }

  void _handleSubscribe(Map<dynamic, dynamic> msg) {
    final id = msg['id'] as String;
    final port = msg['port'] as SendPort;
    _subscribers[id] = port;
    _logger.fine('Hub subscriber added: $id (total: ${_subscribers.length})');
    // Ack first so the subscriber knows the hub port is alive (not stale).
    port.send(encodeSubAck());
    // Replay current session buffer so the new subscriber gets the full state.
    for (final event in List<List<dynamic>>.from(_sessionBuffer)) {
      port.send(event);
    }
  }

  void _handleUnsubscribe(Map<dynamic, dynamic> msg) {
    final id = msg['id'] as String;
    _subscribers.remove(id);
    _logger.fine('Hub subscriber removed: $id (total: ${_subscribers.length})');
  }

  void _handleExecute(Map<dynamic, dynamic> msg) {
    final id = msg['id'] as String;
    final corr = msg['corr'] as String;
    final reqMap = msg['req'] as Map;
    final port = _subscribers[id];
    if (port == null) {
      _logger.warning('Hub execute: unknown subscriber $id, corr=$corr');
      return;
    }
    unawaited(_executeAndReply(port, corr, reqMap));
  }

  Future<void> _executeAndReply(SendPort replyPort, String correlationId, Map<dynamic, dynamic> reqMap) async {
    try {
      final request = Request.fromJson(Map<String, dynamic>.from(reqMap));
      if (!_signalingModule.isConnected) throw StateError('Signaling not connected');
      await _signalingModule.execute(request);
      replyPort.send(encodeExecuteResult(correlationId, null));
    } catch (e) {
      _logger.warning('Hub execute error: $e, corr=$correlationId');
      replyPort.send(encodeExecuteResult(correlationId, e));
    }
  }
}
