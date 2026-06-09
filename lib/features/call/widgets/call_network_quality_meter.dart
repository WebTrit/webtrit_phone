import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';

/// Compact signal meter shown on its own line below the call timer when Janus
/// `slowlink` events indicate the media is degrading (before a hard failure).
///
/// Encodes the slowlink fields: bar count + color = severity, an up/down arrow =
/// uplink (your) vs downlink (their), and a mic/camera glyph = audio vs video.
/// At [CallNetworkQualitySeverity.severe] it also shows a short text label. When
/// the stream recovers it briefly renders a green "stable" confirmation before
/// the bloc clears it.
///
/// State changes are morphed in place (bar colors tween, the row resizes) rather
/// than cross-faded, so only appearing/disappearing fades; switching severity or
/// direction does not flicker.
class CallNetworkQualityMeter extends StatelessWidget {
  const CallNetworkQualityMeter({super.key, required this.quality, this.baseColor});

  final CallNetworkQuality quality;

  /// Color for the mild bars and inactive bar slots; defaults to the ambient
  /// text color so the meter blends with the call timer.
  final Color? baseColor;

  static const double _glyphSize = 14;
  static const _morph = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final base = baseColor ?? DefaultTextStyle.of(context).style.color ?? colorScheme.onSurface;

    // Severity colors come from the theme's semantic palette (SnackBarStyles:
    // warning = degrading, success = recovered), with ColorScheme fallbacks.
    // Coral/error stays reserved for real failures (IceConnectionIssue).
    final semantic = themeData.extension<SnackBarStyles>()?.primary;
    final warningColor = semantic?.warningBackgroundColor ?? base;
    final successColor = semantic?.successBackgroundColor ?? colorScheme.tertiary;

    final Widget content;
    if (quality.recovered) {
      content = Row(
        key: const ValueKey('recovered'),
        mainAxisSize: MainAxisSize.min,
        children: [
          _SignalBars(active: 3, activeColor: successColor, inactiveColor: successColor),
          const SizedBox(width: 4),
          Icon(Icons.check, size: _glyphSize, color: successColor),
        ],
      );
    } else {
      final (int activeBars, Color color) = switch (quality.severity) {
        CallNetworkQualitySeverity.mild => (3, base),
        CallNetworkQualitySeverity.moderate => (2, warningColor),
        CallNetworkQualitySeverity.severe => (1, warningColor),
      };
      final directionIcon = quality.uplink ? Icons.north : Icons.south;
      final mediaIcon = quality.media == CallMediaKind.video ? Icons.videocam : Icons.mic;
      final showLabel = quality.severity == CallNetworkQualitySeverity.severe;

      content = Row(
        key: const ValueKey('active'),
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
      );
    }

    // AnimatedSize smooths the in-place width/height changes (label appearing,
    // recovered swap); bar colors tween via AnimatedContainer. No whole-widget
    // cross-fade -- that is reserved for the show/hide handled by the parent.
    return Semantics(
      label: quality.severeLabel(context),
      child: AnimatedSize(duration: _morph, curve: Curves.easeInOut, child: content),
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
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
