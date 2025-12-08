import 'package:flutter/material.dart';

class CountDownBuilder extends StatelessWidget {
  const CountDownBuilder({super.key, required this.start, required this.interval, required this.builder});

  final DateTime start;
  final Duration interval;
  final Widget Function(BuildContext context, int counter) builder;

  @override
  Widget build(BuildContext context) {
    final elapsed = DateTime.now().difference(start);

    var remain = interval - elapsed;
    if (remain <= Duration.zero) {
      return builder(context, 0);
    } else {
      return StreamBuilder<int>(
        stream: Stream.periodic(const Duration(seconds: 1), (i) => remain.inSeconds - i - 1).take(remain.inSeconds),
        builder: (context, snapshot) {
          final seconds = snapshot.connectionState == ConnectionState.waiting
              ? remain.inSeconds
              : snapshot.data ?? remain.inSeconds;
          return builder(context, seconds);
        },
      );
    }
  }
}
