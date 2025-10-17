import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

// TODO: Create a common image widget to centralize scaling, alignment, padding, and related properties.
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
    this.padding = EdgeInsets.zero,
  });

  final ThemeSvgAsset? asset;
  final String? text;
  final double? logoWidth;
  final double? logoHeight;
  final BoxFit logoFit;
  final AlignmentGeometry logoAlignment;
  final double? dividerHeight;
  final TextStyle titleStyle;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final fontSize = titleStyle.fontSize!;
    final logoHeight = this.logoHeight ?? (logoWidth == null ? fontSize * 2.2 : null);
    final svg = asset?.svg(width: logoWidth, height: logoHeight, fit: logoFit, alignment: logoAlignment);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (svg != null) Padding(padding: padding, child: svg),
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
