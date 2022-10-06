import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

class CountDownBuilder extends StatefulWidget {
  const CountDownBuilder({
    Key? key,
    required this.interval,
    required this.builder,
  }) : super(key: key);

  final Duration interval;
  final Widget Function(BuildContext context, int counter) builder;

  @override
  State<CountDownBuilder> createState() => _CountDownBuilderState();
}

class _CountDownBuilderState extends State<CountDownBuilder> {
  late Stream<int> intervalStream;

  @override
  void initState() {
    super.initState();
    intervalStream = Stream.fromIterable(
      Iterable<int>.generate(
        widget.interval.inSeconds,
        (i) => widget.interval.inSeconds - i - 1,
      ),
    ).interval(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: intervalStream,
      builder: (context, snapshot) {
        final seconds = snapshot.connectionState == ConnectionState.waiting
            ? widget.interval.inSeconds
            : snapshot.data ?? widget.interval.inSeconds;
        return widget.builder(context, seconds);
      },
    );
  }
}
