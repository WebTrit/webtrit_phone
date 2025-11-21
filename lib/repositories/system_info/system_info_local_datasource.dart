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
  final _prefsKey = 'system-info';

  final _controller = StreamController<WebtritSystemInfo?>.broadcast();

  @override
  WebtritSystemInfo? getSystemInfo() {
    final jsonString = _appPreferences.getString(_prefsKey);
    if (jsonString == null) return null;
    return systemInfoFromJson(jsonString);
  }

  @override
  Future<void> setSystemInfo(WebtritSystemInfo systemInfo) async {
    final jsonString = systemInfoToJson(systemInfo);
    await _appPreferences.setString(_prefsKey, jsonString);
    _controller.add(systemInfo);
  }

  @override
  Future<void> clear() async {
    await _appPreferences.remove(_prefsKey);
    _controller.add(null);
  }

  @override
  Future<void> dispose() async {
    _controller.close();
  }
}
