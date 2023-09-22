import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class OnboardingPictureLogo extends StatelessWidget {
  const OnboardingPictureLogo({
    super.key,
    this.color,
    this.text,
  });

  final Color? color;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final titleStyle = themeData.textTheme.displayMedium!.copyWith(
      color: color,
      fontWeight: FontWeight.w600,
    );
    final logo = themeData.extension<LogoAssets>()!.primaryOnboarding;
    return WebTritPhonePictureLogo(
      asset: logo,
      text: text,
      logoWidth: mediaQueryData.size.width * 0.42,
      dividerHeight: titleStyle.fontSize,
      titleStyle: titleStyle,
    );
  }
}
