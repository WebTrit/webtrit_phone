import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/app/core_version.dart';

mixin SystemInfoMixin {
  void verifyCoreVersion(SystemInfo systemInfo) {
    final actualCoreVersion = systemInfo.core.version;
    CoreVersion.supported().verify(actualCoreVersion);
  }
}
