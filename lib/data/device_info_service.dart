import 'package:device_info_plus/device_info_plus.dart';
import 'platform_info.dart';

class DeviceInfoService {
  int? _cachedAndroidSdkVersion;

  Future<bool> isAndroidVersionAtLeast(int targetVersion) async {
    if (PlatformInfo().isWeb) return false;
    if (!PlatformInfo().isAndroid) return false;
    final sdk = await getAndroidSdkVersion();
    if (sdk == null) return false;
    return sdk >= targetVersion;
  }

  Future<int?> getAndroidSdkVersion() async {
    if (PlatformInfo().isWeb) return null;
    if (!PlatformInfo().isAndroid) return null;
    if (_cachedAndroidSdkVersion != null) return _cachedAndroidSdkVersion;
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    _cachedAndroidSdkVersion = androidInfo.version.sdkInt;
    return _cachedAndroidSdkVersion;
  }
}
