import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/assets.gen.dart';
import '../theme_settings.dart';

class ImagesSchemeModel {
  ImagesSchemeModel({
    this.adaptiveIconBackground,
    this.iosLauncherIcon,
    this.onboarding,
    this.androidLauncherIcon,
    this.notificationLogo,
    this.applicationLogo,
    this.adaptiveIconForeground,
    this.webLauncherIcon,
  });

  ImagesSchemeModel.fromJson(dynamic json) {
    adaptiveIconBackground = json['adaptiveIconBackground'];
    iosLauncherIcon = json['iosLauncherIcon'];
    onboarding = json['onboarding'];
    androidLauncherIcon = json['androidLauncherIcon'];
    notificationLogo = json['notificationLogo'];
    applicationLogo = json['applicationLogo'];
    adaptiveIconForeground = json['adaptiveIconForeground'];
    webLauncherIcon = json['webLauncherIcon'];
  }

  String? adaptiveIconBackground;
  String? iosLauncherIcon;
  String? onboarding;
  String? androidLauncherIcon;
  String? notificationLogo;
  String? applicationLogo;
  String? adaptiveIconForeground;
  String? webLauncherIcon;

  final onboardingStream = ReplaySubject<SvgLoader>();
  final applicationLogoStream = ReplaySubject<SvgLoader>();

  ImagesScheme get imagesScheme => ImagesScheme(
        onboarding: onboardingStream,
        applicationLogo: applicationLogoStream,
      );

  void prepare() {
    _update(applicationLogoStream, applicationLogo, Assets.logo);
    _update(onboardingStream, onboarding, Assets.login.onboarding1);
  }

  void _update(ReplaySubject stream, String? image, SvgGenImage defaultImage) async {
    if (image == null) {
      stream.add(SvgAssetLoader(defaultImage.path));
    } else {
      stream.add((SvgNetworkLoader(image)));
    }
  }
}
