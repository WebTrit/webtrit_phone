import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import './keypad_view.dart';

class KeypadScaffold extends StatelessWidget {
  const KeypadScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: KeypadView(),
    );
  }
}
