import 'package:flutter/material.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/app/assets.gen.dart';

class WebTritPhonePictureLogo extends StatelessWidget {
  const WebTritPhonePictureLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final baseFontSize = themeData.textTheme.headline2!.fontSize!;
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: baseFontSize * 0.5,
          ),
          Assets.logo.svg(
            height: baseFontSize * 1.4,
          ),
          SizedBox(
            width: baseFontSize * 0.5,
          ),
          Text(
            EnvironmentConfig.APP_NAME,
            style: themeData.textTheme.headline2!.copyWith(
              color: themeData.colorScheme.secondary,
            ),
          ),
          SizedBox(
            width: baseFontSize * 0.5,
          ),
        ],
      ),
    );
  }
}

class WebTritPhoneTextLogo extends StatelessWidget {
  const WebTritPhoneTextLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          EnvironmentConfig.APP_NAME,
          style: themeData.textTheme.headline2,
        ),
        Text(
          'Phone',
          style: themeData.textTheme.headline4,
        ),
      ],
    );
  }
}
