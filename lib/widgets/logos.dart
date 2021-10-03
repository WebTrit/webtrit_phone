import 'package:flutter/material.dart';

import 'package:webtrit_phone/gen/assets.gen.dart';

class WebTritPhonePictureLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Assets.logo.svg(
          height: themeData.textTheme.headline2!.fontSize! * 1.4,
          color: themeData.accentColor,
        ),
        SizedBox(
          width: themeData.textTheme.headline2!.fontSize! * 0.5,
        ),
        Text(
          'WebTrit',
          style: themeData.textTheme.headline2!.copyWith(
            color: themeData.accentColor,
          ),
        ),
      ],
    );
  }
}

class WebTritPhoneTextLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          'WebTrit',
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
