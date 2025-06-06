import 'package:flutter/material.dart';

class HistoryFetchIndicator extends StatelessWidget {
  const HistoryFetchIndicator(this.fetchingHistory, {super.key});

  final bool fetchingHistory;

  @override
  Widget build(BuildContext context) {
    if (fetchingHistory) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
