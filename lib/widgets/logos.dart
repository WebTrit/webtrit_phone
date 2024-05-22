import 'package:flutter/material.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/theme/theme.dart';

class WebTritPhonePictureLogo extends StatelessWidget {
  const WebTritPhonePictureLogo({
    super.key,
    this.asset,
    this.text,
    this.logoWidth,
    this.logoHeight,
    this.logoFit = BoxFit.contain,
    this.logoAlignment = Alignment.center,
    this.dividerHeight,
    required this.titleStyle,
  });

  final ThemeSvgAsset? asset;
  final String? text;
  final double? logoWidth;
  final double? logoHeight;
  final BoxFit logoFit;
  final AlignmentGeometry logoAlignment;
  final double? dividerHeight;
  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    final fontSize = titleStyle.fontSize!;
    final logoHeight = this.logoHeight ?? (logoWidth == null ? fontSize * 2.2 : null);
    final svg = asset?.svg(width: logoWidth, height: logoHeight, fit: logoFit, alignment: logoAlignment);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (svg != null) svg,
        const SizedBox(),
        if (text != null) ...[
          SizedBox(
            height: dividerHeight ?? fontSize / 3,
          ),
          Text(
            text!,
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
        ],
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
