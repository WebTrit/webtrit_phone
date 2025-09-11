import 'package:webtrit_phone/data/data.dart';

abstract class AppLabelsProvider {
  Map<String, String> build();
}

class DefaultAppLabelsProvider implements AppLabelsProvider {
  static late DefaultAppLabelsProvider _instance;

  static Future<DefaultAppLabelsProvider> init(
    PackageInfo packageInfo,
    DeviceInfo deviceInfo,
    AppInfo appInfo,
    SecureStorage secureStorage,
  ) async {
    _instance = DefaultAppLabelsProvider._(
      packageInfo,
      deviceInfo,
      appInfo,
      secureStorage,
    );
    return _instance;
  }

  factory DefaultAppLabelsProvider() {
    return _instance;
  }

  DefaultAppLabelsProvider._(
    this._packageInfo,
    this._deviceInfo,
    this._appInfo,
    this._secureStorage,
  );

  final PackageInfo _packageInfo;
  final DeviceInfo _deviceInfo;
  final AppInfo _appInfo;
  final SecureStorage _secureStorage;

  @override
  Map<String, String> build() {
    return _assemble();
  }

  Map<String, String> _assemble() {
    final token = _secureStorage.readToken();
    final coreUrl = _secureStorage.readCoreUrl();
    final tenantId = _secureStorage.readTenantId();

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
      if (coreUrl != null) 'coreUrl': coreUrl,
      if (tenantId != null) 'tenantId': tenantId,
    };
  }
}
