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
  SystemInfoLocalRepositoryPrefsImpl(this._secureStorage);

  final SecureStorage _secureStorage;

  final _controller = StreamController<WebtritSystemInfo?>.broadcast();

  @override
  WebtritSystemInfo? getSystemInfo() {
    final jsonString = _secureStorage.readSystemInfo();
    if (jsonString == null) return null;
    return systemInfoFromJson(jsonString);
  }

  @override
  Future<void> setSystemInfo(WebtritSystemInfo systemInfo) async {
    final jsonString = systemInfoToJson(systemInfo);
    await _secureStorage.writeSystemInfo(jsonString);
    _controller.add(systemInfo);
  }

  @override
  Future<void> clear() async {
    await _secureStorage.deleteSystemInfo();
    _controller.add(null);
  }

  @override
  Future<void> dispose() async {
    _controller.close();
  }
}
