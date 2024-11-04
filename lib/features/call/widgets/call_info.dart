import 'dart:async';

import 'package:flutter/material.dart';

import 'package:clock/clock.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';

class CallInfo extends StatefulWidget {
  const CallInfo({
    super.key,
    required this.transfering,
    required this.requestToAttendedTransfer,
    required this.inviteToAttendedTransfer,
    required this.isIncoming,
    required this.held,
    required this.username,
    this.acceptedTime,
    this.color,
    this.activeCallStatus,
  });

  final bool transfering;
  final bool requestToAttendedTransfer;
  final bool inviteToAttendedTransfer;
  final bool isIncoming;
  final bool held;
  final String username;
  final DateTime? acceptedTime;
  final Color? color;
  final ActiveCallStatus? activeCallStatus;

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
    final duration = this.duration;

    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;

    final statusStyle = textTheme.labelLarge!.copyWith(color: themeData.colorScheme.surface);

    final String statusMessage;
    if (duration == null) {
      if (widget.inviteToAttendedTransfer) {
        statusMessage = context.l10n.call_description_inviteToAttendedTransfer;
      } else if (widget.requestToAttendedTransfer) {
        statusMessage = context.l10n.call_description_requestToAttendedTransfer;
      } else if (widget.isIncoming) {
        statusMessage = context.l10n.call_description_incoming;
      } else {
        statusMessage = context.l10n.call_description_outgoing;
      }
    } else if (widget.transfering) {
      statusMessage = context.l10n.call_description_transferProcessing;
    } else if (widget.held) {
      statusMessage = context.l10n.call_description_held;
    } else {
      statusMessage = duration.format();
    }

    return Column(
      children: [
        Text(
          widget.username,
          style: textTheme.displaySmall!.copyWith(color: widget.color),
          textAlign: TextAlign.center,
        ),
        Text(
          statusMessage,
          style: textTheme.bodyMedium!.copyWith(
            color: widget.color,
            fontFeatures: [
              const FontFeature.tabularFigures(),
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (widget.activeCallStatus != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              widget.activeCallStatus!.l10n(context),
              style: statusStyle,
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
