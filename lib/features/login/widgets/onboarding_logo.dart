import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
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
    final logo = themeData.extension<GenImages>()?.logoV2;

    return SizedBox(
      height: mediaQueryData.size.height / 4,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: WebTritPhonePictureLogo(
          logo: logo,
          logoWidth: mediaQueryData.size.width * 0.42,
          dividerHeight: 32,
          logoHeight: 48,
        ),
      ),
    );
  }
}
