import 'package:flutter/material.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'mobile/keypad_screen.dart' as mobile;
import 'web/keypad_screen.dart' as desktop;

class KeypadScreen extends StatelessWidget {
  const KeypadScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobileScreen: mobile.KeypadScreen(),
      desktopScreen: desktop.KeypadScreen(),
    );
  }
}
