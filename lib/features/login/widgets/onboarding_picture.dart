import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

class OnboardingPicture extends StatelessWidget {
  const OnboardingPicture({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final loginOnboarding = themeData.extension<LogoAssets>()?.primaryOnboarding;
    final loginOnboardingHeight = themeData.textTheme.headlineSmall!.fontSize! * 10;

    return Container(
      height: mediaQueryData.size.height / 2.5,
      decoration: BoxDecoration(
        color: themeData.colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Center(
        child: loginOnboarding?.svg(height: loginOnboardingHeight) ?? SizedBox(height: loginOnboardingHeight),
      ),
    );
  }
}
