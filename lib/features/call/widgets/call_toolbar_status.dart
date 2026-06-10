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
/// Shows ONE global indicator at a time, by priority:
/// 1. signaling/connectivity trouble - red dot + status + "Reconnecting...";
/// 2. a real media failure ([IceConnectionIssue]) - warning glyph + message;
/// 3. media degradation ([CallNetworkQuality], worst across calls) - the
///    signal meter + an always-visible label.
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

  @override
  void initState() {
    super.initState();
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
      content = Row(
        key: const ValueKey('toolbar-connect'),
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: errorColor),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              status.l10n(context),
              style: baseStyle?.copyWith(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (status != CallStatus.appUnregistered) ...[
            Text(' - ', style: baseStyle),
            Text(
              context.l10n.call_ToolbarStatus_reconnecting,
              style: baseStyle?.copyWith(color: baseColor.withValues(alpha: 0.7)),
            ),
          ],
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
          CallNetworkQualityMeter(quality: quality, baseColor: baseColor, showLabel: false),
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
