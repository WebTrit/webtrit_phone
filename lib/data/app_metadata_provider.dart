import 'package:webtrit_phone/data/data.dart';

abstract class AppMetadataProvider {
  Map<String, String> build();
}

class DefaultAppMetadataProvider implements AppMetadataProvider {
  static late DefaultAppMetadataProvider _instance;

  static Future<AppMetadataProvider> init(
    PackageInfo packageInfo,
    DeviceInfo deviceInfo,
    AppInfo appInfo,
    SecureStorage secureStorage, [
    FeatureAccess? featureAccess,
  ]) async {
    _instance = DefaultAppMetadataProvider._(packageInfo, deviceInfo, appInfo, secureStorage, featureAccess);
    return _instance;
  }

  factory DefaultAppMetadataProvider() {
    return _instance;
  }

  DefaultAppMetadataProvider._(
    this._packageInfo,
    this._deviceInfo,
    this._appInfo,
    this._secureStorage,
    this._featureAccess,
  );

  final PackageInfo _packageInfo;
  final DeviceInfo _deviceInfo;
  final AppInfo _appInfo;
  final SecureStorage _secureStorage;
  final FeatureAccess? _featureAccess;

  @override
  Map<String, String> build() {
    return _assemble();
  }

  Map<String, String> _assemble() {
    final token = _secureStorage.readToken();
    final coreUrl = _secureStorage.readCoreUrl();
    final tenantId = _secureStorage.readTenantId();
    final urls = _featureAccess?.embeddedFeature.embeddedResources.map((e) => e.uri.toString()).toList();

    return <String, String>{
      'app': _packageInfo.appName,
      'appVersion': _appInfo.version,
      'appSessionIdentifier': _appInfo.identifier,
      'storeVersion': _packageInfo.version,
      'packageName': _packageInfo.packageName,
      'buildNumber': _packageInfo.buildNumber,
      'manufacturer': _deviceInfo.manufacturer,
      'model': _deviceInfo.model,
      'os': _deviceInfo.systemName,
      'osVersion': _deviceInfo.systemVersion,
      'authorization': token != null ? 'authorized' : 'unauthorized',
      if (urls != null && urls.isNotEmpty) 'embeddedUrls': urls.join(', '),
      if (coreUrl != null) 'coreUrl': coreUrl,
      if (tenantId != null) 'tenantId': tenantId,
    };
  }
}
