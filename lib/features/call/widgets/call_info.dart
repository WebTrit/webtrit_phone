import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:clock/clock.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class CallInfo extends StatefulWidget {
  const CallInfo({
    Key? key,
    required this.isIncoming,
    required this.username,
    this.acceptedTime,
    this.color,
  }) : super(key: key);

  final bool isIncoming;
  final String username;
  final DateTime? acceptedTime;
  final Color? color;

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
    return Column(
      children: [
        Text(
          widget.isIncoming ? context.l10n.call_description_incoming : context.l10n.call_description_outgoing,
          style: textTheme.bodyLarge!.copyWith(color: widget.color),
        ),
        Text(
          widget.username,
          style: textTheme.displaySmall!.copyWith(color: widget.color),
        ),
        if (duration != null)
          Text(
            duration.format(),
            style: textTheme.bodyMedium!.copyWith(
              color: widget.color,
              fontFeatures: [
                const FontFeature.tabularFigures(),
              ],
            ),
          ),
      ],
    );
  }
}
