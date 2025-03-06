import 'package:package_info_plus/package_info_plus.dart' as plugin;

abstract class PackageInfo {
  String get appName;

  String get packageName;

  String get version;

  String get buildNumber;
}

class PackageInfoFactory {
  static late PackageInfo _instance;

  static Future<PackageInfo> init() async {
    _instance = PackageInfoImpl(await plugin.PackageInfo.fromPlatform());
    return _instance;
  }

  static PackageInfo get instance => _instance;
}

class PackageInfoImpl implements PackageInfo {
  final plugin.PackageInfo _pluginPackageInfo;

  PackageInfoImpl(this._pluginPackageInfo);

  @override
  String get appName => _pluginPackageInfo.appName;

  @override
  String get packageName => _pluginPackageInfo.packageName;

  @override
  String get version => _pluginPackageInfo.version;

  @override
  String get buildNumber => _pluginPackageInfo.buildNumber;
}
