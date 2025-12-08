import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import 'onboarding_logo_style.dart';

export 'onboarding_logo_style.dart';

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({super.key, this.style});

  final OnboardingLogoStyle? style;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final titleStyle = themeData.textTheme.headlineSmall!.merge(style?.textStyle);
    final scale = mediaQueryData.size.width * (style?.widthFactor ?? 0.2);
    return Align(
      alignment: Alignment.bottomCenter,
      child: WebTritPhonePictureLogo(
        asset: style?.picture,
        logoWidth: scale,
        titleStyle: titleStyle,
        padding: style?.padding ?? EdgeInsets.zero,
      ),
    );
  }
}
