import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';

class TransferBottomNavigationBar extends StatelessWidget {
  const TransferBottomNavigationBar(this.data, {super.key});

  final String data;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(kMainAppBarBottomPaddingGap),
      // Translucent on purpose: it is laid over a backdrop blur, and an opaque
      // fill would hide it and read as a solid strip pasted on the glass. The
      // alpha matches the bar it sits above.
      color: themeData.colorScheme.secondary.withAlpha(200),
      child: Text(data, style: TextStyle(color: themeData.colorScheme.onSecondary)),
    );
  }
}
