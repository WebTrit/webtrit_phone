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
/// Protocol -- subscriber -> hub: [SignalingHubCommand.encode] / [SignalingHubCommand.decode].
/// Protocol -- hub -> subscriber (List): see [encodeHubEvent] / [decodeHubEvent].
class SignalingHub {
  SignalingHub(this._signalingModule);

  final SignalingModule _signalingModule;
  final ReceivePort _receivePort = ReceivePort();

  /// consumerId -> subscriber SendPort
  final Map<String, SendPort> _subscribers = {};

  /// True when at least one subscriber (from any isolate) is connected.
  ///
  /// Used by [SignalingForegroundIsolateManager] to decide whether reconnect
  /// decisions should be delegated (subscribers present — at least one isolate
  /// can drive reconnects) or handled locally in the background isolate
  /// (no subscribers — app is closed, persistent-service mode).
  bool get hasSubscribers => _subscribers.isNotEmpty;

  /// Called when [hasSubscribers] transitions (false → true or true → false).
  ///
  /// Used by [SignalingForegroundIsolateManager] in pushBound mode to detect
  /// when no subscriber remains and schedule a cleanup timer.
  void Function(bool hasSubscribers)? onHasSubscribersChanged;

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
    _receivePort.listen((msg) {
      final cmd = SignalingHubCommand.decode(msg);
      if (cmd == null) {
        _logger.warning('Hub ignoring unrecognised message: $msg');
        return;
      }
      _onCommand(cmd);
    });
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

  void _onModuleEvent(SignalingModuleEvent event) {
    if (event is SignalingConnecting) _sessionBuffer.clear();
    final encoded = encodeHubEvent(event);
    if (event is! SignalingProtocolEvent) _sessionBuffer.add(encoded);
    _broadcast(encoded);
  }

  void _broadcast(List<dynamic> encoded) {
    for (final port in _subscribers.values) {
      port.send(encoded);
    }
  }

  void _onCommand(SignalingHubCommand cmd) {
    switch (cmd) {
      case SignalingHubSubscribeCommand():
        _handleSubscribe(cmd);
      case SignalingHubUnsubscribeCommand():
        _handleUnsubscribe(cmd);
      case SignalingHubExecuteCommand():
        _handleExecute(cmd);
      case SignalingHubConnectCommand():
        if (!_subscribers.containsKey(cmd.consumerId)) {
          _logger.warning('Hub connect: unknown subscriber ${cmd.consumerId}');
          return;
        }
        _logger.fine('Hub received connect command from ${cmd.consumerId}');
        _signalingModule.connect();
      case SignalingHubDisconnectCommand():
        if (!_subscribers.containsKey(cmd.consumerId)) {
          _logger.warning('Hub disconnect: unknown subscriber ${cmd.consumerId}');
          return;
        }
        _logger.fine('Hub received disconnect command from ${cmd.consumerId}');
        unawaited(_signalingModule.disconnect());
      case SignalingHubPingCommand():
        final port = _subscribers[cmd.consumerId];
        if (port == null) {
          _logger.warning('Hub ping: unknown subscriber ${cmd.consumerId}');
          return;
        }
        port.send(encodePong());
    }
  }

  void _handleSubscribe(SignalingHubSubscribeCommand cmd) {
    final wasEmpty = _subscribers.isEmpty;
    _subscribers[cmd.consumerId] = cmd.replyPort;
    _logger.fine('Hub subscriber added: ${cmd.consumerId} (total: ${_subscribers.length})');
    if (wasEmpty) onHasSubscribersChanged?.call(true);
    // Ack first so the subscriber knows the hub port is alive (not stale).
    cmd.replyPort.send(encodeSubAck());
    // Replay current session buffer so the new subscriber gets the full state.
    for (final event in List<List<dynamic>>.from(_sessionBuffer)) {
      cmd.replyPort.send(event);
    }
  }

  void _handleUnsubscribe(SignalingHubUnsubscribeCommand cmd) {
    final wasNotEmpty = _subscribers.isNotEmpty;
    _subscribers.remove(cmd.consumerId);
    _logger.fine('Hub subscriber removed: ${cmd.consumerId} (total: ${_subscribers.length})');
    if (wasNotEmpty && _subscribers.isEmpty) onHasSubscribersChanged?.call(false);
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
