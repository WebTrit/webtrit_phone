import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../models/jsep_value.dart';
import 'signaling_module.dart';

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

  late final SignalingModule _signalingModule;
  late final StreamSubscription<SignalingModuleEvent> _signalingSubscription;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _networkNone = false;

  /// callId → line index (populated from StateHandshake)
  final Map<String, int> _lines = {};

  /// Requests queued while module is not yet connected.
  final List<_PendingRequest> _pendingRequests = [];

  // Workaround: captures init time as fallback timestamp for call logs.
  final DateTime _initialConnectionTime = DateTime.now();

  /// Abstract methods to abstract the difference between services
  Future<void> endCallOnService(String callId);

  Future<void> endCallsOnService();

  /// Initialises the [SignalingModule] and starts connectivity monitoring.
  /// Must be called in the constructor body of the child class.
  void initSignaling({required bool enableReconnect}) {
    _signalingModule = SignalingModule(
      coreUrl: storage.readCoreUrl() ?? '',
      tenantId: storage.readTenantId() ?? '',
      token: storage.readToken() ?? '',
      trustedCertificates: certificates,
      signalingClientFactory: defaultSignalingClientFactory,
    );

    _signalingSubscription = _signalingModule.events.listen((event) {
      switch (event) {
        case SignalingHandshakeReceived(:final handshake):
          _onHandshake(handshake);
        case SignalingProtocolEvent(:final event):
          _onProtocolEvent(event);
        case SignalingConnectionFailed(:final error, :final recommendedReconnectDelay):
          _onSignalingError(error);
          if (enableReconnect && !_networkNone) {
            Future.delayed(recommendedReconnectDelay, _signalingModule.connect);
          }
        case SignalingDisconnected(:final recommendedReconnectDelay):
          if (enableReconnect && recommendedReconnectDelay != null && !_networkNone) {
            Future.delayed(recommendedReconnectDelay, _signalingModule.connect);
          }
        default:
          break;
      }
    });

    _monitorConnectivity(enableReconnect: enableReconnect);
  }

  Future<void> close() async {
    await _signalingSubscription.cancel();
    await _connectivitySubscription?.cancel();
    await _signalingModule.dispose();
    _pendingRequests.clear();
  }

  void _monitorConnectivity({required bool enableReconnect}) {
    logger.info('Monitoring connectivity...');

    Timer? connectivityTimeout;
    int connectivityNoneCounter = 0;
    const int maxConnectivityNoneRepeats = 3;

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((results) async {
      logger.info('Connectivity changed: $results');

      connectivityTimeout?.cancel();

      if (results.any((r) => r == ConnectivityResult.none)) {
        _networkNone = true;
        connectivityNoneCounter++;
        logger.warning('No internet connection detected ($connectivityNoneCounter/$maxConnectivityNoneRepeats)');

        if (connectivityNoneCounter >= maxConnectivityNoneRepeats) {
          logger.severe('Max connectivity loss reached');
          _onSignalingError('Max connectivity loss reached');
          connectivityNoneCounter = 0;
          return;
        }

        connectivityTimeout = Timer(const Duration(seconds: 5), () {
          if (results.any((r) => r == ConnectivityResult.none)) {
            logger.severe('Internet connection not restored within timeout');
            _onSignalingError('No internet connection');
          }
        });
      } else {
        _networkNone = false;
        connectivityNoneCounter = 0;

        if (enableReconnect && _signalingModule.signalingClient == null) {
          _signalingModule.connect();
        }
      }
    });
  }

  void _onHandshake(StateHandshake handshake) {
    final lines = handshake.lines.whereType<Line>().toList();

    _lines.clear();
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

  IncomingCallEvent? _findIncomingEventLog(String callId) {
    // Lines map only has line index — we need to find the full Line object.
    // Re-derive from the module's last handshake is not available here, so
    // callers provide context via the event itself when possible.
    // This is a best-effort lookup; callers handle null gracefully.
    return null;
  }

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

      _signalingModule.signalingClient
          ?.execute(pending.requestBuilder(lineIndex, pending.callId, WebtritSignalingClient.generateTransactionId()))
          .then((_) => pending.completer.complete())
          .catchError((e, s) => pending.completer.completeError(e, s))
          .whenComplete(() {
            pending.timeoutTimer.cancel();
            _pendingRequests.remove(pending);
          });
    }
  }

  Future<void> _sendRequest(String callId, Request Function(int line, String callId, String tx) requestBuilder) async {
    final client = _signalingModule.signalingClient;
    if (client == null) {
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

    await client.execute(requestBuilder(lineIndex, callId, WebtritSignalingClient.generateTransactionId()));
  }

  // Callbacks — may be overridden by subclasses.

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
    initSignaling(enableReconnect: false);
    _pushService.setBackgroundServiceDelegate(this);
  }

  /// The service for interacting with the isolate that was launched by an incoming push notification.
  final BackgroundPushNotificationService _pushService;

  /// The metadata of the incoming call.
  /// This is used to display the caller's name in the missed call notification.
  CallkeepIncomingCallMetadata? _metadata;

  Future<void> launchSignaling(CallkeepIncomingCallMetadata? metadata) async {
    _metadata = metadata;
    logger.info('Starting background call event service: $metadata');
    _signalingModule.connect();
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

class SignalingForegroundIsolateManager extends IsolateManager {
  SignalingForegroundIsolateManager({
    required super.callLogsRepository,
    required super.localPushRepository,
    required BackgroundSignalingService callkeep,
    required super.storage,
    required super.certificates,
    required super.logger,
  }) : _signalingService = callkeep {
    initSignaling(enableReconnect: true);
    _signalingService.setBackgroundServiceDelegate(this);
  }

  final BackgroundSignalingService _signalingService;

  Future<void> handleLifecycleStatus(CallkeepServiceStatus status) async {
    logger.info('onStart: $status');

    final mainSignalingStatus =
        (status.mainSignalingStatus == CallkeepSignalingStatus.connecting ||
        status.mainSignalingStatus == CallkeepSignalingStatus.connect);

    final isAppInBackground =
        (status.lifecycleEvent == CallkeepLifecycleEvent.onStop ||
        status.lifecycleEvent == CallkeepLifecycleEvent.onDestroy);

    if (isAppInBackground && !mainSignalingStatus) {
      _signalingModule.connect();
    } else {
      await _signalingModule.dispose();
    }
  }

  @override
  Future<void> endCallOnService(String callId) {
    return _signalingService.endCall(callId);
  }

  @override
  Future<void> endCallsOnService() {
    return _signalingService.endCalls();
  }

  @override
  void _onSignalingError(Object error) async {
    try {
      logger.info('Signaling error: $error');
    } catch (e) {
      logger.severe(e);
    }
  }

  @override
  void _onIncomingCall(IncomingCallEvent event) {
    try {
      _signalingService.incomingCall(
        event.callId,
        CallkeepHandle.number(event.caller),
        displayName: event.callerDisplayName,
        hasVideo: JsepValue.fromOptional(event.jsep)?.hasVideo ?? false,
      );
    } catch (e) {
      logger.severe(e);
    }
  }

  @override
  void performAnswerCall(String callId) {
    logger.info('Answering call: $callId');
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
