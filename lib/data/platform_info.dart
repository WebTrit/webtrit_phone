import 'package:flutter/foundation.dart';

import 'package:webtrit_api/webtrit_api.dart';

// TODO: Convert to a singleton and move to utils
class PlatformInfo {
  PlatformInfo._();

  static PlatformInfo init() {
    return PlatformInfo._();
  }

  bool get isWeb => kIsWeb;

  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  bool get isFuchsia => defaultTargetPlatform == TargetPlatform.fuchsia;

  bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;

  bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;

  bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;

  bool get isDesktop => isMacOS || isLinux || isWindows;

  bool get isMobile => isIOS || isAndroid;

  AppType get appType {
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
