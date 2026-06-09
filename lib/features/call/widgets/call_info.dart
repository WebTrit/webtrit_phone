import 'dart:async';

import 'package:flutter/material.dart';

import 'package:clock/clock.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';
import '../view/call_screen_style.dart';
import 'call_network_quality_meter.dart';

class CallInfo extends StatefulWidget {
  const CallInfo({
    super.key,
    required this.transfering,
    required this.requestToAttendedTransfer,
    required this.inviteToAttendedTransfer,
    required this.isIncoming,
    required this.held,
    required this.number,
    this.username,
    this.acceptedTime,
    this.processingStatus,
    required this.callStatus,
    this.iceConnectionIssue,
    this.networkQuality,
    required this.style,
  });

  final bool transfering;
  final bool requestToAttendedTransfer;
  final bool inviteToAttendedTransfer;
  final bool isIncoming;
  final bool held;
  final String number;
  final String? username;
  final DateTime? acceptedTime;
  final CallProcessingStatus? processingStatus;
  final IceConnectionIssue? iceConnectionIssue;
  final CallNetworkQuality? networkQuality;
  final CallInfoStyle? style;

  // TODO(Serdun): Rename class to better represent the actual data it holds
  final CallStatus callStatus;

  @override
  State<CallInfo> createState() => _CallInfoState();
}

class _CallInfoState extends State<CallInfo> {
  Timer? durationTimer;
  Duration? duration;

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
    final acceptedTime = widget.acceptedTime;
    if (acceptedTime != null) {
      _durationTimerInit(acceptedTime);
    }
  }

  @override
  void didUpdateWidget(CallInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.callStatus != oldWidget.callStatus) {
      _debouncer.update(widget.callStatus, () => setState(() {}));
    }
    if (widget.acceptedTime != oldWidget.acceptedTime) {
      _durationTimerCancel();
      final acceptedTime = widget.acceptedTime;
      if (acceptedTime != null) {
        _durationTimerInit(acceptedTime);
      }
    }
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _durationTimerCancel();
    super.dispose();
  }

  void _durationTimerInit(DateTime acceptedTime) {
    durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _durationTic(acceptedTime);
    });
    _durationTic(acceptedTime);
  }

  void _durationTimerCancel() {
    durationTimer?.cancel();
    durationTimer = null;
    duration = null;
  }

  void _durationTic(DateTime acceptedTime) {
    setState(() {
      duration = clock.now().difference(acceptedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;

    final fallbackColor = themeData.colorScheme.surface;
    final fallbackFontFeatures = [const FontFeature.tabularFigures()];
    final style = widget.style;

    final userInfoTextStyle = _resolveStyle(style?.userInfo, textTheme.displaySmall, null, fallbackColor);
    final numberTextStyle = _resolveStyle(style?.number, textTheme.bodyLarge, null, fallbackColor);
    final statusTextStyle = _resolveStyle(style?.callStatus, textTheme.bodyMedium, fallbackFontFeatures, fallbackColor);
    final processingStatusTextStyle = _resolveStyle(style?.processingStatus, textTheme.labelLarge, null, fallbackColor);

    final statusMessage = _buildStatusMessage(context);
    final processingStatus = widget.processingStatus?.l10n(context).nullify;
    final iceConnectionIssue = widget.iceConnectionIssue?.l10n(context).nullify;

    return Column(
      spacing: 8,
      children: [
        if (widget.username != null &&
            widget.username != widget.number &&
            (widget.number.contains(widget.username ?? '') == false)) ...[
          Text(
            widget.username!,
            style: userInfoTextStyle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.number,
            style: numberTextStyle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ] else
          Text(
            widget.number,
            style: userInfoTextStyle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        // Timer stays alone and centered; the network-quality meter lives on
        // its OWN centered line directly below it. Because it is a separate
        // centered line (not beside the timer), its width never pushes the
        // timer sideways. This AnimatedSwitcher only fades + grows it on
        // show/hide; state changes morph in place inside the meter. A real ICE
        // failure suppresses it (failure text owns the next line).
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(statusMessage, style: statusTextStyle),
            RepaintBoundary(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    axis: Axis.vertical,
                    alignment: Alignment.topCenter,
                    sizeFactor: animation,
                    child: child,
                  ),
                ),
                child: _buildMeterSlot(statusTextStyle?.color),
              ),
            ),
          ],
        ),
        if (processingStatus != null)
          Text(processingStatus, style: processingStatusTextStyle, textAlign: TextAlign.center)
        else if (iceConnectionIssue != null)
          Text(iceConnectionIssue, style: processingStatusTextStyle, textAlign: TextAlign.center),
      ],
    );
  }

  /// The animated-switcher child. Keyed only by PRESENCE (`meter` vs
  /// `meter-none`) so the parent AnimatedSwitcher fades only on show/hide; state
  /// changes (severity/direction/recovered) are morphed in place inside the
  /// meter instead of cross-faded. Hidden when healthy or when a real ICE
  /// failure owns the status line.
  Widget _buildMeterSlot(Color? baseColor) {
    final quality = widget.networkQuality;
    if (quality == null || widget.iceConnectionIssue != null) {
      return const SizedBox.shrink(key: ValueKey('meter-none'));
    }
    return CallNetworkQualityMeter(key: const ValueKey('meter'), quality: quality, baseColor: baseColor);
  }

  String _buildStatusMessage(BuildContext context) {
    final duration = this.duration;

    if (_debouncer.displayed != CallStatus.ready) {
      return _debouncer.displayed.l10n(context);
    } else if (duration == null) {
      if (widget.inviteToAttendedTransfer) {
        return context.l10n.call_description_inviteToAttendedTransfer;
      } else if (widget.requestToAttendedTransfer) {
        return context.l10n.call_description_requestToAttendedTransfer;
      } else if (widget.isIncoming) {
        return context.l10n.call_description_incoming;
      } else {
        return context.l10n.call_description_outgoing;
      }
    } else if (widget.transfering) {
      return context.l10n.call_description_transferProcessing;
    } else if (widget.held) {
      return context.l10n.call_description_held;
    } else {
      return duration.format();
    }
  }

  TextStyle? _resolveStyle(
    TextStyle? customStyle,
    TextStyle? fallback,
    List<FontFeature>? fallbackFontFeatures,
    Color fallbackColor,
  ) {
    return customStyle ?? fallback?.copyWith(color: fallbackColor, fontFeatures: fallbackFontFeatures);
  }
}
