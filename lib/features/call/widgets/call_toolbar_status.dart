import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';
import '../view/call_screen_style.dart';
import 'call_network_quality_meter.dart';

/// The call screen toolbar status line (lives in the AppBar title slot).
///
/// Global, never tied to a call row. Shows ONE indicator at a time, by
/// priority:
/// 1. signaling state - "No internet connection" / "Not registered" (coral
///    static dot), or "Connecting..." / "Reconnecting..." (amber pulsing dot;
///    Reconnecting once a connection has existed before);
/// 2. a real media failure ([IceConnectionIssue]) - warning glyph + message;
/// 3. media degradation ([CallNetworkQuality], worst across calls) - signal
///    bars + direction arrow + an always-visible label.
/// Renders nothing while everything is healthy. Status flaps during reconnect
/// backoff are debounced the same way the old in-info message was.
class CallToolbarStatus extends StatefulWidget {
  const CallToolbarStatus({
    super.key,
    required this.callStatus,
    this.networkQuality,
    this.iceConnectionIssue,
    this.style,
  });

  final CallStatus callStatus;
  final CallNetworkQuality? networkQuality;
  final IceConnectionIssue? iceConnectionIssue;
  final CallInfoStyle? style;

  @override
  State<CallToolbarStatus> createState() => _CallToolbarStatusState();
}

class _CallToolbarStatusState extends State<CallToolbarStatus> {
  late final TransientDebouncer<CallStatus> _debouncer;

  /// Whether the signaling connection has been up at least once: turns the
  /// transient "Connecting..." label into "Reconnecting...".
  late bool _everConnected;

  @override
  void initState() {
    super.initState();
    _everConnected = widget.callStatus == CallStatus.ready;
    _debouncer = TransientDebouncer<CallStatus>(
      initial: widget.callStatus,
      duration: kSignalingStatusDebounce,
      isTransient: (s) => s.isTransientReconnecting,
      getLatest: () => widget.callStatus,
    );
  }

  @override
  void didUpdateWidget(covariant CallToolbarStatus oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.callStatus == CallStatus.ready) _everConnected = true;
    if (widget.callStatus != oldWidget.callStatus) {
      _debouncer.update(widget.callStatus, () => setState(() {}));
    }
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final baseStyle =
        widget.style?.callStatus ?? themeData.textTheme.bodyMedium?.copyWith(color: themeData.colorScheme.surface);
    final baseColor = baseStyle?.color ?? themeData.colorScheme.surface;
    final semantic = themeData.extension<SnackBarStyles>()?.primary;
    final warningColor = semantic?.warningBackgroundColor ?? baseColor;
    final errorColor = semantic?.errorBackgroundColor ?? themeData.colorScheme.error;

    final status = _debouncer.displayed;
    final quality = widget.networkQuality;
    final iceConnectionIssue = widget.iceConnectionIssue;

    final Widget content;
    if (status != CallStatus.ready) {
      // Connecting/Reconnecting are one transient amber state; "no internet"
      // and "not registered" are hard states with a coral dot.
      final transient = status.isTransientReconnecting;
      final dotColor = transient ? warningColor : errorColor;
      final message = switch (status) {
        _ when transient =>
          _everConnected ? context.l10n.call_ToolbarStatus_reconnecting : context.l10n.call_ToolbarStatus_connecting,
        _ => status.l10n(context),
      };
      content = Row(
        key: const ValueKey('toolbar-connect'),
        mainAxisSize: MainAxisSize.min,
        children: [
          _StatusDot(color: dotColor, pulsing: transient),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              message,
              style: baseStyle?.copyWith(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else if (iceConnectionIssue != null) {
      content = Row(
        key: const ValueKey('toolbar-ice'),
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded, size: 14, color: errorColor),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              iceConnectionIssue.l10n(context),
              style: baseStyle?.copyWith(color: errorColor, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else if (quality != null) {
      final labelColor = quality.recovered
          ? (semantic?.successBackgroundColor ?? baseColor)
          : (quality.severity == CallNetworkQualitySeverity.mild ? baseColor : warningColor);
      content = Row(
        key: const ValueKey('toolbar-quality'),
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bars + direction arrow only; the label already says audio/video.
          CallNetworkQualityMeter(quality: quality, baseColor: baseColor, showLabel: false, showMediaGlyph: false),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              quality.severeLabel(context),
              style: baseStyle?.copyWith(color: labelColor, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else {
      content = const SizedBox.shrink(key: ValueKey('toolbar-none'));
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: content,
    );
  }
}

/// The 8px signaling-state dot; pulses (opacity breathing) for the transient
/// Connecting/Reconnecting state and stays solid for hard states.
class _StatusDot extends StatefulWidget {
  const _StatusDot({required this.color, required this.pulsing});

  final Color color;
  final bool pulsing;

  @override
  State<_StatusDot> createState() => _StatusDotState();
}

class _StatusDotState extends State<_StatusDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _syncPulse();
  }

  @override
  void didUpdateWidget(covariant _StatusDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pulsing != oldWidget.pulsing) _syncPulse();
  }

  void _syncPulse() {
    if (widget.pulsing) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 1,
        end: 0.35,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color),
      ),
    );
  }
}
