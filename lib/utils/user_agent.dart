import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';

class UserAgent {
  static String of(BuildContext context) {
    final packageInfo = context.read<PackageInfo>();
    final deviceInfo = context.read<DeviceInfo>();

    return '${packageInfo.appName}/${packageInfo.version} (${deviceInfo.systemName}; ${deviceInfo.systemVersion})';
  }
}
