import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

import 'call_error_reporter.dart';
import 'sdp_munger.dart';

final _logger = Logger('RenegotiationHandler');

typedef RenegotiationExecutor = Future<void> Function(String callId, int? lineId, RTCSessionDescription jsep);

class RenegotiationHandler {
  RenegotiationHandler({required this.callErrorReporter, this.sdpMunger});

  final CallErrorReporter callErrorReporter;
  final SDPMunger? sdpMunger;

  Future<void> handle(
    String callId,
    int? lineId,
    RTCPeerConnection peerConnection,
    RenegotiationExecutor execute,
  ) async {
    final stateBeforeOffer = peerConnection.signalingState;
    _logger.fine(() => 'onRenegotiationNeeded signalingState: $stateBeforeOffer');
    if (stateBeforeOffer != RTCSignalingState.RTCSignalingStateStable) {
      _logger.fine(() => 'onRenegotiationNeeded skipped: not in stable state ($stateBeforeOffer)');
      return;
    }

    try {
      final localDescription = await peerConnection.createOffer({});
      sdpMunger?.apply(localDescription);

      final stateAfterOffer = peerConnection.signalingState;
      if (stateAfterOffer != RTCSignalingState.RTCSignalingStateStable) {
        _logger.fine(
          () =>
              'onRenegotiationNeeded: state changed to $stateAfterOffer after createOffer, skipping setLocalDescription',
        );
        return;
      }

      // According to RFC 8829 5.6 (https://datatracker.ietf.org/doc/html/rfc8829#section-5.6),
      // localDescription should be set before sending the offer to transition into have-local-offer state.
      await peerConnection.setLocalDescription(localDescription);

      await execute(callId, lineId, localDescription);
    } catch (e, s) {
      callErrorReporter.handle(e, s, 'RenegotiationHandler.handle error (callId=$callId, lineId=$lineId)');
    }
  }
}
