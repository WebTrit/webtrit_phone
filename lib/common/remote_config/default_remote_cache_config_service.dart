import 'package:shared_preferences/shared_preferences.dart';

import 'remote_config_service.dart';

class DefaultRemoteCacheConfigService implements RemoteCacheConfigService {
  final SharedPreferences _sharedPreferences;

  DefaultRemoteCacheConfigService(this._sharedPreferences);

  static Future<RemoteCacheConfigService> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return DefaultRemoteCacheConfigService(sharedPreferences);
  }

  @override
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  @override
  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  @override
  Future<void> cacheString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<void> cacheBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }
}
