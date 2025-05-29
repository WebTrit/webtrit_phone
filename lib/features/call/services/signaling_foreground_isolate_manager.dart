import 'dart:async';

import 'package:logging/logging.dart';

import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../models/models.dart';

final _logger = Logger('SignalingForegroundIsolateManager');

class SignalingForegroundIsolateManager implements CallkeepBackgroundServiceDelegate {
  SignalingForegroundIsolateManager({
    required CallLogsRepository callLogsRepository,
    required BackgroundSignalingService callkeep,
    required SecureStorage storage,
    required TrustedCertificates certificates,
  })  : _callLogsRepository = callLogsRepository,
        _callkeep = callkeep {
    _initSignalingManager(storage, certificates);
    _callkeep.setBackgroundServiceDelegate(this);
  }

  final CallLogsRepository _callLogsRepository;
  final BackgroundSignalingService _callkeep;

  late final SignalingManager _signalingManager;

  void _initSignalingManager(SecureStorage storage, TrustedCertificates certificates) {
    _signalingManager = SignalingManager(
      coreUrl: storage.readCoreUrl() ?? '',
      tenantId: storage.readTenantId() ?? '',
      token: storage.readToken() ?? '',
      enableReconnect: true,
      certificates: certificates,
      onDisconnect: _handleSignalingDisconnect,
      onError: _handleSignalingError,
      onHangupCall: _handleHangupCall,
      onIncomingCall: _handleIncomingCall,
      onUnregistered: _handleUnregisteredEvent,
      onNoActiveLines: _handleAvoidLines,
    );
  }

  // Handles the service startup. This can occur under several scenarios:
  // - User enabling the socket type.
  // - Service being restarted.
  // - Automatic start during system boot.
  Future<void> sync(CallkeepServiceStatus status) async {
    _logger.info('onStart: $status');

    final mainSignalingStatus = (status.mainSignalingStatus == CallkeepSignalingStatus.connecting ||
        status.mainSignalingStatus == CallkeepSignalingStatus.connect);

    final isAppInBackground = (status.lifecycleEvent == CallkeepLifecycleEvent.onStop ||
        status.lifecycleEvent == CallkeepLifecycleEvent.onDestroy);

    if (isAppInBackground && !mainSignalingStatus) {
      _signalingManager.launch();
    } else {
      _signalingManager.dispose();
    }
  }

  void _handleAvoidLines() async {
    await _callkeep.endCalls();
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

  void _handleHangupCall(HangupEvent event) async {
    try {
      await _callkeep.endCall(event.callId);
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleSignalingError(error, [StackTrace? stackTrace]) async {
    try {} catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleSignalingDisconnect(int? code, String? reason) async {
    try {} catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleUnregisteredEvent(UnregisteredEvent event) async {
    try {
      await _callkeep.endCalls();
    } catch (e) {
      _handleExceptions(e);
    }
  }

  @override
  void performAnswerCall(String callId) {}

  @override
  void performEndCall(String callId) async {
    try {
      await _signalingManager.declineCall(callId);
    } catch (e) {
      _handleExceptions(e);
    }
  }

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
    await _callLogsRepository.add(call);
  }

  void _handleExceptions(e) {
    _logger.severe(e);
  }
}
