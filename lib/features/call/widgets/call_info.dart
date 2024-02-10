import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:clock/clock.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

enum CallFocus { active, inactive }

class CallInfo extends StatefulWidget {
  const CallInfo({
    super.key,
    this.focus,
    required this.status,
    required this.held,
    required this.username,
    this.onFocusLine,
    this.acceptedTime,
    this.color,
  });

  final String status;
  final CallFocus? focus;
  final bool held;
  final String username;
  final DateTime? acceptedTime;
  final Color? color;

  final VoidCallback? onFocusLine;

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

    final String statusMessage;
    if (duration == null) {
      statusMessage = widget.status;
    } else if (widget.held) {
      statusMessage = context.l10n.call_description_held;
    } else {
      statusMessage = duration.format();
    }

    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: widget.focus == null
            ? null
            : BoxDecoration(
                color: Colors.white.withOpacity(widget.focus == CallFocus.active ? 0.30 : 0.10),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
        child: Column(
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
          ],
        ),
      ),
      onTap: () => widget.onFocusLine?.call(),
    );
  }
}
