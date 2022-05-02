import 'package:flutter/material.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/app/assets.gen.dart';

class WebTritPhonePictureLogo extends StatelessWidget {
  const WebTritPhonePictureLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    return SizedBox(
      height: mediaQueryData.size.height / 3,
      child: Column(
        children: [
          Spacer(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.logo.svg(
                  height: themeData.textTheme.headline5!.fontSize! * 2.2,
                ),
                Text(
                  EnvironmentConfig.APP_NAME,
                  style: themeData.textTheme.headline5,
                ),
              ],
            ),
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
