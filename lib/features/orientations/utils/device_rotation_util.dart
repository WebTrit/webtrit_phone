import 'package:device_auto_rotate/device_auto_rotate.dart';

class DeviceRotationUtil {
  const DeviceRotationUtil();

  Stream<bool> get stream => DeviceAutoRotate.stream;

  Future<bool> get isEnabled => DeviceAutoRotate.isEnabled;
}
