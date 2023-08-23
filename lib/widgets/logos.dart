import 'package:flutter/material.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/theme/theme.dart';

class WebTritPhonePictureLogo extends StatelessWidget {
  const WebTritPhonePictureLogo({
    super.key,
    this.logoWidth,
    this.logoHeight,
    this.logoFit = BoxFit.contain,
    this.logoAlignment = Alignment.center,
    this.dividerHeight,
    required this.titleStyle,
  });

  final double? logoWidth;
  final double? logoHeight;
  final BoxFit logoFit;
  final AlignmentGeometry logoAlignment;
  final double? dividerHeight;
  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    final fontSize = titleStyle.fontSize!;
    final themeData = Theme.of(context);
    final logo = themeData.extension<LogoAssets>()!.primaryOnboarding;
    final logoHeight = this.logoHeight ?? (logoWidth == null ? fontSize * 2.2 : null);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        logo.svg(
          width: logoWidth,
          height: logoHeight,
          fit: logoFit,
          alignment: logoAlignment,
        ),
        SizedBox(
          height: dividerHeight ?? fontSize / 3,
        ),
        Text(
          EnvironmentConfig.APP_NAME,
          style: titleStyle,
        ),
      ],
    );
  }
}

class WebTritPhoneTextLogo extends StatelessWidget {
  const WebTritPhoneTextLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          EnvironmentConfig.APP_NAME,
          style: themeData.textTheme.displayMedium,
        ),
        Text(
          'Phone',
          style: themeData.textTheme.headlineMedium,
        ),
      ],
    );
  }
}
