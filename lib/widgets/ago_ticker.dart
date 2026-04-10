import 'dart:async';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

class AgoTicker extends StatefulWidget {
  const AgoTicker({required this.timestamp, required this.builder, super.key});

  final DateTime timestamp;
  final Widget Function(String ago) builder;

  @override
  State<AgoTicker> createState() => _AgoTickerState();
}

class _AgoTickerState extends State<AgoTicker> {
  late Duration _elapsed;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _elapsed = DateTime.now().difference(widget.timestamp);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _onTick());
  }

  void _onTick() {
    final newElapsed = DateTime.now().difference(widget.timestamp);
    if (newElapsed.inSeconds != _elapsed.inSeconds) {
      setState(() => _elapsed = newElapsed);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (_elapsed.inSeconds < 60) {
      return widget.builder(l10n.agoTicker_secondsAgo(_elapsed.inSeconds));
    } else if (_elapsed.inMinutes < 60) {
      return widget.builder(l10n.agoTicker_minutesAgo(_elapsed.inMinutes));
    } else if (_elapsed.inHours < 24) {
      return widget.builder(l10n.agoTicker_hoursAgo(_elapsed.inHours));
    } else {
      return widget.builder(l10n.agoTicker_daysAgo(_elapsed.inDays));
    }
  }
}
