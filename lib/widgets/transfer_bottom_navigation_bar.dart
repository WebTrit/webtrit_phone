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
        // Translucent so the blur behind it shows: opaque, the banner reads as
        // a strip pasted on the glass rather than part of it.
        color: themeData.colorScheme.secondary.withAlpha(200),
        child: Text(data, style: TextStyle(color: themeData.colorScheme.onSecondary)),
      ),
    );
  }
}
