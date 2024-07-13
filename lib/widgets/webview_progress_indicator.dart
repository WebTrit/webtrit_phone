import 'package:flutter/material.dart';

class WebViewProgressIndicator extends StatelessWidget {
  const WebViewProgressIndicator({
    super.key,
    required this.stream,
  });

  final Stream<int> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stream,
      builder: (context, snapshot) {
        final snapshotData = snapshot.data;
        double progressValue = 0.0;
        if (snapshotData != null) {
          if (snapshotData == 100) {
            return const SizedBox();
          }
          progressValue = snapshotData / 100;
        }
        return LinearProgressIndicator(
          value: progressValue,
          minHeight: 2.0,
        );
      },
    );
  }
}
