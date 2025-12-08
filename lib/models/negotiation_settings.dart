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
  const NegotiationSettings({this.includeInactiveVideoInOfferAnswer = false});

  /// Whether the callee should include an inactive video track in the answer SDP.
  final bool includeInactiveVideoInOfferAnswer;

  factory NegotiationSettings.blank() => const NegotiationSettings();

  NegotiationSettings copyWith({bool? includeInactiveVideoInOfferAnswer}) {
    return NegotiationSettings(
      includeInactiveVideoInOfferAnswer: includeInactiveVideoInOfferAnswer ?? this.includeInactiveVideoInOfferAnswer,
    );
  }

  @override
  List<Object?> get props => [includeInactiveVideoInOfferAnswer];

  @override
  String toString() => 'NegotiationSettings(includeInactiveTrack: $includeInactiveVideoInOfferAnswer)';
}
