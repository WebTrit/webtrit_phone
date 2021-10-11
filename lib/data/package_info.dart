import 'dart:io' show Platform;

import 'package:package_info_plus/package_info_plus.dart' as plugin;

class PackageInfo {
  static late PackageInfo _instance;

  static Future<void> init() async {
    _instance = PackageInfo._(await plugin.PackageInfo.fromPlatform());
  }

  factory PackageInfo() {
    return _instance;
  }

  const PackageInfo._(this._pluginPackageInfo);

  final plugin.PackageInfo _pluginPackageInfo;

  String get appName => _pluginPackageInfo.appName;

  String get packageName => _pluginPackageInfo.packageName;

  String get version => _pluginPackageInfo.version;

  String get buildNumber => _pluginPackageInfo.buildNumber;
}
