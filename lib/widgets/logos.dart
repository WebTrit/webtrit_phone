import 'package:flutter/material.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/gen/assets.gen.dart';

class WebTritPhonePictureLogo extends StatelessWidget {
  const WebTritPhonePictureLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.logo.svg(
          height: themeData.textTheme.headline2!.fontSize! * 1.4,
          color: themeData.colorScheme.secondary,
        ),
        SizedBox(
          width: themeData.textTheme.headline2!.fontSize! * 0.5,
        ),
        Text(
          EnvironmentConfig.WEBTRIT_APP_NAME,
          style: themeData.textTheme.headline2!.copyWith(
            color: themeData.colorScheme.secondary,
          ),
        ),
      ],
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
          EnvironmentConfig.WEBTRIT_APP_NAME,
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
