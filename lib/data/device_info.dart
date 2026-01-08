import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('DeviceInfo');

abstract class DeviceInfo {
  Map<String, dynamic> get data;

  String get manufacturer;

  String get model;

  String get systemName;

  String get systemVersion;

  int? get sdkVersion;
}

class DeviceInfoFactory {
  static Future<DeviceInfo> init() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    late final Map<String, dynamic> deviceData;
    try {
      if (kIsWeb) {
        deviceData = _DeviceInfoImpl.readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else if (Platform.isAndroid) {
        deviceData = _DeviceInfoImpl.readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _DeviceInfoImpl.readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      } else if (Platform.isLinux) {
        deviceData = _DeviceInfoImpl.readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
      } else if (Platform.isMacOS) {
        deviceData = _DeviceInfoImpl.readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
      } else if (Platform.isWindows) {
        deviceData = _DeviceInfoImpl.readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
      } else {
        deviceData = {'error': 'unknown platform'};
      }
    } on PlatformException {
      deviceData = {'error': 'failed to get platform version'};
    }
    return _DeviceInfoImpl(deviceData);
  }
}

class _DeviceInfoImpl implements DeviceInfo {
  @override
  final Map<String, dynamic> data;

  _DeviceInfoImpl(this.data) {
    for (final entry in data.entries) {
      _logger.finest(() => '${entry.key}: ${entry.value}');
    }
  }

  @override
  String get manufacturer => data['manufacturer'] ?? 'unknown';

  @override
  String get model => data['model'] ?? 'unknown';

  @override
  String get systemName => data['systemName'] ?? 'unknown';

  @override
  String get systemVersion => data['systemVersion'] ?? 'unknown';

  @override
  int? get sdkVersion => data['sdkVersion'];

  static Map<String, dynamic> readWebBrowserInfo(WebBrowserInfo data) => {
    'browserName': data.browserName.name,
    'appCodeName': data.appCodeName,
    'appName': data.appName,
    'appVersion': data.appVersion,
    'deviceMemory': data.deviceMemory,
    'language': data.language,
    'languages': data.languages,
    'platform': data.platform,
    'product': data.product,
    'productSub': data.productSub,
    'userAgent': data.userAgent,
    'vendor': data.vendor,
    'vendorSub': data.vendorSub,
    'hardwareConcurrency': data.hardwareConcurrency,
    'maxTouchPoints': data.maxTouchPoints,
  };

  static Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) => {
    'manufacturer': build.manufacturer,
    'model': build.model,
    'systemName': 'Android',
    'systemVersion': build.version.release,
    'sdkVersion': build.version.sdkInt,
  };

  static Map<String, dynamic> readIosDeviceInfo(IosDeviceInfo data) => {
    'manufacturer': 'Apple',
    'model': data.model,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'sdkVersion': data.systemVersion.split('.').first,
  };

  static Map<String, dynamic> readLinuxDeviceInfo(LinuxDeviceInfo data) => {
    'manufacturer': 'Linux',
    'model': data.variant ?? 'unknown',
    'systemName': data.name,
    'systemVersion': data.version,
    'sdkVersion': data.versionId,
  };

  static Map<String, dynamic> readMacOsDeviceInfo(MacOsDeviceInfo data) => {
    'manufacturer': 'Apple',
    'model': data.model,
    'systemName': 'macOS',
    'systemVersion': data.osRelease,
  };

  static Map<String, dynamic> readWindowsDeviceInfo(WindowsDeviceInfo data) => {
    'manufacturer': 'Microsoft',
    'model': data.productName,
    'systemName': 'Windows',
    'systemVersion': data.displayVersion,
    'sdkVersion': data.buildNumber,
  };
}
