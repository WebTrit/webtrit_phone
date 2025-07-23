import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_phone/features/call/models/models.dart';

class WebRTCStateManager {
  final Map<String, List<RenegotiationRequest>> _renegotiationQueues = {};
  final Map<String, RTCSignalingState?> _lastKnownStates = {};
  final Map<String, Timer?> _retryTimers = {};
  final Logger _logger = Logger('WebRTCStateManager');

  static const Duration _retryDelay = Duration(milliseconds: 500);
  static const Duration _maxQueueAge = Duration(seconds: 10);

  bool canPerformRenegotiation(String callId, RTCSignalingState? currentState) {
    _lastKnownStates[callId] = currentState;

    // Only allow renegotiation in stable state
    final canRenegotiate = currentState == RTCSignalingState.RTCSignalingStateStable;

    _logger.info('🔍 WEBRTC_STATE: canPerformRenegotiation - callId: $callId, '
        'state: $currentState, canRenegotiate: $canRenegotiate');

    return canRenegotiate;
  }

  Future<void> queueRenegotiation(String callId, int? lineId) async {
    final request = RenegotiationRequest(
      callId: callId,
      lineId: lineId,
      timestamp: DateTime.now(),
      completer: Completer<void>(),
    );

    _renegotiationQueues.putIfAbsent(callId, () => []).add(request);

    _logger.info('🔄 WEBRTC_QUEUE: Queued renegotiation - callId: $callId, '
        'queue length: ${_renegotiationQueues[callId]?.length ?? 0}');

    return request.completer.future;
  }

  void processQueue(String callId, RTCSignalingState? currentState,
      {Future<void> Function(String, int?)? performRenegotiation}) {
    final queue = _renegotiationQueues[callId];
    if (queue == null || queue.isEmpty) return;

    _logger.info('🔄 WEBRTC_QUEUE: Processing queue - callId: $callId, '
        'state: $currentState, queue length: ${queue.length}');

    // Clean expired requests
    queue.removeWhere((request) {
      final isExpired = DateTime.now().difference(request.timestamp) > _maxQueueAge;
      if (isExpired) {
        _logger.warning('⏰ WEBRTC_QUEUE: Removing expired request - callId: $callId');
        request.completer.completeError(TimeoutException('Renegotiation request expired'));
      }
      return isExpired;
    });

    if (!canPerformRenegotiation(callId, currentState)) {
      _logger.info('⏸️ WEBRTC_QUEUE: Cannot process queue - invalid state: $currentState');
      return;
    }

    // Process first request in queue
    if (queue.isNotEmpty) {
      final request = queue.removeAt(0);
      _logger.info('▶️ WEBRTC_QUEUE: Processing request - callId: $callId, '
          'retry count: ${request.retryCount}');

      if (performRenegotiation != null) {
        // Execute the actual renegotiation
        performRenegotiation(callId, request.lineId).then((_) {
          request.completer.complete();
        }).catchError((error) {
          request.completer.completeError(error);
        });
      } else {
        // Fallback: just complete the request
        request.completer.complete();
      }
    }
  }

  void retryFailedRenegotiation(String callId, int? lineId, Object error,
      {Future<void> Function(String, int?)? performRenegotiation}) {
    final queue = _renegotiationQueues[callId];
    if (queue == null) return;

    // Find the most recent failed request (should be processed but not completed)
    final currentState = _lastKnownStates[callId];

    _logger.warning('🔄 WEBRTC_RETRY: Scheduling retry - callId: $callId, '
        'error: $error, current state: $currentState');

    _retryTimers[callId]?.cancel();
    _retryTimers[callId] = Timer(_retryDelay, () {
      _logger.info('🔄 WEBRTC_RETRY: Executing retry - callId: $callId');
      processQueue(callId, _lastKnownStates[callId]);
    });
  }

  void clearCall(String callId) {
    _logger.info('🧹 WEBRTC_QUEUE: Clearing call data - callId: $callId');

    final queue = _renegotiationQueues[callId];
    if (queue != null) {
      // Complete all pending requests with error
      for (final request in queue) {
        if (!request.completer.isCompleted) {
          request.completer.completeError('Call ended');
        }
      }
    }

    _renegotiationQueues.remove(callId);
    _lastKnownStates.remove(callId);
    _retryTimers[callId]?.cancel();
    _retryTimers.remove(callId);
  }

  void dispose() {
    _logger.info('🧹 WEBRTC_QUEUE: Disposing state manager');

    for (final timer in _retryTimers.values) {
      timer?.cancel();
    }

    for (final queue in _renegotiationQueues.values) {
      for (final request in queue) {
        if (!request.completer.isCompleted) {
          request.completer.completeError('State manager disposed');
        }
      }
    }

    _renegotiationQueues.clear();
    _lastKnownStates.clear();
    _retryTimers.clear();
  }
}
