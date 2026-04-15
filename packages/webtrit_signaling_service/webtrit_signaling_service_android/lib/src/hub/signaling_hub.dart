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

  /// Encoded non-protocol events since the last [SignalingConnecting] event.
  ///
  /// Replayed to late subscribers so they receive the current connection state
  /// ([SignalingConnecting], [SignalingConnected], [SignalingHandshakeReceived]).
  ///
  /// Protocol events ([SignalingProtocolEvent]) are intentionally excluded:
  /// call-level events are tracked separately in [_callEventHistory] so that
  /// ended calls can be evicted in O(1) without scanning this list. Storing
  /// all protocol events here would require decoding each entry on eviction
  /// and would cause the buffer to grow unboundedly over a long session.
  final List<List<dynamic>> _sessionBuffer = [];

  /// callId → ordered list of encoded [SignalingProtocolEvent]s for that call.
  ///
  /// Tracks the lifecycle of each incoming call that arrived during the current
  /// WebSocket session so that late subscribers (e.g. the Activity opening
  /// after a push-notification isolate has already processed the call) receive
  /// the full event sequence and can reconstruct the correct current state.
  ///
  /// Without this map a subscriber that opens after [AcceptedEvent] would only
  /// receive [IncomingCallEvent] replayed from [_sessionBuffer] and incorrectly
  /// treat an already-answered call as still ringing.
  ///
  /// Lifecycle:
  /// - [IncomingCallEvent] → new entry created for callId.
  /// - Subsequent [CallEvent]s (e.g. [AcceptedEvent], [RingingEvent]) → appended.
  /// - Terminal events ([HangupEvent], [MissedCallEvent]) → entry removed;
  ///   the dead call's line is also evicted from the buffered handshake.
  /// - [SignalingConnecting] → entire map cleared (new session).
  final Map<String, List<List<dynamic>>> _callEventHistory = {};

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
    _callEventHistory.clear();
    _logger.fine('Hub disposed');
  }

  void _onModuleEvent(SignalingModuleEvent event) {
    if (event is SignalingConnecting) {
      _sessionBuffer.clear();
      _callEventHistory.clear();
    }
    final encoded = encodeHubEvent(event);
    if (event is! SignalingProtocolEvent) {
      _sessionBuffer.add(encoded);
    } else {
      _updateCallHistory(event.event, encoded);
    }
    _broadcast(encoded);
  }

  /// Updates [_callEventHistory] based on a protocol event.
  ///
  /// - [IncomingCallEvent]: starts a new history entry for that callId.
  /// - Subsequent [CallEvent]s: appended to the existing history so that late
  ///   subscribers replay the full sequence (e.g. [IncomingCallEvent] →
  ///   [AcceptedEvent]) and reach the correct current state.
  /// - Terminal events ([HangupEvent], [MissedCallEvent]): remove the history
  ///   entry and evict the dead call's line from the buffered handshake.
  /// - Non-[CallEvent] protocol events: no call history affected.
  void _updateCallHistory(Event event, List<dynamic> encoded) {
    if (event is IncomingCallEvent) {
      _callEventHistory[event.callId] = [encoded];
      return;
    }
    if (event is! CallEvent) return;

    if (event is HangupEvent || event is MissedCallEvent) {
      // Always evict the dead call's line from the handshake — regardless of
      // whether this call was tracked in [_callEventHistory]. Calls that arrived
      // in the initial [StateHandshake] (before the hub started) are never added
      // to [_callEventHistory], but their stale handshake line must still be
      // removed so late subscribers don't see an ended call in handshake.lines.
      _evictHandshakeLine(event.callId);
      _callEventHistory.remove(event.callId);
      _logger.fine('Hub: call history removed (terminal) callId=${event.callId}');
      return;
    }

    // Non-terminal event: append to history if this call is being tracked
    // (i.e. it arrived via IncomingCallEvent during this session).
    final history = _callEventHistory[event.callId];
    if (history != null) {
      history.add(encoded);
      _logger.fine('Hub: call history appended ${event.runtimeType} callId=${event.callId}');
    }
  }

  /// Removes the [callId] entry from the [lines] list inside the buffered
  /// [SignalingHandshakeReceived] entry (if present).
  ///
  /// Mutates the encoded map in-place: no re-encoding required because
  /// [_sessionBuffer] holds a direct reference to the same [Map] object that
  /// [encodeHubEvent] produced for the handshake.
  void _evictHandshakeLine(String callId) {
    for (final entry in _sessionBuffer) {
      if (!isHubEventHandshakeReceived(entry) || entry.length < 2) continue;
      final map = entry[1];
      if (map is! Map) continue;
      final lines = map['lines'];
      if (lines is! List) continue;
      final before = lines.length;
      lines.removeWhere((l) => l is Map && l['call_id'] == callId);
      if (lines.length != before) {
        _logger.fine('Hub: evicted handshake line callId=$callId');
      }
      return;
    }
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
    // Replay current session buffer so the new subscriber gets the full connection state.
    for (final event in List<List<dynamic>>.from(_sessionBuffer)) {
      cmd.replyPort.send(event);
    }
    // Replay the full event history for each active in-session call.
    // Protocol events are not stored in [_sessionBuffer], so without this
    // replay a late subscriber would miss events that arrived after the initial
    // handshake — e.g. an [AcceptedEvent] that already moved the call out of
    // the ringing state before the Activity opened.
    for (final history in List<List<List<dynamic>>>.from(_callEventHistory.values)) {
      for (final encoded in history) {
        cmd.replyPort.send(encoded);
      }
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
