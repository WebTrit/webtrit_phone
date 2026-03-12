import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

import 'call_error_reporter.dart';
import 'sdp_munger.dart';

final _logger = Logger('RenegotiationHandler');

/// Callback responsible for sending the renegotiation offer to the remote peer
/// via the signaling channel. The caller constructs the transport-specific
/// request; this handler stays decoupled from the signaling layer.
typedef RenegotiationExecutor = Future<void> Function(String callId, int? lineId, RTCSessionDescription jsep);

/// Handles WebRTC renegotiation triggered by [RTCPeerConnection.onRenegotiationNeeded].
///
/// ## Architecture constraints
///
/// This handler is designed for a **server-mediated** topology (e.g. Janus SFU)
/// where offer/answer exchanges are serialised by the media server.
/// Glare (simultaneous offers from both peers) cannot occur in this topology,
/// so the simplified skip-on-non-stable strategy is sufficient and safe.
///
/// **P2P note:** in a direct peer-to-peer topology, simultaneous offers from
/// both sides are possible. The current skip logic would silently drop one of
/// the offers. Full [Perfect Negotiation](https://www.w3.org/TR/webrtc/#perfect-negotiation-example)
/// with rollback must be implemented before removing the media server.
///
/// ## Stable-state guards
///
/// Two checks enforce the RTCPeerConnection state machine rules
/// (RFC 8829 §4, W3C WebRTC §4.7):
///
/// 1. **Before `createOffer`** — skips if the current signaling state is not
///    `stable`. In a server-mediated call the skipped renegotiation is safe:
///    if the event was triggered by an incoming remote offer
///    (e.g. [CalleeVideoOfferPolicy.includeInactiveTrack]), the pending track
///    will already be included in the answer; if it was triggered by a genuine
///    local change, libwebrtc will re-fire [onRenegotiationNeeded] once the
///    peer connection returns to `stable`.
///
/// 2. **After `createOffer` (TOCTOU guard)** — re-checks the state before
///    calling `setLocalDescription`. The `await createOffer()` yields control
///    to the event loop; a concurrent signaling event may transition the
///    connection out of `stable` in the meantime.
class RenegotiationHandler {
  RenegotiationHandler({required this.callErrorReporter, this.sdpMunger});

  final CallErrorReporter callErrorReporter;
  final SDPMunger? sdpMunger;

  /// Executes a renegotiation cycle for [callId] on [peerConnection].
  ///
  /// Skips silently when the signaling state is not `stable` (see class-level
  /// doc). All WebRTC and signaling errors are forwarded to [callErrorReporter]
  /// and do not propagate to the caller.
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
