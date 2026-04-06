import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'call_error_reporter.dart';
import 'pc_exceptions.dart';
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
///    to the event loop; a concurrent native callback may update the Dart-side
///    cached [RTCPeerConnection.signalingState] in that gap. If the check misses
///    a concurrent state change (stale cache), the [RtcJsepErrorParser] below is the
///    authoritative fallback.
///
/// ## Concurrency guard
///
/// [onRenegotiationNeeded] can fire multiple times in rapid succession (e.g.
/// libwebrtc re-fires it after a glare-rollback). Because [handle] is called
/// with `unawaited`, two concurrent cycles can overlap and both pass the
/// stable-state guard simultaneously — resulting in two competing offers and
/// a new glare condition.
///
/// The [_isHandling] flag serialises concurrent calls. If a cycle is already
/// in progress the new invocation sets [_pendingRetry] and returns immediately.
/// When the active cycle finishes it checks [_pendingRetry] and re-runs [handle]
/// with the latest parameters — ensuring no renegotiation is silently lost even
/// when libwebrtc does not re-fire [onRenegotiationNeeded] after the first cycle.
class RenegotiationHandler {
  RenegotiationHandler({required this.callErrorReporter, this.sdpMunger});

  final CallErrorReporter callErrorReporter;
  final SDPMunger? sdpMunger;

  bool _isHandling = false;
  bool _pendingRetry = false;

  /// Executes a renegotiation cycle for [callId] on [peerConnection].
  ///
  /// Serialises concurrent invocations via [_isHandling]/[_pendingRetry] (see
  /// class-level doc). Skips silently when the signaling state is not `stable`.
  /// Transient wrong-state errors from [RTCPeerConnection.setLocalDescription]
  /// are logged at WARNING and do not escalate to [callErrorReporter].
  /// All other errors are forwarded to [callErrorReporter].
  Future<void> handle(
    String callId,
    int? lineId,
    RTCPeerConnection peerConnection,
    RenegotiationExecutor execute,
  ) async {
    if (_isHandling) {
      _logger.fine(() => 'onRenegotiationNeeded: queued retry — already handling a renegotiation cycle for $callId');
      _pendingRetry = true;
      return;
    }
    _isHandling = true;
    _pendingRetry = false;
    try {
      try {
        final stateBeforeOffer = peerConnection.signalingState;
        _logger.fine(() => 'onRenegotiationNeeded signalingState: $stateBeforeOffer');
        // null means the Dart-side cache has not yet been populated by a native
        // onSignalingStateChange callback (flutter_webrtc lazily updates the
        // field). A brand-new RTCPeerConnection always starts in the native
        // "stable" state, so null is treated as stable here. Every other
        // non-stable state will be a concrete enum value, not null.
        if (stateBeforeOffer != null && stateBeforeOffer != RTCSignalingState.RTCSignalingStateStable) {
          _logger.fine(() => 'onRenegotiationNeeded skipped: not in stable state ($stateBeforeOffer)');
          return;
        }

        final localDescription = await peerConnection.createOffer({});
        sdpMunger?.apply(localDescription);
        _logger.info(() => 'onRenegotiationNeeded offer SDP (callId=$callId):\n${localDescription.sdp}');

        final stateAfterOffer = peerConnection.signalingState;
        // Same null-as-stable reasoning as the pre-offer guard: if the Dart
        // cache has not been updated by a native callback yet, the PC is still
        // in its initial stable state and it is safe to proceed.
        if (stateAfterOffer != null && stateAfterOffer != RTCSignalingState.RTCSignalingStateStable) {
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
      } on String catch (e) {
        throw RtcJsepErrorParser.parse(e);
      }
    } on WebtritSignalingErrorException catch (e) {
      _logger.warning(
        () => 'onRenegotiationNeeded: UpdateRequest rejected by server (callId=$callId, lineId=$lineId): $e',
      );
      callErrorReporter.handle(e, null, 'RenegotiationHandler.handle error (callId=$callId, lineId=$lineId)');
    } on PCWrongSignalingState catch (e) {
      // flutter_webrtc surfaces native errors as plain strings. A "wrong state" failure
      // on setLocalDescription means a concurrent setRemoteDescription (e.g. from an
      // incoming updating_call) moved the PC out of stable between the TOCTOU guard and
      // the setLocalDescription call. This is a transient race — libwebrtc keeps the
      // [[NegotiationNeeded]] flag set and will re-fire onRenegotiationNeeded once the
      // PC returns to stable. No user notification is needed.
      _logger.warning(
        () =>
            'onRenegotiationNeeded: setLocalDescription failed in wrong state (${e.message}) '
            '— libwebrtc will re-fire onRenegotiationNeeded when stable',
      );
    } catch (e, s) {
      callErrorReporter.handle(e, s, 'RenegotiationHandler.handle error (callId=$callId, lineId=$lineId)');
    } finally {
      _isHandling = false;
      if (_pendingRetry) {
        _pendingRetry = false;
        _logger.fine(() => 'onRenegotiationNeeded: running pending retry for $callId');
        unawaited(handle(callId, lineId, peerConnection, execute));
      }
    }
  }
}
