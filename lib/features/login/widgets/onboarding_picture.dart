import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/styles/app_colors.dart';

class OnboardingPicture extends StatelessWidget {
  const OnboardingPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    return Container(
      height: mediaQueryData.size.height / 2.5,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Center(
        child: Assets.loginGirl.svg(
          height: themeData.textTheme.headline5!.fontSize! * 10,
        ),
      ),
    );
  }
}
