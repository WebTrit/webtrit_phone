import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/json/system_info_mapper.dart';
import 'package:webtrit_phone/models/system_info/system_info.dart';

abstract interface class SystemInfoLocalRepository {
  WebtritSystemInfo? getSystemInfo();
  Future<void> setSystemInfo(WebtritSystemInfo systemInfo);
  Future<void> clear();
}

class SystemInfoLocalRepositoryPrefsImpl with SystemInfoJsonMapper implements SystemInfoLocalRepository {
  SystemInfoLocalRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'system-info';

  @override
  WebtritSystemInfo? getSystemInfo() {
    final jsonString = _appPreferences.getString(_prefsKey);
    if (jsonString == null) return null;
    return systemInfoFromJson(jsonString);
  }

  @override
  Future<void> setSystemInfo(WebtritSystemInfo systemInfo) {
    final jsonString = systemInfoToJson(systemInfo);
    return _appPreferences.setString(_prefsKey, jsonString);
  }

  @override
  Future<void> clear() {
    return _appPreferences.remove(_prefsKey);
  }
}
