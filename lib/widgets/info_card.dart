import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    this.icon,
    required this.text,
    this.button,
  });

  final Icon? icon;
  final Widget text;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: kAllPadding16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) icon!,
            Padding(
              padding: kAllPadding16,
              child: text,
            ),
            if (button != null) button!,
          ],
        ),
      ),
    );
  }
}
