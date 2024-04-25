import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import 'onboarding_logo_style.dart';
import 'onboarding_logo_styles.dart';

export 'onboarding_logo_style.dart';
export 'onboarding_logo_styles.dart';

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({
    super.key,
    this.style,
  });

  final OnboardingLogoStyle? style;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final localStyle = style ?? themeData.extension<OnboardingLogoStyles>()?.primary;
    final titleStyle = themeData.textTheme.headlineSmall!.merge(localStyle?.textStyle);
    final scale = mediaQueryData.size.height * (localStyle?.scale ?? 0.25);
    return SizedBox(
      height: scale,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: WebTritPhonePictureLogo(
          asset: localStyle?.picture,
          titleStyle: titleStyle,
        ),
      ),
    );
  }
}
