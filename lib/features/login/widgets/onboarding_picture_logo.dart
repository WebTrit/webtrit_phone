import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class OnboardingPictureLogo extends StatelessWidget {
  const OnboardingPictureLogo({
    super.key,
    this.text,
    this.style,
  });

  final String? text;

  final OnboardingPictureLogoStyle? style;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final localStyle = style ?? themeData.extension<OnboardingPictureLogoStyles>()?.primary;

    final titleStyle = themeData.textTheme.displayMedium!.merge(localStyle?.textStyle);
    final scale = mediaQueryData.size.width * (localStyle?.scale ?? 0.42);
    final picture = localStyle?.picture;

    return WebTritPhonePictureLogo(
      asset: picture,
      text: text,
      logoWidth: scale,
      dividerHeight: titleStyle.fontSize,
      titleStyle: titleStyle,
    );
  }
}
