import 'dart:async';

import 'package:flutter/material.dart';

import 'package:clock/clock.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';
import '../view/call_screen_style.dart';

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

// TODO(Serdun): Rename class to better represent the actual data it holds
  final CallStatus callStatus;

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
    final color = themeData.colorScheme.surface;

    final userInfoTextStyle = _resolveTextStyle(widget.style?.userInfo, textTheme.displaySmall, color);
    final numberTextStyle = _resolveTextStyle(widget.style?.number, textTheme.bodyLarge, color);
    final callStatusTextStyle = _resolveTextStyle(widget.style?.callStatus, textTheme.bodyMedium, color);
    final processingStatusTextStyle = _resolveTextStyle(widget.style?.processingStatus, textTheme.labelLarge, color);

    final statusMessage = _buildStatusMessage(context);

    return Column(
      children: [
        if (widget.username != null) ...[
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
        ],
        if (widget.username == null)
          Text(
            widget.number,
            style: userInfoTextStyle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        const SizedBox(height: 10),
        Text(
          statusMessage,
          style: callStatusTextStyle,
        ),
        const SizedBox(height: 10),
        if (widget.processingStatus != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              widget.processingStatus!.l10n(context),
              style: processingStatusTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  String _buildStatusMessage(BuildContext context) {
    final duration = this.duration;

    if (widget.callStatus != CallStatus.ready) {
      return widget.callStatus.l10n(context);
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

  TextStyle? _resolveTextStyle(TextStyle? customStyle, TextStyle? fallback, Color color) {
    return customStyle ?? fallback?.copyWith(color: color);
  }
}
