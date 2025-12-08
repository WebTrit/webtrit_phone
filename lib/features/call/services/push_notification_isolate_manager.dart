import 'dart:async';

import 'package:logging/logging.dart';

import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('PushNotificationIsolateManager');

class PushNotificationIsolateManager implements CallkeepBackgroundServiceDelegate {
  PushNotificationIsolateManager({
    required CallLogsRepository callLogsRepository,
    required BackgroundPushNotificationService callkeep,
    required SecureStorage storage,
    required TrustedCertificates certificates,
  }) : _callLogsRepository = callLogsRepository,
       _callkeep = callkeep {
    _initSignalingManager(storage, certificates);
    _callkeep.setBackgroundServiceDelegate(this);
  }

  final CallLogsRepository _callLogsRepository;
  final BackgroundPushNotificationService _callkeep;

  late final SignalingManager _signalingManager;

  void _initSignalingManager(SecureStorage storage, TrustedCertificates certificates) {
    _signalingManager = SignalingManager(
      coreUrl: storage.readCoreUrl() ?? '',
      tenantId: storage.readTenantId() ?? '',
      token: storage.readToken() ?? '',
      certificates: certificates,
      onError: _handleSignalingError,
      onHangupCall: _handleHangupCall,
      onUnregistered: _handleUnregisteredEvent,
      onNoActiveLines: _handleAvoidLines,
    );
  }

  Future<void> close() async {
    return _signalingManager.dispose();
  }

  // Handles the service startup. This can occur under several scenarios:
  // - Launching from an FCM isolate.
  // - User enabling the socket type.
  // - Service being restarted.
  // - Automatic start during system boot.
  Future<void> sync() async {
    _logger.info('Starting background call event service');
    return _signalingManager.launch();
  }

  void _handleHangupCall(HangupEvent event) async {
    try {
      _logger.info('Ending call: ${event.callId}');
      await _callkeep.endCall(event.callId);
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleSignalingError(Object error, [StackTrace? stackTrace]) async {
    try {
      await _callkeep.endCalls();
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleAvoidLines() async {
    await _callkeep.endCalls();
  }

  void _handleUnregisteredEvent(UnregisteredEvent event) async {
    try {
      await _callkeep.endCalls();
    } catch (e) {
      _handleExceptions(e);
    }
  }

  @override
  void performAnswerCall(String callId) async {
    // Check if the device is connected to the network only then proceed
    if (!(await _signalingManager.hasNetworkConnection())) {
      throw Exception('Not connected');
    }
  }

  @override
  void performEndCall(String callId) async {
    return _signalingManager.declineCall(callId);
  }

  // TODO (Serdun): Rename this callback to align with naming conventions.
  @override
  Future<void> performReceivedCall(
    String callId,
    String number,
    DateTime createdTime,
    String? displayName,
    DateTime? acceptedTime,
    DateTime? hungUpTime, {
    bool video = false,
  }) async {
    NewCall call = (
      direction: CallDirection.incoming,
      number: number,
      video: video,
      username: displayName,
      createdTime: createdTime,
      acceptedTime: acceptedTime,
      hungUpTime: hungUpTime,
    );
    try {
      _logger.info('Adding call log: $callId');
      await _callLogsRepository.add(call);
    } catch (e) {
      _logger.severe('Failed to add call log', e);
    }
    return;
  }

  void _handleExceptions(Object e) {
    _logger.severe(e);
  }
}
