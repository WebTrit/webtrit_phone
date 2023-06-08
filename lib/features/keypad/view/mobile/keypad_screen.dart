import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import 'keypad_view.dart';

class KeypadScreen extends StatelessWidget {
  const KeypadScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: const KeypadView(),
    );
  }
}
