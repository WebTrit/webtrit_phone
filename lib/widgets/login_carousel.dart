import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/styles/app_colors.dart';

import '../environment_config.dart';

class LoginCarouselPictureLogo extends StatelessWidget {
  const LoginCarouselPictureLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    return SizedBox(
      height: mediaQueryData.size.height / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.logo.svg(
            height: themeData.textTheme.headline5!.fontSize! * 2.2,
          ),
          Text(
            EnvironmentConfig.APP_NAME,
            style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
