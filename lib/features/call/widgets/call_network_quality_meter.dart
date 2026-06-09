import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';

/// Compact, icon-only signal meter surfaced beside the call timer when Janus
/// `slowlink` events indicate the media is degrading (before a hard failure).
///
/// Encodes the slowlink fields: bar count + color = severity, an up/down arrow =
/// uplink (your) vs downlink (their), and a mic/camera glyph = audio vs video.
/// At [CallNetworkQualitySeverity.severe] it also shows a short text label. When
/// the stream recovers it briefly renders a green "stable" confirmation before
/// the bloc clears it.
class CallNetworkQualityMeter extends StatelessWidget {
  const CallNetworkQualityMeter({super.key, required this.quality, this.baseColor});

  final CallNetworkQuality quality;

  /// Color for the mild bars and inactive bar slots; defaults to the ambient
  /// text color so the meter blends with the call timer.
  final Color? baseColor;

  // Severity palette. These intentionally live outside the Material ColorScheme
  // because it has no amber/orange "warning" semantic role. Coral/red stays
  // reserved for real failures (IceConnectionIssue) and is never used here.
  static const _amber = Color(0xFFFFB300);
  static const _orange = Color(0xFFF95A14);
  static const _green = Color(0xFF75B943);

  static const double _glyphSize = 14;

  @override
  Widget build(BuildContext context) {
    final base = baseColor ?? DefaultTextStyle.of(context).style.color ?? Theme.of(context).colorScheme.onSurface;

    if (quality.recovered) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SignalBars(active: 3, activeColor: _green, inactiveColor: _green),
          const SizedBox(width: 4),
          const Icon(Icons.check, size: _glyphSize, color: _green),
        ],
      );
    }

    final (int activeBars, Color color) = switch (quality.severity) {
      CallNetworkQualitySeverity.mild => (3, base),
      CallNetworkQualitySeverity.moderate => (2, _amber),
      CallNetworkQualitySeverity.severe => (1, _orange),
    };

    final directionIcon = quality.uplink ? Icons.north : Icons.south;
    final mediaIcon = quality.media == CallMediaKind.video ? Icons.videocam : Icons.mic;
    final showLabel = quality.severity == CallNetworkQualitySeverity.severe;

    // The meter sits on its own centered line below the timer, so it may carry
    // the descriptive label (at severe) without shifting the timer sideways.
    return Semantics(
      label: quality.severeLabel(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SignalBars(active: activeBars, activeColor: color, inactiveColor: base.withValues(alpha: 0.3)),
          const SizedBox(width: 4),
          Icon(directionIcon, size: _glyphSize, color: color),
          Icon(mediaIcon, size: _glyphSize, color: color),
          if (showLabel) ...[
            const SizedBox(width: 4),
            Text(
              quality.severeLabel(context),
              style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ],
      ),
    );
  }
}

class _SignalBars extends StatelessWidget {
  const _SignalBars({required this.active, required this.activeColor, required this.inactiveColor});

  /// Number of bars (1..3) rendered in [activeColor]; the rest use [inactiveColor].
  final int active;
  final Color activeColor;
  final Color inactiveColor;

  static const _heights = [5.0, 8.0, 11.0];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < _heights.length; i++) ...[
          if (i > 0) const SizedBox(width: 2),
          Container(
            width: 3,
            height: _heights[i],
            decoration: BoxDecoration(
              color: i < active ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ],
    );
  }
}
