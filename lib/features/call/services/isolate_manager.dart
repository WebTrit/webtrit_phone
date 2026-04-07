import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';

import '../models/jsep_value.dart';

/// Manages the signaling session for the CallKeep push-notification background isolate.
///
/// Opened once per incoming push notification, connects to the signaling server
/// to retrieve call state, handles missed-call logging and notifications, and
/// forwards decline/end actions to the Android telecom framework.
/// Never reconnects -- the isolate is short-lived by design.
class PushNotificationIsolateManager implements CallkeepBackgroundServiceDelegate {
  PushNotificationIsolateManager({
    required this.callLogsRepository,
    required this.localPushRepository,
    required BackgroundPushNotificationService callkeep,
    required this.storage,
    required this.certificates,
    required this.logger,
  }) : _pushService = callkeep {
    _initSignaling();
    _pushService.setBackgroundServiceDelegate(this);
  }

  final Logger logger;
  final CallLogsRepository callLogsRepository;
  final LocalPushRepository localPushRepository;
  final SecureStorage storage;
  final TrustedCertificates certificates;

  final BackgroundPushNotificationService _pushService;

  late final SignalingModule _signalingModule;
  late final StreamSubscription<SignalingModuleEvent> _signalingSubscription;

  /// Metadata from the incoming push notification.
  /// Used as a fallback for missed-call display name and call logging.
  CallkeepIncomingCallMetadata? _metadata;

  /// callId -> line index (populated from StateHandshake)
  final Map<String, int> _lines = {};

  /// callId -> IncomingCallEvent (populated from StateHandshake and protocol events)
  final Map<String, IncomingCallEvent> _incomingCallEvents = {};

  /// Requests queued while the signaling module is not yet connected.
  final List<_PendingRequest> _pendingRequests = [];

  // Workaround: captures init time as fallback timestamp for call logs.
  final DateTime _initialConnectionTime = DateTime.now();

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Connects to the signaling server to synchronise call state for the given
  /// push notification [metadata].
  Future<void> launchSignaling(CallkeepIncomingCallMetadata? metadata) async {
    _metadata = metadata;
    logger.info('launchSignaling: $metadata');
    _signalingModule.connect();
  }

  /// Cancels all timers and pending requests, then disposes the signaling module.
  Future<void> close() async {
    for (final pending in _pendingRequests) {
      pending.timeoutTimer.cancel();
      if (!pending.completer.isCompleted) {
        pending.completer.completeError(StateError('PushNotificationIsolateManager closed'));
      }
    }
    _pendingRequests.clear();
    await _signalingSubscription.cancel();
    await _signalingModule.dispose();
  }

  // ---------------------------------------------------------------------------
  // CallkeepBackgroundServiceDelegate
  // ---------------------------------------------------------------------------

  @override
  void performEndCall(String callId) async {
    try {
      // Do not early-return when _lines is empty -- _sendRequest queues the
      // request so it is executed once the handshake arrives (e.g. user declines
      // from the lock screen before the signaling handshake completes).
      await _sendRequest(callId, (line, id, tx) => DeclineRequest(transaction: tx, line: line, callId: id));
    } catch (e) {
      logger.severe(e);
    }
  }

  @override
  void performAnswerCall(String callId) async {
    final hasNetwork = await Connectivity().checkConnectivity().then(
      (r) => r.isNotEmpty && !r.contains(ConnectivityResult.none),
    );
    if (!hasNetwork) {
      throw Exception('performAnswerCall: no network for callId=$callId');
    }
  }

  // ---------------------------------------------------------------------------
  // Signaling init
  // ---------------------------------------------------------------------------

  void _initSignaling() {
    _signalingModule = SignalingModuleImpl(
      coreUrl: storage.readCoreUrl() ?? '',
      tenantId: storage.readTenantId() ?? '',
      token: storage.readToken() ?? '',
      trustedCertificates: certificates,
      connectionTimeout: kSignalingClientConnectionTimeout,
      reconnectDelay: kSignalingClientReconnectDelay,
    );

    _signalingSubscription = _signalingModule.events.listen((event) {
      switch (event) {
        case SignalingHandshakeReceived(:final handshake):
          _onHandshake(handshake);
        case SignalingProtocolEvent(:final event):
          _onProtocolEvent(event);
        case SignalingConnectionFailed(:final error):
          _onSignalingError(error);
        default:
          break;
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Signaling event handlers
  // ---------------------------------------------------------------------------

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
      case HangupEvent():
        final incomingEventLog = _incomingCallEvents[event.callId];
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
    await _pushService.endCalls();
  }

  void _onUnregistered(UnregisteredEvent event) async {
    try {
      await _pushService.endCalls();
    } catch (e) {
      logger.severe(e);
    }
  }

  void _onSignalingError(Object error) async {
    try {
      await _pushService.endCalls();
    } catch (e) {
      logger.severe(e);
    }
  }

  void _onHangupCall(HangupEvent event, NewCall call) async {
    logger.info('Hangup event: $event');
    await _showMissedCallNotification(event, call);
    await _logCall(call);
    await _pushService.endCall(event.callId);
  }

  // ---------------------------------------------------------------------------
  // Pending request queue
  // ---------------------------------------------------------------------------

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

      final future = _signalingModule.execute(
        pending.requestBuilder(lineIndex, pending.callId, WebtritSignalingClient.generateTransactionId()),
      );
      if (future == null) {
        pending.completer.completeError(StateError('Signaling disconnected while flushing callId: ${pending.callId}'));
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
    if (!_signalingModule.isConnected) {
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

    final future = _signalingModule.execute(
      requestBuilder(lineIndex, callId, WebtritSignalingClient.generateTransactionId()),
    );
    if (future == null) {
      logger.warning('execute returned null for callId $callId (disconnected after isConnected check)');
      return;
    }
    await future;
  }

  // ---------------------------------------------------------------------------
  // Notifications and logging
  // ---------------------------------------------------------------------------

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

  /// Returns the best available display name for the missed-call notification.
  ///
  /// Prefers the signaling caller name; falls back to push metadata display
  /// name if signaling did not provide one.
  String? _getDisplayNameForMissedCall(HangupEvent event, NewCall call) {
    final signalingName = call.username;
    if (signalingName?.isNotEmpty == true) return signalingName;

    if (_metadata?.callId == event.callId && (_metadata!.displayName?.isNotEmpty ?? false)) {
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
