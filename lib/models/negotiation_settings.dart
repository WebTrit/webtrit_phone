import 'package:equatable/equatable.dart';

/// Defines policies related to media negotiation behavior during call renegotiation.
///
/// Specifically, [NegotiationSettings] determines how the callee should handle
/// an offer that includes a video media section (m=video).
///
/// This is especially useful in scenarios where video is dynamically added during a call.
/// Some endpoints (e.g., media servers or specific SIP infrastructures) expect that the callee
/// responds with a matching video track—even if inactive—to fully complete the SDP negotiation.
///
/// Without including the video track in the response, the offer/answer negotiation may fail
/// or lead to a one-way media issue (e.g., the caller sends video, but the callee does not properly receive or acknowledge it).
class NegotiationSettings extends Equatable {
  const NegotiationSettings({
    this.calleeVideoOfferPolicy = CalleeVideoOfferPolicy.ignore,
  });

  /// Determines how the callee should respond to an offer with video.
  final CalleeVideoOfferPolicy calleeVideoOfferPolicy;

  factory NegotiationSettings.blank() => const NegotiationSettings();

  NegotiationSettings copyWith({
    CalleeVideoOfferPolicy? calleeVideoOfferPolicy,
  }) {
    return NegotiationSettings(
      calleeVideoOfferPolicy: calleeVideoOfferPolicy ?? this.calleeVideoOfferPolicy,
    );
  }

  @override
  List<Object?> get props => [calleeVideoOfferPolicy];

  @override
  String toString() => 'NegotiationSettings(calleeVideoOfferPolicy: $calleeVideoOfferPolicy)';
}

/// Defines how the callee responds to a renegotiation offer that includes a video section.
///
/// - [ignore]: The callee does not attach any video track. This may lead to incomplete negotiation,
///   especially with certain signaling servers or peers that require symmetric media lines.
///
/// - [includeInactiveTrack]: The callee adds a full but inactive video track to the peer connection
///   and includes it in the SDP answer. This allows the caller to successfully negotiate video,
///   even if the callee does not immediately intend to send media. It also helps avoid errors like
///   "setRemoteDescription failed" or "no matching media section found" on the caller side.
enum CalleeVideoOfferPolicy {
  /// Ignore  video offer, do not attach any video track.
  ignore,

  /// Attach a full but inactive video track in response to video offer.
  includeInactiveTrack,
}
