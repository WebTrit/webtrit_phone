import 'package:webtrit_phone/data/data.dart';

/// Provides application metadata, including device information,
/// package details, and configuration labels.
abstract class AppMetadataProvider {
  /// Builds a map of labels containing diagnostic and environment information.
  ///
  /// These labels are typically used for logging or appending metadata
  /// to external requests.
  Map<String, String> get logLabels;

  /// Returns a formatted string representing the device and app version
  /// for Presence settings.
  ///
  /// Format: `AppName vVersion on Model (OS)`
  String get presenceDeviceName;

  /// Returns a formatted User-Agent string for HTTP requests and Presence.
  ///
  /// Format: `AppName/AppVersion (Model; OSName: OSVersion)`
  String get userAgent;
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
  Map<String, String> get logLabels {
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

  @override
  String get presenceDeviceName {
    return '${_packageInfo.appName} v${_packageInfo.version} on ${_deviceInfo.model} (${_deviceInfo.systemName})';
  }

  @override
  String get userAgent {
    return '${_packageInfo.appName}/${_appInfo.version} (${_deviceInfo.model}; ${_deviceInfo.systemName}: ${_deviceInfo.systemVersion})';
  }
}
