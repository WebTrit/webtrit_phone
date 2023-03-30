import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class OnboardingPicture extends StatelessWidget {
  const OnboardingPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final loginOnboarding = themeData.extension<GenImages>()?.loginOnboarding;
    final loginOnboardingHeight = themeData.textTheme.headlineSmall!.fontSize! * 10;

    return Container(
      height: mediaQueryData.size.height / 2.5,
      decoration: BoxDecoration(
        color: themeData.colorScheme.background,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: StreamBuilder<SvgLoader?>(
        stream: loginOnboarding,
        builder: (BuildContext context, AsyncSnapshot<SvgLoader?> snapshot) {
          if (snapshot.hasError) {
            return SizedBox(
              height: loginOnboardingHeight,
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return SizedBox(
                height: loginOnboardingHeight,
              );
            case ConnectionState.waiting:
              return SizedCircularProgressIndicator(
                size: themeData.textTheme.bodyMedium!.fontSize!,
                strokeWidth: 2,
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.data != null) {
                return SvgPicture(
                  snapshot.data!,
                  height: loginOnboardingHeight,
                );
              } else {
                return SizedBox(
                  height: loginOnboardingHeight,
                );
              }
          }
        },
      ),
    );
  }
}
