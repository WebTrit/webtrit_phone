import 'dart:async';

import 'package:flutter/material.dart';

import 'package:clock/clock.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';
import '../view/call_screen_style.dart';

/// The focused call's central info block: name/number, the call description or
/// live duration, and the fine-grained processing status. Connection status,
/// network quality and ICE failures live on the toolbar status line
/// ([CallToolbarStatus]), not here.
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
  final CallInfoStyle? style;

  @override
  State<CallInfo> createState() => _CallInfoState();
}

class _CallInfoState extends State<CallInfo> {
  Timer? durationTimer;
  Duration? duration;

  @override
  void initState() {
    super.initState();
    final acceptedTime = widget.acceptedTime;
    if (acceptedTime != null) {
      _durationTimerInit(acceptedTime);
    }
  }

  @override
  void didUpdateWidget(CallInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
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
        Text(statusMessage, style: statusTextStyle),
        if (processingStatus != null)
          Text(processingStatus, style: processingStatusTextStyle, textAlign: TextAlign.center),
      ],
    );
  }

  String _buildStatusMessage(BuildContext context) {
    final duration = this.duration;

    if (duration == null) {
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
