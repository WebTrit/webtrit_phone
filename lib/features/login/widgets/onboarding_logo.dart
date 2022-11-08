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
    final themeData = Theme.of(context);
    final titleStyle = themeData.textTheme.headlineSmall!.copyWith(
      color: color,
    );
    return SizedBox(
      height: mediaQueryData.size.height / 4,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: WebTritPhonePictureLogo(
          titleStyle: titleStyle,
        ),
      ),
    );
  }
}
