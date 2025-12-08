import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import 'onboarding_picture_logo_style.dart';

export 'onboarding_picture_logo_style.dart';

class OnboardingPictureLogo extends StatelessWidget {
  const OnboardingPictureLogo({super.key, this.text, this.style});

  final String? text;

  final OnboardingPictureLogoStyle? style;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final localStyle = style;

    final titleStyle = themeData.textTheme.displayMedium!.merge(localStyle?.textStyle);
    final widthFactor = mediaQueryData.size.width * (localStyle?.widthFactor ?? 0.25);
    final picture = localStyle?.picture;

    return WebTritPhonePictureLogo(
      asset: picture,
      text: text,
      logoWidth: widthFactor,
      dividerHeight: titleStyle.fontSize,
      titleStyle: titleStyle,
      padding: style?.padding ?? EdgeInsets.zero,
    );
  }
}
