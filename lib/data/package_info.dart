import 'package:package_info_plus/package_info_plus.dart' as plugin;

abstract class PackageInfo {
  String get appName;

  String get packageName;

  String get version;

  String get buildNumber;
}

extension PackageInfoFullVersion on PackageInfo {
  /// Full build version as shipped to the store: versionName plus versionCode
  /// (e.g. "4.4.9+449000002"). Same composition the diagnostic appInfo string
  /// uses in the app metadata provider.
  String get fullVersion => '$version+$buildNumber';
}

class PackageInfoFactory {
  static Future<PackageInfo> init() async {
    return PackageInfoImpl(await plugin.PackageInfo.fromPlatform());
  }
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
