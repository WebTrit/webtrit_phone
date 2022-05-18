import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/assets.gen.dart';

class OnboardingPicture extends StatelessWidget {
  const OnboardingPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    return Container(
      height: mediaQueryData.size.height / 2.5,
      decoration: BoxDecoration(
        color: themeData.colorScheme.background,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Center(
        child: Assets.login.onboarding1.svg(
          height: themeData.textTheme.headline5!.fontSize! * 10,
        ),
      ),
    );
  }
}
