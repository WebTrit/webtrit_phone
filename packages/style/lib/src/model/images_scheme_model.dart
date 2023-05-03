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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adaptiveIconBackground'] = adaptiveIconBackground;
    map['iosLauncherIcon'] = iosLauncherIcon;
    map['onboarding'] = onboarding;
    map['androidLauncherIcon'] = androidLauncherIcon;
    map['notificationLogo'] = notificationLogo;
    map['applicationLogo'] = applicationLogo;
    map['adaptiveIconForeground'] = adaptiveIconForeground;
    map['webLauncherIcon'] = webLauncherIcon;
    return map;
  }
}
