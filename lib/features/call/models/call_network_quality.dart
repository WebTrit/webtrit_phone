import 'package:equatable/equatable.dart';

/// Which media stream a network-quality event refers to.
///
/// Kept independent from the signaling-layer `IceMediaType` so the call UI does
/// not depend on the wire format; mapped at the bloc boundary by value name.
enum CallMediaKind { audio, video }

/// Severity of a transient media degradation surfaced from Janus `slowlink`
/// events. Escalates with how often slowlink fires and how many packets are lost.
enum CallNetworkQualitySeverity {
  mild,
  moderate,
  severe;

  /// Heuristic mapping from slowlink signals to a severity bucket. [hits] is how
  /// many slowlink events have fired for the call in the current burst; [lost]
  /// is the packet-loss count of the latest event. Thresholds are intentionally
  /// conservative and should be tuned against QA on the local stack.
  static CallNetworkQualitySeverity fromSlowlink({required int hits, required int lost}) {
    if (hits >= 5 || lost >= 30) return severe;
    if (hits >= 2 || lost >= 10) return moderate;
    return mild;
  }
}

/// Transient "network is degrading" state for an active call.
///
/// Set when `slowlink` events arrive (before a hard ICE failure) and cleared
/// automatically once they stop. Distinct from [IceConnectionIssue], which marks
/// an actual connection failure; the two never show together.
class CallNetworkQuality extends Equatable {
  const CallNetworkQuality({required this.severity, required this.uplink, required this.media, this.recovered = false});

  final CallNetworkQualitySeverity severity;

  /// true  -> your outgoing stream is degrading (uplink).
  /// false -> the remote incoming stream is degrading (downlink).
  final bool uplink;

  /// Which stream is affected: audio or video.
  final CallMediaKind media;

  /// Brief "stable again" confirmation shown right before the indicator
  /// auto-hides. While true the meter renders its recovered (green) state.
  final bool recovered;

  CallNetworkQuality copyWith({
    CallNetworkQualitySeverity? severity,
    bool? uplink,
    CallMediaKind? media,
    bool? recovered,
  }) {
    return CallNetworkQuality(
      severity: severity ?? this.severity,
      uplink: uplink ?? this.uplink,
      media: media ?? this.media,
      recovered: recovered ?? this.recovered,
    );
  }

  @override
  List<Object?> get props => [severity, uplink, media, recovered];
}
