import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import './keypad_view.dart';

class KeypadScreen extends StatelessWidget {
  const KeypadScreen({
    super.key,
    this.title,
  });

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: title,
      ),
      body: const KeypadView(),
    );
  }
}
