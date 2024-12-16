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

const _noActiveLines = 0;

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
      onStateHandshake: _onStateHandshake,
    );
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

      if (_incomingCallType.isPushNotification) {
        await _stopIsolate();
      }
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleSignalingError(error, [StackTrace? stackTrace]) async {
    try {
      if (_incomingCallType.isPushNotification) {
        await _stopIsolate();
      }
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleSignalingDisconnect(int? code, String? reason) async {
    try {
      if (_incomingCallType.isPushNotification) {
        await _stopIsolate();
      }
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleUnregisteredEvent(UnregisteredEvent event) async {
    try {
      await _callkeep.endAllBackgroundCalls();

      if (_incomingCallType.isPushNotification) {
        await _stopIsolate();
      }
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _onStateHandshake(List<Line> lines) async {
    try {
      // If there are no active lines (e.g., the caller canceled the call),
      // and the call was triggered by a push notification, stop the signaling
      // and terminate the isolate to free resources.
      if (lines.length == _noActiveLines && _incomingCallType.isPushNotification) {
        await _stopIsolate();
      }

      for (final activeLine in lines.whereType<Line>()) {
        // Retrieve the most recent call event from the core logs for the current line.
        final callEvent = activeLine.callLogs.whereType<CallEventLog>().map((log) => log.callEvent).firstOrNull;

        if (callEvent != null) {
          // Obtain the corresponding Callkeep connection for the line.
          // Callkeep maintains connection states even if the app's lifecycle has ended.
          final connection = await _callkeepConnections.getConnection(callEvent.callId);

          // Check if the Callkeep connection exists and its state is `stateDisconnected`.
          // Indicates that the call has been terminated by the user or system (e.g., due to connectivity issues).
          // Synchronize the signaling state with the local state for such scenarios.
          if (connection?.state == CallkeepConnectionState.stateDisconnected) {
            // Handle outgoing or accepted calls. If the event is `AcceptedEvent` or `ProceedingEvent`,
            // initiate a hang-up request to align the signaling state.
            if (callEvent is AcceptedEvent || callEvent is ProceedingEvent) {
              await _signalingManager.hangUpRequest(callEvent.callId);
              return;
            }

            // Handle incoming calls. If the event is `IncomingCallEvent`, send a decline request to update the signaling state accordingly.
            if (callEvent is IncomingCallEvent) {
              await _signalingManager.declineRequest(callEvent.callId);

              return;
            }
          }
        }

        // Process all remaining call events for the line, regardless of the connection state.
        // This includes events where the connection is `stateDisconnected`.
        for (var event in activeLine.callLogs.whereType<CallEventLog>().map((log) => log.callEvent)) {
          _signalingManager.handleSignalingEvent(event);
        }
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

  Future<void> _stopIsolate() async {
    await _signalingManager.close();
    await _callkeep.stopService();
  }

  void _handleExceptions(e) {
    _logger.severe(e);
  }
}
