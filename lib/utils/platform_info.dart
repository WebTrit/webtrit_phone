import 'package:flutter/foundation.dart';

import 'package:webtrit_api/webtrit_api.dart';

class PlatformInfo {
  static bool get isWeb => kIsWeb;

  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  static bool get isFuchsia => defaultTargetPlatform == TargetPlatform.fuchsia;

  static bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;

  static bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;

  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;

  static bool get isDesktop => isMacOS || isLinux || isWindows;

  static bool get isMobile => isIOS || isAndroid;

  static AppType get appType {
    if (isWeb) {
      return AppType.web;
    } else if (isLinux) {
      return AppType.linux;
    } else if (isMacOS) {
      return AppType.macos;
    } else if (isWindows) {
      return AppType.windows;
    } else if (isAndroid) {
      return AppType.android;
    } else if (isIOS) {
      return AppType.ios;
    } else {
      throw UnsupportedError('Current platform unsupported');
    }
  }
}
