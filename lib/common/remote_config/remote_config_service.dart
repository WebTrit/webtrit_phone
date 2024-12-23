abstract class RemoteConfigService {
  String? getString(String key);

  bool? getBool(String key);
}

abstract class RemoteCacheConfigService extends RemoteConfigService {
  Future<void> cacheString(String key, String value);

  Future<void> cacheBool(String key, bool value);
}
