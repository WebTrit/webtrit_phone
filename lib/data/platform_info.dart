import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:webtrit_api/webtrit_api.dart';

class PlatformInfo {
  static final PlatformInfo _instance = PlatformInfo._();

  PlatformInfo._();

  factory PlatformInfo() {
    return _instance;
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

  //
  // Additional platform specific properties and methods can be added here
  //
  /// Returns true if the current platform is `MIUI`
  Future<bool> isMiui() async {
    if (!isAndroid) return false;
    final miuiProp = await Process.run('getprop', ['ro.miui.ui.version.name']);
    return miuiProp.stdout.toString().trim().isNotEmpty;
  }
}
