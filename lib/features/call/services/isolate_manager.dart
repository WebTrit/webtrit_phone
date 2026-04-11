import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';

import '../models/jsep_value.dart';

/// Manages the signaling session for the CallKeep push-notification background isolate.
///
/// Opened once per incoming push notification, connects to the signaling server
/// to retrieve call state, handles missed-call logging and notifications, and
/// releases the incoming call service when all work is done.
/// Never reconnects — the isolate is short-lived by design.
///
/// On Android, signaling runs through the FGS hub so push isolate and Activity
/// share a single WebSocket connection. On iOS the connection runs directly in
/// the main isolate. Call [init] after construction and before [run].
class PushNotificationIsolateManager implements CallkeepBackgroundServiceDelegate {
  PushNotificationIsolateManager({
    required this.callLogsRepository,
    required this.localPushRepository,
    required BackgroundPushNotificationService callkeep,
    required this.storage,
    required this.certificates,
    required this.logger,
  }) : _pushService = callkeep {
    // Signaling is initialised asynchronously in [init] to allow hub discovery.
    // setBackgroundServiceDelegate is called here so callkeep can route
    // performAnswerCall / performEndCall as soon as the object exists.
    _pushService.setBackgroundServiceDelegate(this);
  }

  final Logger logger;
  final CallLogsRepository callLogsRepository;
  final LocalPushRepository localPushRepository;
  final SecureStorage storage;
  final TrustedCertificates certificates;

  final BackgroundPushNotificationService _pushService;

  // Nullable until [init] completes. Accessed only after [init] in [run]/[close].
  SignalingModule? _signalingModule;
  StreamSubscription<SignalingModuleEvent>? _signalingSubscription;

  /// Metadata from the incoming push notification.
  /// Used as a fallback for missed-call display name and call logging.
  CallkeepIncomingCallMetadata? _metadata;

  /// callId -> line index (populated from StateHandshake)
  final Map<String, int> _lines = {};

  /// callId -> IncomingCallEvent (populated from StateHandshake and protocol events)
  final Map<String, IncomingCallEvent> _incomingCallEvents = {};

  /// Requests queued while the signaling module is not yet connected.
  final List<_PendingRequest> _pendingRequests = [];

  /// Completer resolved when all isolate work is done and [releaseCall] has been called.
  Completer<void>? _completer;

  // Workaround: captures init time as fallback timestamp for call logs.
  final DateTime _initialConnectionTime = DateTime.now();

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Initialises the signaling module.
  ///
  /// Must be called once after construction and before [run]. Separated from
  /// the constructor because hub discovery is asynchronous — on Android the
  /// method checks whether the FGS hub is already running and reuses its
  /// WebSocket, avoiding a second connection.
  Future<void> init() async => _initSignaling();

  /// Connects to the signaling server, processes call state for the given push
  /// notification [metadata], and returns a [Future] that completes after all
  /// work is done (notifications shown, logs written, native service released).
  Future<void> run(CallkeepIncomingCallMetadata? metadata) {
    if (_signalingModule == null) {
      throw StateError('PushNotificationIsolateManager.run() called before init()');
    }
    _metadata = metadata;
    _completer = Completer<void>();
    final module = _signalingModule!;
    logger.info('run: callId=${metadata?.callId} isConnected=${module.isConnected}');
    // WebtritSignalingService.connect() is idempotent: the internal
    // _startPending / _isConnected guard makes repeated calls safe.
    // Always call it so HubConnectionManager starts FGS discovery on the
    // first run() and is a no-op on any subsequent call.
    module.connect();
    return _completer!.future;
  }

  /// Cancels all timers and pending requests, then disposes the signaling module.
  Future<void> close() async {
    logger.info('close: disposing module=${_signalingModule?.runtimeType} pendingRequests=${_pendingRequests.length}');
    for (final pending in _pendingRequests) {
      pending.timeoutTimer.cancel();
      if (!pending.completer.isCompleted) {
        pending.completer.completeError(StateError('PushNotificationIsolateManager closed'));
      }
    }
    _pendingRequests.clear();
    await _signalingSubscription?.cancel();
    await _signalingModule?.dispose();
    await _releaseCall(_metadata?.callId);
    _completeWithError(StateError('PushNotificationIsolateManager closed'));
  }

  // ---------------------------------------------------------------------------
  // CallkeepBackgroundServiceDelegate
  // ---------------------------------------------------------------------------

  @override
  void performEndCall(String callId) async {
    try {
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

  /// Sets up [WebtritSignalingService] for this isolate in
  /// [SignalingServiceMode.pushBound] mode — the same mechanism the Activity
  /// uses, so push isolate and Activity share exactly one FGS WebSocket on
  /// Android. [HubConnectionManager] inside the service handles FGS start and
  /// hub discovery. [connect] is called from [run], not here, so the
  /// connection starts only when processing begins.
  void _initSignaling() {
    logger.info('_initSignaling: creating WebtritSignalingService (pushBound)');
    _signalingModule = WebtritSignalingService(
      config: SignalingServiceConfig(
        coreUrl: storage.readCoreUrl() ?? '',
        tenantId: storage.readTenantId() ?? '',
        token: storage.readToken() ?? '',
        trustedCertificates: certificates,
      ),
      mode: SignalingServiceMode.pushBound,
    );

    _signalingSubscription = _signalingModule!.events.listen((event) {
      switch (event) {
        case SignalingConnecting():
          logger.info('Signaling: connecting');
        case SignalingConnected():
          logger.info('Signaling: connected');
        case SignalingHandshakeReceived(:final handshake):
          _onHandshake(handshake);
        case SignalingProtocolEvent(:final event):
          _onProtocolEvent(event);
        case SignalingDisconnecting():
          logger.info('Signaling: disconnecting');
        case SignalingDisconnected(:final code, :final reason, :final knownCode):
          logger.info('Signaling: disconnected code=$code reason=$reason knownCode=$knownCode');
        case SignalingConnectionFailed(:final error):
          _onSignalingError(error);
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Signaling event handlers
  // ---------------------------------------------------------------------------

  void _onHandshake(StateHandshake handshake) {
    final lines = handshake.lines.whereType<Line>().toList();
    logger.info('Handshake received: ${lines.length} active line(s)');

    _lines.clear();
    _incomingCallEvents.clear();
    for (var i = 0; i < lines.length; i++) {
      _lines[lines[i].callId] = i;
    }

    if (_lines.isEmpty) {
      logger.info('Handshake: no active lines - ending calls');
      _onNoActiveLines();
      return;
    }

    for (final activeLine in lines) {
      final callEvent = activeLine.callLogs.whereType<CallEventLog>().map((log) => log.callEvent).firstOrNull;

      if (callEvent is IncomingCallEvent) {
        logger.info('Handshake: incoming call found callId=${callEvent.callId}');
        _incomingCallEvents[callEvent.callId] = callEvent;
        _executePendingRequests();
        return;
      }
    }

    logger.info('Handshake: active lines present but no IncomingCallEvent found - lines=${_lines.keys}');
    _executePendingRequests();
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
    logger.info('No active lines: releasing call');
    if (_metadata == null) {
      logger.severe('_onNoActiveLines: metadata is null, cannot release call');
      _complete();
      return;
    }
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
    await _releaseCall(_metadata!.callId);
    _complete();
  }

  void _onUnregistered(UnregisteredEvent event) async {
    try {
      final callId = _metadata?.callId;
      if (callId == null) {
        logger.severe('_onUnregistered: metadata is null, cannot release call');
        _complete();
        return;
      }
      await _releaseCall(callId);
    } catch (e) {
      logger.severe(e);
    } finally {
      _complete();
    }
  }

  void _onSignalingError(Object error) async {
    logger.severe('Signaling connection failed: $error - releasing call');
    try {
      final callId = _metadata?.callId;
      if (callId == null) {
        logger.severe('_onSignalingError: metadata is null, cannot release call');
        _complete();
        return;
      }
      await _releaseCall(callId);
    } catch (e) {
      logger.severe(e);
    } finally {
      _complete();
    }
  }

  void _onHangupCall(HangupEvent event, NewCall call) async {
    logger.info('Hangup event: callId=${event.callId} reason=${event.reason}');
    await _showMissedCallNotification(event, call);
    await _logCall(call);
    await _releaseCall(event.callId);
    _complete();
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

      final future = _signalingModule?.execute(
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
    if (!(_signalingModule?.isConnected ?? false)) {
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

    final future = _signalingModule?.execute(
      requestBuilder(lineIndex, callId, WebtritSignalingClient.generateTransactionId()),
    );
    if (future == null) {
      logger.warning('execute returned null for callId $callId (disconnected after isConnected check)');
      return;
    }
    await future;
  }

  // ---------------------------------------------------------------------------
  // Native release
  // ---------------------------------------------------------------------------

  Future<void> _releaseCall(String? callId) async {
    if (callId == null) return;
    try {
      await _pushService.releaseCall(callId);
    } catch (e) {
      logger.severe('_releaseCall failed: $e');
    }
  }

  void _complete() {
    if (_completer != null && !_completer!.isCompleted) {
      _completer!.complete();
    }
  }

  void _completeWithError(Object error) {
    if (_completer != null && !_completer!.isCompleted) {
      _completer!.completeError(error);
    }
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
