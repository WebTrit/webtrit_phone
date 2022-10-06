import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return SizedBox(
      height: mediaQueryData.size.height / 7,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: WebTritPhonePictureLogo(
          color: color,
        ),
      ),
    );
  }
}
