import 'dart:async';

import 'package:logging/logging.dart';

import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/common/common.dart';
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

  late final SignalingManager signalingManager;

  /// Abstract methods to abstract the difference between services
  Future<void> endCallOnService(String callId);

  Future<void> endCallsOnService();

  /// Initialize the SignalingManager.
  /// Must be called in the constructor body of the child class.
  void initSignaling({
    required bool enableReconnect,
    void Function(IncomingCallEvent)? onIncomingCall,
    void Function(int?, String?)? onDisconnect,
  }) {
    signalingManager = SignalingManager(
      coreUrl: storage.readCoreUrl() ?? '',
      tenantId: storage.readTenantId() ?? '',
      token: storage.readToken() ?? '',
      certificates: certificates,
      enableReconnect: enableReconnect,
      onError: _onSignalingError,
      onHangupCall: _onHangupCall,
      onUnregistered: _onUnregistered,
      onNoActiveLines: _onNoActiveLines,
      onIncomingCall: onIncomingCall,
      onDisconnect: onDisconnect,
    );
  }

  Future<void> close() async {
    return signalingManager.dispose();
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

  // Default behavior: End calls on signaling error.
  // This is used by PushNotificationIsolateManager.
  void _onSignalingError(Object error, [StackTrace? stackTrace]) async {
    try {
      await endCallsOnService();
    } catch (e) {
      logger.severe(e);
    }
  }

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

  @override
  void performEndCall(String callId) async {
    try {
      await signalingManager.declineCall(callId);
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
    return signalingManager.launch();
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
    if (!(await signalingManager.hasNetworkConnection())) {
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
    initSignaling(enableReconnect: true, onIncomingCall: _onIncomingCall, onDisconnect: _onSignalingDisconnect);
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
      await signalingManager.launch();
    } else {
      await signalingManager.dispose();
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
  void _onSignalingError(Object error, [StackTrace? stackTrace]) async {
    try {
      logger.info('Signaling error: $error');
    } catch (e) {
      logger.severe(e);
    }
  }

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

  void _onSignalingDisconnect(int? code, String? reason) async {
    try {
      logger.info('Signaling disconnect: $code, $reason');
    } catch (e) {
      logger.severe(e);
    }
  }

  @override
  void performAnswerCall(String callId) {
    logger.info('Answering call: $callId');
  }
}
