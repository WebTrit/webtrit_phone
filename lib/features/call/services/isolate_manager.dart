import 'dart:async';

import 'package:logging/logging.dart';

import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
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
      onError: _handleSignalingError,
      onHangupCall: _handleHangupCall,
      onUnregistered: _handleUnregisteredEvent,
      onNoActiveLines: _handleAvoidLines,
      onIncomingCall: onIncomingCall,
      onDisconnect: onDisconnect,
    );
  }

  Future<void> close() async {
    return signalingManager.dispose();
  }

  void _handleHangupCall(HangupEvent event, NewCall call) async {
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
          call.username ?? 'Unknown',
          payload: {'callId': event.callId, 'type': 'missed_call'},
        ),
      );
    } catch (e) {
      logger.severe('Failed to show missed call notification', e);
    }
  }

  // Default behavior: End calls on signaling error.
  // This is used by PushNotificationIsolateManager.
  void _handleSignalingError(Object error, [StackTrace? stackTrace]) async {
    try {
      await endCallsOnService();
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleAvoidLines() async {
    await endCallsOnService();
  }

  void _handleUnregisteredEvent(UnregisteredEvent event) async {
    try {
      await endCallsOnService();
    } catch (e) {
      _handleExceptions(e);
    }
  }

  @override
  void performEndCall(String callId) async {
    try {
      await signalingManager.declineCall(callId);
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleExceptions(Object e) {
    logger.severe(e);
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
  }) : _callkeep = callkeep {
    initSignaling(enableReconnect: false);
    _callkeep.setBackgroundServiceDelegate(this);
  }

  final BackgroundPushNotificationService _callkeep;

  Future<void> sync() async {
    logger.info('Starting background call event service');
    return signalingManager.launch();
  }

  @override
  Future<void> endCallOnService(String callId) {
    return _callkeep.endCall(callId);
  }

  @override
  Future<void> endCallsOnService() {
    return _callkeep.endCalls();
  }

  @override
  void performAnswerCall(String callId) async {
    if (!(await signalingManager.hasNetworkConnection())) {
      throw Exception('Not connected');
    }
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
  }) : _callkeep = callkeep {
    initSignaling(enableReconnect: true, onIncomingCall: _handleIncomingCall, onDisconnect: _handleSignalingDisconnect);
    _callkeep.setBackgroundServiceDelegate(this);
  }

  final BackgroundSignalingService _callkeep;

  Future<void> sync(CallkeepServiceStatus status) async {
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
    return _callkeep.endCall(callId);
  }

  @override
  Future<void> endCallsOnService() {
    return _callkeep.endCalls();
  }

  @override
  void _handleSignalingError(Object error, [StackTrace? stackTrace]) async {
    try {
      logger.info('Signaling error: $error');
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleIncomingCall(IncomingCallEvent event) {
    try {
      _callkeep.incomingCall(
        event.callId,
        CallkeepHandle.number(event.caller),
        displayName: event.callerDisplayName,
        hasVideo: JsepValue.fromOptional(event.jsep)?.hasVideo ?? false,
      );
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleSignalingDisconnect(int? code, String? reason) async {
    try {
      logger.info('Signaling disconnect: $code, $reason');
    } catch (e) {
      _handleExceptions(e);
    }
  }

  @override
  void performAnswerCall(String callId) {
    logger.info('Answering call: $callId');
  }
}
