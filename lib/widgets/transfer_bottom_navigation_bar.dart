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
      color: themeData.colorScheme.secondary,
      child: Text(data, style: TextStyle(color: themeData.colorScheme.onSecondary)),
    );
  }
}
