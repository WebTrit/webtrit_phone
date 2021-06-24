import 'dart:io' show Platform;

import 'package:device_info/device_info.dart';

abstract class DeviceInfo {
  static DeviceInfo _instance;

  static Future<void> init() async {
    if (_instance == null) {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        _instance = _AndroidDeviceInfo(await deviceInfo.androidInfo);
      } else if (Platform.isIOS) {
        _instance = _IosDeviceInfo(await deviceInfo.iosInfo);
      } else {
        throw UnsupportedError('platform not supported');
      }
    }
  }

  factory DeviceInfo() {
    return _instance;
  }

  String get identifierForVendor;
}

class _AndroidDeviceInfo implements DeviceInfo {
  _AndroidDeviceInfo(this.androidDeviceInfo);

  final AndroidDeviceInfo androidDeviceInfo;

  @override
  String get identifierForVendor => androidDeviceInfo.androidId;
}

class _IosDeviceInfo implements DeviceInfo {
  _IosDeviceInfo(this.iodDeviceInfo);

  final IosDeviceInfo iodDeviceInfo;

  @override
  String get identifierForVendor => iodDeviceInfo.identifierForVendor;
}
