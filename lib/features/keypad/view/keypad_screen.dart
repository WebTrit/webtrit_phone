import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import './keypad_view.dart';

class KeypadScreen extends StatelessWidget {
  const KeypadScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final appName = themeData.extension<ConstTexts>()?.appName;

    return Scaffold(
      appBar: MainAppBar(
        name: appName,
      ),
      body: const KeypadView(),
    );
  }
}
