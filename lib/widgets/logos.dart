import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/theme/theme.dart';

import 'sized_circular_progress_indicator.dart';

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
    final logo = themeData.extension<GenImages>()?.logo;
    final logoHeight = this.logoHeight ?? (logoWidth == null ? fontSize * 2.2 : null);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<SvgLoader?>(
          stream: logo,
          builder: (BuildContext context, AsyncSnapshot<SvgLoader?> snapshot) {
            if (snapshot.hasError) {
              return SizedBox(
                height: logoHeight,
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return SizedBox(
                  height: logoHeight,
                );
              case ConnectionState.waiting:
                return SizedCircularProgressIndicator(
                  size: themeData.textTheme.bodyMedium!.fontSize!,
                  strokeWidth: 2,
                );

              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.data != null) {
                  final svg = snapshot.data as BytesLoader;
                  return SvgPicture(
                    svg,
                    height: logoHeight,
                    width: logoWidth,
                  );
                } else {
                  return SizedBox(
                    height: logoHeight,
                  );
                }
            }
          },
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
