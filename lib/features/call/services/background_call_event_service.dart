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

final _logger = Logger('BackgroundCallEventService');

class BackgroundCallEventService implements CallkeepBackgroundServiceDelegate {
  BackgroundCallEventService({
    required CallLogsRepository callLogsRepository,
    required AppPreferences appPreferences,
    required CallkeepBackgroundService callkeep,
    required CallkeepConnections callkeepConnections,
    required SecureStorage storage,
    required TrustedCertificates certificates,
  })  : _callLogsRepository = callLogsRepository,
        _appPreferences = appPreferences,
        _callkeep = callkeep,
        _callkeepConnections = callkeepConnections {
    _initSignalingManager(storage, certificates);
    _callkeep.setBackgroundServiceDelegate(this);
  }

  final CallLogsRepository _callLogsRepository;
  final AppPreferences _appPreferences;
  final CallkeepBackgroundService _callkeep;
  final CallkeepConnections _callkeepConnections;

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
  Future<void> onStart(CallkeepServiceStatus status) async {
    _logger.info('onStart: $status');

    final isBackground = status.lifecycle == CallkeepLifecycleType.onStop ||
        status.lifecycle == CallkeepLifecycleType.onPause ||
        status.lifecycle == CallkeepLifecycleType.onDestroy;

    if (isBackground) {
      // Connects to the signaling serve if not connected yet
      _signalingManager.launch();
    }
  }

  void _handleAvoidLines() async {
    await _callkeep.endAllBackgroundCalls();
  }

  Future<void> onChangedLifecycle(CallkeepServiceStatus status) async {
    try {
      if (status.lifecycle == CallkeepLifecycleType.onStop) {
        _signalingManager.launch();
      }
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

  void _handleHangupCall(HangupEvent event) async {
    try {
      await _callkeep.endBackgroundCall(event.callId);
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
      await _callkeep.endAllBackgroundCalls();
    } catch (e) {
      _handleExceptions(e);
    }
  }

  @override
  void performServiceAnswerCall(String callId) {}

  @override
  void performServiceEndCall(String callId) async {
    try {
      await _signalingManager.declineCall(callId);
    } catch (e) {
      _handleExceptions(e);
    }
  }

// TODO (Serdun): Rename this callback to align with naming conventions.
  @override
  Future<void> endCallReceived(
    String callId,
    String number,
    DateTime createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime, {
    bool video = false,
  }) async {
    NewCall call = (
      direction: CallDirection.incoming,
      number: number,
      video: video,
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
