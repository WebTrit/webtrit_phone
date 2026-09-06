import 'dart:async';

import 'package:webtrit_phone/common/disposable.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/json/system_info_mapper.dart';
import 'package:webtrit_phone/models/models.dart';

abstract interface class SystemInfoLocalDatasource implements Disposable {
  WebtritSystemInfo? getSystemInfo();

  Future<void> setSystemInfo(WebtritSystemInfo systemInfo);

  Future<void> clear();
}

class SystemInfoLocalRepositoryPrefsImpl with SystemInfoJsonMapper implements SystemInfoLocalDatasource {
  SystemInfoLocalRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;

  @override
  WebtritSystemInfo? getSystemInfo() {
    final jsonString = _appPreferences.getSystemInfo();
    if (jsonString == null) return null;
    return systemInfoFromJson(jsonString);
  }

  @override
  Future<void> setSystemInfo(WebtritSystemInfo systemInfo) async {
    final jsonString = systemInfoToJson(systemInfo);
    await _appPreferences.setSystemInfo(jsonString);
  }

  @override
  Future<void> clear() async {
    await _appPreferences.removeSystemInfo();
  }

  @override
  Future<void> dispose() async {}
}
