import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart'
    show
        WebtritSignalingService,
        SignalingServiceConfig,
        SignalingServiceMode,
        SignalingModuleEvent,
        SignalingConnected,
        SignalingConnectionFailed,
        SignalingDisconnected,
        SignalingHandshakeReceived,
        SignalingProtocolEvent;

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';

import '../models/jsep_value.dart';

abstract class IsolateManager implements CallkeepBackgroundServiceDelegate {
  IsolateManager({
    required this.callLogsRepository,
    required this.localPushRepository,
    required this.storage,
    required this.certificates,
    required this.logger,
  });

  final Logger logger;
  final CallLogsRepository callLogsRepository;
  final LocalPushRepository localPushRepository;
  final SecureStorage storage;
  final TrustedCertificates certificates;

  /// callId -> line index (populated from StateHandshake)
  final Map<String, int> _lines = {};

  /// callId -> IncomingCallEvent (populated from StateHandshake and protocol events)
  final Map<String, IncomingCallEvent> _incomingCallEvents = {};

  /// Requests queued while module is not yet connected.
  final List<_PendingRequest> _pendingRequests = [];

  bool get _isModuleConnected;

  Future<void>? _moduleExecute(Request request);

  // Workaround: captures init time as fallback timestamp for call logs.
  final DateTime _initialConnectionTime = DateTime.now();

  /// Abstract methods to abstract the difference between services
  Future<void> endCallOnService(String callId);

  Future<void> endCallsOnService();

  Future<void> close() async {
    for (final pending in _pendingRequests) {
      pending.timeoutTimer.cancel();
      if (!pending.completer.isCompleted) {
        pending.completer.completeError(StateError('IsolateManager closed'));
      }
    }
    _pendingRequests.clear();
  }

  void _onHandshake(StateHandshake handshake) {
    final lines = handshake.lines.whereType<Line>().toList();

    _lines.clear();
    _incomingCallEvents.clear();
    for (var i = 0; i < lines.length; i++) {
      _lines[lines[i].callId] = i;
    }

    if (_lines.isEmpty) {
      _onNoActiveLines();
      return;
    }

    for (final activeLine in lines) {
      final callEvent = activeLine.callLogs.whereType<CallEventLog>().map((log) => log.callEvent).firstOrNull;

      if (callEvent is IncomingCallEvent) {
        _incomingCallEvents[callEvent.callId] = callEvent;
        _onIncomingCall(callEvent);
        _executePendingRequests();
        return;
      }
    }

    _executePendingRequests();
    logger.info('Handshake completed: ${_lines.keys}');
  }

  void _onProtocolEvent(Event event) {
    logger.info('Received event: $event');
    switch (event) {
      case IncomingCallEvent():
        _incomingCallEvents[event.callId] = event;
        _onIncomingCall(event);
      case HangupEvent():
        final incomingEventLog = _findIncomingEventLog(event.callId);
        _onHangupCall(event, (
          direction: CallDirection.incoming,
          number: incomingEventLog?.caller ?? 'unknown',
          video: JsepValue.fromOptional(incomingEventLog?.jsep)?.hasVideo ?? false,
          username: incomingEventLog?.callerDisplayName ?? 'Unknown',
          createdTime: _initialConnectionTime,
          acceptedTime: null,
          hungUpTime: DateTime.now(),
        ));
      case UnregisteredEvent():
        _onUnregistered(event);
      default:
        break;
    }
  }

  IncomingCallEvent? _findIncomingEventLog(String callId) => _incomingCallEvents[callId];

  void _executePendingRequests() {
    logger.info('Executing ${_pendingRequests.length} pending requests...');
    for (final pending in List<_PendingRequest>.from(_pendingRequests)) {
      final lineIndex = _lines[pending.callId];
      if (lineIndex == null) {
        pending.completer.completeError('Line not found for callId: ${pending.callId}');
        pending.timeoutTimer.cancel();
        _pendingRequests.remove(pending);
        continue;
      }

      final future = _moduleExecute(
        pending.requestBuilder(lineIndex, pending.callId, WebtritSignalingClient.generateTransactionId()),
      );
      if (future == null) {
        pending.completer.completeError(StateError('Module not connected for callId: ${pending.callId}'));
        pending.timeoutTimer.cancel();
        _pendingRequests.remove(pending);
        continue;
      }
      future
          .then((_) => pending.completer.complete())
          .catchError((e, s) => pending.completer.completeError(e, s))
          .whenComplete(() {
            pending.timeoutTimer.cancel();
            _pendingRequests.remove(pending);
          });
    }
  }

  Future<void> _sendRequest(String callId, Request Function(int line, String callId, String tx) requestBuilder) async {
    if (!_isModuleConnected) {
      logger.warning('Not connected. Queueing request for $callId');

      final completer = Completer<void>();
      final timeoutTimer = Timer(const Duration(seconds: 10), () {
        if (!completer.isCompleted) {
          completer.completeError(TimeoutException('Request timed out for $callId'));
          _pendingRequests.removeWhere((r) => r.completer == completer);
        }
      });

      _pendingRequests.add(
        _PendingRequest(
          callId: callId,
          requestBuilder: requestBuilder,
          completer: completer,
          timeoutTimer: timeoutTimer,
        ),
      );

      return completer.future;
    }

    final lineIndex = _lines[callId];
    if (lineIndex == null) return;

    await _moduleExecute(requestBuilder(lineIndex, callId, WebtritSignalingClient.generateTransactionId()));
  }

  // Callbacks -- may be overridden by subclasses.

  void _onIncomingCall(IncomingCallEvent event) {}

  void _onNoActiveLines() async {
    await endCallsOnService();
  }

  void _onUnregistered(UnregisteredEvent event) async {
    try {
      await endCallsOnService();
    } catch (e) {
      logger.severe(e);
    }
  }

  void _onSignalingError(Object error) async {
    try {
      await endCallsOnService();
    } catch (e) {
      logger.severe(e);
    }
  }

  void _onHangupCall(HangupEvent event, NewCall call) async {
    logger.info('Hangup event: $event');
    await _showMissedCallNotification(event, call);
    await _logCall(call);
    await endCallOnService(event.callId);
  }

  Future<void> _logCall(NewCall call) async {
    try {
      await callLogsRepository.add(call);
    } catch (e) {
      logger.severe('Failed to add call log', e);
    }
  }

  Future<void> _showMissedCallNotification(HangupEvent event, NewCall call) async {
    try {
      await localPushRepository.displayPush(
        AppLocalPush(
          event.callId.hashCode,
          // TODO: Add localization
          'Missed Call',
          _getDisplayNameForMissedCall(event, call) ?? 'Unknown',
          payload: {'callId': event.callId, 'type': 'missed_call'},
        ),
      );
    } catch (e) {
      logger.severe('Failed to show missed call notification', e);
    }
  }

  String? _getDisplayNameForMissedCall(HangupEvent event, NewCall call) {
    return call.username;
  }

  @override
  void performEndCall(String callId) async {
    final lineIndex = _lines[callId];
    if (lineIndex == null) {
      logger.warning('performEndCall: line not found for callId: $callId');
      return;
    }
    try {
      await _sendRequest(callId, (line, id, tx) => DeclineRequest(transaction: tx, line: line, callId: id));
    } catch (e) {
      logger.severe(e);
    }
  }
}

class PushNotificationIsolateManager extends IsolateManager {
  PushNotificationIsolateManager({
    required super.callLogsRepository,
    required super.localPushRepository,
    required BackgroundPushNotificationService callkeep,
    required super.storage,
    required super.certificates,
    required super.logger,
  }) : _pushService = callkeep {
    _pushService.setBackgroundServiceDelegate(this);
  }

  /// The service for interacting with the isolate that was launched by an incoming push notification.
  final BackgroundPushNotificationService _pushService;

  /// The metadata of the incoming call.
  /// This is used to display the caller's name in the missed call notification.
  CallkeepIncomingCallMetadata? _metadata;

  WebtritSignalingService? _signalingService;
  StreamSubscription<SignalingModuleEvent>? _signalingSubscription;
  bool _signalingConnected = false;

  /// Set while [launchSignaling] is awaiting the initial handshake.
  /// [close] completes it with false to unblock the launch immediately.
  Completer<bool>? _handshakeCompleter;

  @override
  bool get _isModuleConnected => _signalingConnected;

  @override
  Future<void>? _moduleExecute(Request request) {
    if (_signalingConnected) return _signalingService?.execute(request);
    return null;
  }

  Future<void> launchSignaling(CallkeepIncomingCallMetadata? metadata) async {
    _metadata = metadata;
    logger.info('Starting background call event service: $metadata');

    // Start a push-bound signaling connection. In push-bound mode the service
    // dies with the app -- the push is responsible for starting a fresh connection.
    // After the push isolate is released the connection dies too, leaving the
    // server free to send the next push.
    final service = WebtritSignalingService();

    final config = SignalingServiceConfig(
      coreUrl: storage.readCoreUrl() ?? '',
      tenantId: storage.readTenantId() ?? '',
      token: storage.readToken() ?? '',
      trustedCertificates: certificates,
    );

    // Wait for SignalingHandshakeReceived so that _lines is populated before
    // launchSignaling returns. ConnectionFailed/Disconnected resolve with false
    // so we do not hang forever on an unreachable server.
    // _handshakeCompleter is stored on the instance so close() can cancel the
    // wait immediately instead of waiting for the 10-second timeout.
    _handshakeCompleter = Completer<bool>();
    StreamSubscription<SignalingModuleEvent>? probeSub;
    probeSub = service.events.listen((event) {
      if (_handshakeCompleter!.isCompleted) return;
      if (event is SignalingHandshakeReceived) {
        _handshakeCompleter!.complete(true);
      } else if (event is SignalingConnectionFailed || event is SignalingDisconnected) {
        _handshakeCompleter!.complete(false);
      }
    });

    await service.start(config, mode: SignalingServiceMode.pushBound);

    final connected = await _handshakeCompleter!.future.timeout(const Duration(seconds: 10), onTimeout: () => false);

    await probeSub.cancel();
    _handshakeCompleter = null;

    if (!connected) {
      logger.severe('launchSignaling: failed to connect within timeout');
      await service.dispose();
      return;
    }

    logger.info('launchSignaling: connected and handshake received');
    _signalingService = service;
    _signalingConnected = true;
    _signalingSubscription = service.events.listen(_onSignalingEvent);
  }

  void _onSignalingEvent(SignalingModuleEvent event) {
    switch (event) {
      case SignalingConnected():
        _signalingConnected = true;
        _executePendingRequests();
      case SignalingConnectionFailed(:final error):
        _signalingConnected = false;
        _onSignalingError(error);
      case SignalingDisconnected():
        _signalingConnected = false;
        _onSignalingError('Signaling disconnected');
      case SignalingHandshakeReceived(:final handshake):
        _onHandshake(handshake);
      case SignalingProtocolEvent(:final event):
        _onProtocolEvent(event);
      default:
        break;
    }
  }

  @override
  Future<void> close() async {
    // Unblock launchSignaling() if it is still awaiting the handshake, so the
    // probe subscription is cancelled promptly instead of waiting for the timeout.
    if (_handshakeCompleter != null && !_handshakeCompleter!.isCompleted) {
      _handshakeCompleter!.complete(false);
    }
    _handshakeCompleter = null;
    await _signalingSubscription?.cancel();
    _signalingSubscription = null;
    await _signalingService?.dispose();
    _signalingService = null;
    _signalingConnected = false;
    await super.close();
  }

  @override
  Future<void> endCallOnService(String callId) {
    return _pushService.endCall(callId);
  }

  @override
  Future<void> endCallsOnService() {
    return _pushService.endCalls();
  }

  @override
  void performAnswerCall(String callId) async {
    final hasNetwork = await Connectivity().checkConnectivity().then((r) => !r.contains(ConnectivityResult.none));
    if (!hasNetwork) {
      throw Exception('Not connected');
    }
  }

  @override
  void performEndCall(String callId) async {
    final lineIndex = _lines[callId];
    if (lineIndex == null) {
      // Line not yet known -- handshake may still be in flight. Dismiss the local
      // notification immediately so the UI does not stay stuck. The DeclineRequest
      // cannot be sent without a line index; the server will time out on its own.
      logger.warning('performEndCall: line not found for $callId -- ending call locally');
      try {
        await endCallOnService(callId);
      } catch (e) {
        logger.severe(e);
      }
      return;
    }
    try {
      await _sendRequest(callId, (line, id, tx) => DeclineRequest(transaction: tx, line: line, callId: id));
    } catch (e) {
      logger.severe(e);
    }
  }

  @override
  void _onNoActiveLines() async {
    if (_metadata != null) {
      final event = HangupEvent(callId: _metadata!.callId, line: -1, reason: 'Missed', code: -1);
      final call = (
        direction: CallDirection.incoming,
        number: _metadata!.handle!.value,
        video: _metadata!.hasVideo,
        username: _metadata!.displayName,
        createdTime: DateTime.now(),
        acceptedTime: null,
        hungUpTime: DateTime.now(),
      );
      await _showMissedCallNotification(event, call);
      await _logCall(call);
    }
    await endCallsOnService();
  }

  @override
  String? _getDisplayNameForMissedCall(HangupEvent event, NewCall call) {
    final signalingName = super._getDisplayNameForMissedCall(event, call);
    if (signalingName?.isNotEmpty == true) {
      return signalingName;
    }

    if (_metadata?.callId == event.callId && _metadata!.displayName?.isNotEmpty == true) {
      return _metadata!.displayName;
    }

    return signalingName;
  }
}

// ---------------------------------------------------------------------------

class _PendingRequest {
  final String callId;
  final Request Function(int line, String callId, String tx) requestBuilder;
  final Completer<void> completer;
  final Timer timeoutTimer;

  _PendingRequest({
    required this.callId,
    required this.requestBuilder,
    required this.completer,
    required this.timeoutTimer,
  });
}
