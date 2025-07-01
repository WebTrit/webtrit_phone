import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import './keypad_view.dart';

class KeypadScreen extends StatelessWidget {
  const KeypadScreen({
    super.key,
    this.title,
    required this.videoEnabled,
    required this.transferEnabled,
  });

  final Widget? title;
  final bool videoEnabled;
  final bool transferEnabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: title,
        context: context,
      ),
      body: KeypadView(
        videoEnabled: videoEnabled,
        transferEnabled: transferEnabled,
      ),
    );
  }
}
