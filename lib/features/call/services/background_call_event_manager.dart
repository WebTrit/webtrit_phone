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

class BackgroundCallEventManager implements CallkeepBackgroundServiceDelegate {
  BackgroundCallEventManager({
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
      onError: _handleSignalingError,
      onHangupCallEvent: _handleHangupCall,
      onUnregisteredEvent: _handleUnregisteredEvent,
      onStateHandshake: _onStateHandshake,
    );
  }

  Future<void> close() async {
    return _signalingManager.close();
  }

  // Handles the service startup. This can occur under several scenarios:
  // - Launching from an FCM isolate.
  // - User enabling the socket type.
  // - Service being restarted.
  // - Automatic start during system boot.
  Future<void> onStart() async {
    _logger.info('Starting background call event service');
    return _signalingManager.launch();
  }

  void _handleHangupCall(HangupEvent event) async {
    try {
      _logger.info('Ending call: ${event.callId}');
      await _callkeep.endBackgroundCall(event.callId);
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleSignalingError(error, [StackTrace? stackTrace]) async {
    try {
      await _callkeep.endAllBackgroundCalls();
    } catch (e) {
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

  void _onStateHandshake(List<Line> lines) async {
    try {
      // // If there are no active lines (e.g., the caller canceled the call),
      // // and the call was triggered by a push notification, stop the signaling
      // // and terminate the isolate to free resources.
      // if (lines.length == _noActiveLines) {
      //   await _callkeep.endAllBackgroundCalls();
      // }

      if (lines.isEmpty) {
        await _callkeep.endAllBackgroundCalls();
        return;
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
              _logger.info('Hang up request for call ID: ${callEvent.callId}');
              await _signalingManager.hangUpRequest(callEvent.callId);
              return;
            }

            // Handle incoming calls. If the event is `IncomingCallEvent`, send a decline request to update the signaling state accordingly.
            if (callEvent is IncomingCallEvent) {
              _logger.info('Decline request for call ID: ${callEvent.callId}');
              await _signalingManager.declineRequest(callEvent.callId);

              return;
            }
          } else {
            _logger.info('Connection state is not disconnected');
          }
        } else {
          _logger.info('No call event found');
        }

        // Process all remaining call events for the line, regardless of the connection state.
        // This includes events where the connection is `stateDisconnected`.
        for (var event in activeLine.callLogs.whereType<CallEventLog>().map((log) => log.callEvent)) {
          _logger.info('Handling event: $event');
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
    return _signalingManager.declineRequest(callId);
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
