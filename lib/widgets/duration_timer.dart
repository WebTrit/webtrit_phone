import 'dart:async';
import 'dart:ui';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

class DurationTimer extends StatefulWidget {
  const DurationTimer({
    Key? key,
    required this.createdTime,
    this.textStyle,
  }) : super(key: key);

  final DateTime createdTime;
  final TextStyle? textStyle;

  @override
  State<DurationTimer> createState() => _DurationTimerState();
}

class _DurationTimerState extends State<DurationTimer> {
  Timer? durationTimer;
  Duration? duration;

  @override
  void initState() {
    _durationTimerInit(widget.createdTime);
    super.initState();
  }

  void _durationTimerInit(DateTime acceptedTime) {
    durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _durationTic(acceptedTime);
    });
    _durationTic(acceptedTime);
  }

  void _durationTic(DateTime acceptedTime) {
    setState(() {
      duration = clock.now().difference(acceptedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      duration!.format(),
      maxLines: 2,
      style: widget.textStyle ??
          theme.textTheme.bodySmall!.copyWith(fontFeatures: [
            const FontFeature.tabularFigures(),
          ], color: theme.colorScheme.background),
    );
  }

  @override
  void dispose() {
    durationTimer?.cancel();
    super.dispose();
  }
}
