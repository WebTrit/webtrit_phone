import 'dart:async';

import 'package:logging/logging.dart';

import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

const _noActiveLines = 0;

final _logger = Logger('BackgroundCallEventService');

class BackgroundCallEventService implements CallkeepBackgroundServiceDelegate {
  BackgroundCallEventService({
    required RecentsRepository recentsRepository,
    required AppPreferences appPreferences,
    required CallkeepBackgroundService callkeep,
    required SecureStorage storage,
    required TrustedCertificates certificates,
  })  : _recentsRepository = recentsRepository,
        _appPreferences = appPreferences,
        _callkeep = callkeep {
    _initSignalingManager(storage, certificates);
    _callkeep.setBackgroundServiceDelegate(this);
  }

  final RecentsRepository _recentsRepository;
  final AppPreferences _appPreferences;
  final CallkeepBackgroundService _callkeep;

  late final SignalingManager _signalingManager;

  IncomingCallType get _incomingCallType => _appPreferences.getIncomingCallType();

  void _initSignalingManager(SecureStorage storage, TrustedCertificates certificates) {
    _signalingManager = SignalingManager(
        coreUrl: storage.readCoreUrl() ?? '',
        tenantId: storage.readTenantId() ?? '',
        token: storage.readToken() ?? '',
        enableReconnect: true,
        certificates: certificates,
        onDisconnect: _handleSignalingDisconnect,
        onError: _handleSignalingError,
        onHangupCallEvent: _handleHangupCall,
        onIncomingCallEvent: _handleIncomingCall,
        onUnregisteredEvent: _handleUnregisteredEvent,
        onActiveLine: _handleActiveLines);
  }

  // Handles the service startup. This can occur under several scenarios:
  // - Launching from an FCM isolate.
  // - User enabling the socket type.
  // - Service being restarted.
  // - Automatic start during system boot.
  Future<void> onStart(CallkeepServiceStatus status) async {
    _logger.info('onStart: $status');

    final isBackground = status.lifecycle == CallkeepLifecycleType.onStop ||
        status.lifecycle == CallkeepLifecycleType.onAny ||
        status.lifecycle == CallkeepLifecycleType.onDestroy;

    if (isBackground) {
      // Connects to the signaling serve if not connected yet
      _signalingManager.launch();
    }
  }

  Future<void> onChangedLifecycle(CallkeepServiceStatus status) async {
    try {
      _logger.info('onChangedLifecycle: $status');

      // [Socket]
      // If the app is hidden and there are no active calls, launch the signaling manager in the background.
      if (status.lifecycle == CallkeepLifecycleType.onStop && !status.activeCalls) {
        _signalingManager.launch();
      }

      // [Push Notifications]
      // Stop the foreground service when the app is resumed. Push notifications will handle incoming calls in the future.
      if (status.lifecycle == CallkeepLifecycleType.onResume && _incomingCallType.isPushNotification) {
        await _stopIsolate();
      }
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleIncomingCall(IncomingCallEvent event) {
    try {
      final number = CallkeepHandle.number(event.caller);
      _callkeep.incomingCall(event.callId, number, displayName: event.callerDisplayName, hasVideo: false);
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleHangupCall(HangupEvent event) async {
    try {
      await _callkeep.endBackgroundCall(event.callId);

      if (_incomingCallType.isPushNotification) {
        await _stopIsolate();
      }
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleSignalingError(error, [StackTrace? stackTrace]) async {
    try {
      if (_incomingCallType.isPushNotification) await _stopIsolate();
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleSignalingDisconnect(int? code, String? reason) async {
    try {
      if (_incomingCallType.isPushNotification) await _stopIsolate();
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleUnregisteredEvent(UnregisteredEvent event) async {
    try {
      await _callkeep.endAllBackgroundCalls();
      if (_incomingCallType.isPushNotification) await _stopIsolate();
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleActiveLines(int count) async {
    try {
      if (count == _noActiveLines) {
        if (_incomingCallType.isPushNotification) await _stopIsolate();
      }
    } catch (e) {
      _handleExceptions(e);
    }
  }

  @override
  void performServiceAnswerCall(String callId) {}

  @override
  void performServiceEndCall(String callId) async {
    try {
      await _signalingManager.declineRequest(callId);

      if (_incomingCallType.isPushNotification) {
        await _stopIsolate();
      }
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
    await _recentsRepository.add(Recent(
      direction: Direction.incoming,
      number: number,
      video: video,
      createdTime: createdTime,
      acceptedTime: acceptedTime,
      hungUpTime: hungUpTime,
    ));
  }

  Future<void> _stopIsolate() async {
    await _signalingManager.close();
    await _callkeep.stopService();
  }

  void _handleExceptions(e) {
    _logger.severe(e);
  }
}
