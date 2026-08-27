import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';

class TransferBottomNavigationBar extends StatelessWidget {
  const TransferBottomNavigationBar(this.data, {super.key});

  final String data;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    // A state that appears and disappears on its own, not something to reach:
    // read out when it arrives, or someone listening is left picking a
    // destination with no idea a transfer is under way.
    return Semantics(
      liveRegion: true,
      container: true,
      child: Container(
        padding: const EdgeInsets.all(kMainAppBarBottomPaddingGap),
        color: themeData.colorScheme.secondary.withAlpha(kBottomSurfaceAlpha),
        child: Text(data, style: TextStyle(color: themeData.colorScheme.onSecondary)),
      ),
    );
  }
}
